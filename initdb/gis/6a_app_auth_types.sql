CREATE TYPE app_auth.token_link_type AS ENUM (
    'email_login',
    'email_confirm');


CREATE TYPE app_auth.provisional_user AS (
    user_id                         uuid,
    token_id                        uuid);
