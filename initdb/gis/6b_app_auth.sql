CREATE TABLE IF NOT EXISTS app_auth.users(
    user_id                         uuid
        PRIMARY KEY
        DEFAULT gen_random_uuid(),

    -- for now, just have this be unique. At some point in the future I'd like
    -- to support having multiple accounts with the same email, but not yet.
    -- that will need some extra work to prevent abuse (brigading basically),
    -- though I suppose that's already a problem given that you can do
    -- foo+bar@gmail.com -style virtual emails to sidestep uniqueness. But
    -- there are just a whole bunch of UX issues presented with multiple
    -- accounts per email that I just don't want to deal with right now
    email                           text
        NOT NULL
        UNIQUE,
    email_last_verified             timestamp with time zone,

    provisional_token               uuid,
    password_equiv                  text,

    CHECK (
        (provisional_token          IS NULL
        AND (
            password_equiv          IS NOT NULL
            OR email_last_verified  IS NOT NULL
        )) OR (provisional_token    IS NOT NULL
        AND (
            password_equiv          IS NULL
            AND email_last_verified IS NULL
        ))
    )
);
CREATE INDEX ON app_auth.users (email);


CREATE VIEW app_auth.user_emails AS
    SELECT user_id,
        CASE
            WHEN users.email_last_verified IS NOT NULL THEN users.email
            ELSE NULL
        END
    AS email
    FROM app_auth.users users;


CREATE TABLE IF NOT EXISTS app_auth.magic_tokens(
    token_id                        uuid
        PRIMARY KEY
        -- according to the pgcrypto docs, this is cryptographically random,
        -- though admittedly it's maybe 10% unclear if that's actually the case
        DEFAULT gen_random_uuid(),
    user_id                         uuid
        NOT NULL
        -- This is just a placeholder to allow for transactions to start
        -- without a UUID, because postgres doesn't support deferred checks of
        -- not null constraints
        DEFAULT 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11'::uuid
        REFERENCES app_auth.users(user_id)
        ON DELETE CASCADE
        DEFERRABLE
        INITIALLY DEFERRED,
    token_type                      app_auth.token_link_type
        NOT NULL,
    issued_timestamp                timestamp with time zone
        NOT NULL
        DEFAULT current_timestamp,
    action_source                   text,
    action_target                   text
        NOT NULL,
    UNIQUE (user_id, token_type));
CREATE INDEX ON app_auth.magic_tokens (issued_timestamp);
CREATE INDEX ON app_auth.magic_tokens (token_id);
ALTER TABLE app_auth.users
    ADD FOREIGN KEY (provisional_token)
        REFERENCES app_auth.magic_tokens(token_id)
        ON DELETE SET NULL;


CREATE TABLE IF NOT EXISTS app_auth.user_sessions(
    session_id                      uuid
        PRIMARY KEY
        NOT NULL
        -- according to the pgcrypto docs, this is cryptographically random,
        -- though admittedly it's maybe 10% unclear if that's actually the case
        DEFAULT gen_random_uuid(),
    user_id                         uuid
        NOT NULL
        REFERENCES app_auth.users(user_id)
        ON DELETE CASCADE,
    -- We're keeping this here partly to support automatic removal of users
    -- after X months/years of inactivity, and partly to have a solid record
    -- of activity on accounts for intrusion detection purposes
    last_validated                  timestamp with time zone
        NOT NULL
        DEFAULT current_timestamp);
CREATE INDEX ON app_auth.user_sessions (user_id);
CREATE INDEX ON app_auth.user_sessions (last_validated);
