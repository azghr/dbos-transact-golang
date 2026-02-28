-- Migration 9: Add primary key to notifications table
-- An earlier version of DBOS had a bug where this table was created without a primary key.
-- The initial migration has been changed to create a key, and this migration creates the key
-- for existing applications.

DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_constraint
        WHERE conrelid = '%s.notifications'::regclass
          AND contype = 'p'
    ) THEN
        ALTER TABLE %s.notifications ADD PRIMARY KEY (message_uuid);
    END IF;
END $$;
