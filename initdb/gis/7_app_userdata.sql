CREATE TABLE IF NOT EXISTS app_userdata.users(
    user_id                         uuid
        PRIMARY KEY
        NOT NULL
        REFERENCES app_auth.users(user_id)
        ON DELETE CASCADE,
    client_user_id                  uuid
        NOT NULL
        UNIQUE
        DEFAULT gen_random_uuid());
