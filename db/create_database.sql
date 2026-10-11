BEGIN;

CREATE TABLE IF NOT EXISTS subscriptions (
    chat_id BIGINT PRIMARY KEY,
    subscription_type VARCHAR(20) NOT NULL,
    threshold_percentage NUMERIC(10, 4) NOT NULL DEFAULT 0,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT subscriptions_type_check
        CHECK (subscription_type IN ('none', 'any_change', 'percentage', 'target'))
);

CREATE TABLE IF NOT EXISTS rate_history (
    id BIGSERIAL PRIMARY KEY,

    rate_1d NUMERIC(10, 4) NOT NULL,
    volumen_1d BIGINT,

    rate_2d NUMERIC(10, 4) NOT NULL,
    volumen_2d BIGINT,

    rate_3d NUMERIC(10, 4) NOT NULL,
    volumen_3d BIGINT,

    rate_7d NUMERIC(10, 4) NOT NULL,
    volumen_7d BIGINT,

    timestamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS suggestions (
    id BIGSERIAL PRIMARY KEY,
    chat_id BIGINT NOT NULL,
    username VARCHAR(255),
    message TEXT NOT NULL,
    read BOOLEAN NOT NULL DEFAULT FALSE,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_rate_history_timestamp
    ON rate_history (timestamp DESC);

CREATE INDEX IF NOT EXISTS idx_suggestions_created_at
    ON suggestions (created_at DESC);

CREATE INDEX IF NOT EXISTS idx_suggestions_unread
    ON suggestions (created_at DESC)
    WHERE read = FALSE;

COMMIT;