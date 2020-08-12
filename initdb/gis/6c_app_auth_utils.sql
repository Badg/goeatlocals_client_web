-- TODO: make this a security definer function instead of just a utility
-- function
CREATE OR REPLACE FUNCTION app_auth.make_magic_token(
user_id uuid, token_type text)
RETURNS uuid AS $$
    INSERT INTO app_auth.magic_tokens(user_id, token_type)
    VALUES (user_id, token_type::app_auth.token_link_type)
    ON CONFLICT (user_id, token_type) DO UPDATE
        SET token_id = gen_random_uuid(),
            issued_timestamp = current_timestamp
    RETURNING token_id;
$$ LANGUAGE SQL
VOLATILE
PARALLEL UNSAFE;


-- TODO: make this a security definer function instead of just a utility
-- function
CREATE OR REPLACE FUNCTION app_auth.validate_session(
validate_user_id uuid, validate_session_id uuid)
RETURNS bool AS $$
BEGIN
    UPDATE app_auth.user_sessions
    SET last_validated = current_timestamp
    WHERE session_id = validate_session_id AND user_id = validate_user_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Invalid session!';

    RETURN FOUND;
END
$$ LANGUAGE plpgsql
VOLATILE
PARALLEL UNSAFE;


-- TODO: make this a security definer function instead of just a utility
-- function
CREATE OR REPLACE FUNCTION app_auth.make_provisional_user(
    provisional_email text)
RETURNS app_auth.provisional_user AS $$
DECLARE
    provisional_token_id    uuid;
    provisional_user_id     uuid;
    provisional_result      app_auth.provisional_user%ROWTYPE;
-- Note: this is part of the transaction that calls the function, so we don't
-- need separate transaction control internally
BEGIN
    INSERT INTO app_auth.magic_tokens(token_type, action_target)
    VALUES ('email_confirm'::app_auth.token_link_type,
            provisional_email)
    RETURNING token_id INTO provisional_token_id;

    INSERT INTO app_auth.users(email, provisional_token)
    VALUES (provisional_email, provisional_token_id)
    RETURNING user_id INTO provisional_user_id;

    UPDATE app_auth.magic_tokens
    SET user_id = provisional_user_id
    WHERE token_id = provisional_token_id;

    SELECT
        INTO provisional_result
        provisional_user_id AS user_id,
        provisional_token_id AS token_id;

    RETURN provisional_result;
END
$$ LANGUAGE plpgsql
VOLATILE
PARALLEL UNSAFE;


-- TODO: make this a security definer function instead of just a utility
-- function
-- NOTE: this function is intended to be a final verifier, as security-in-depth
-- against application errors. We should be doing pretty much the exact same
-- verification in the app -- PLUS expiration enforcement -- and using that to
-- surface user-facing errors.
CREATE OR REPLACE FUNCTION app_auth.confirm_user(
    provisional_user_id             uuid,
    provisional_token_id            uuid)
RETURNS bool AS $$
DECLARE
    provisional_token               app_auth.magic_tokens%ROWTYPE;
    provisional_user                app_auth.users%ROWTYPE;

-- Note: this is part of the transaction that calls the function, so we don't
-- need separate transaction control internally
BEGIN
    -- Note that these STRICTs prevent us from finding zero rows as well as >1
    SELECT * INTO STRICT provisional_token
        FROM app_auth.magic_tokens
        WHERE token_id = provisional_token_id;
    SELECT * INTO STRICT provisional_user
        FROM app_auth.users
        WHERE user_id = provisional_user_id;

    IF provisional_token.user_id <> provisional_user.user_id THEN
        RAISE EXCEPTION 'Token does not match user';
    END IF;

    IF provisional_token.token_type::text <> 'email_confirm' THEN
        RAISE EXCEPTION 'Invalid token type for user confirmation!';
    END IF;

    IF provisional_token.action_target <> provisional_user.email THEN
        RAISE EXCEPTION 'Confirmation token does not match email!';
    END IF;

    UPDATE app_auth.users
    SET email_last_verified = current_timestamp,
        provisional_token = NULL
    WHERE user_id = provisional_user_id;

    DELETE FROM app_auth.magic_tokens
        WHERE token_id = provisional_token_id;

    RETURN TRUE;
END
$$ LANGUAGE plpgsql
VOLATILE
PARALLEL UNSAFE;
