-- Replica user for preview PostgreSQL (same as rc__release)

\echo 'Setting up replica user...'

DO $$
BEGIN
    IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'app_ro_role') THEN
        CREATE ROLE app_ro_role WITH INHERIT NOCREATEDB NOCREATEROLE;
    END IF;
END
$$;

GRANT pg_read_all_data TO app_ro_role;

DO $$
BEGIN
    IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'replica_user') THEN
        CREATE USER replica_user WITH PASSWORD '123456';
    ELSE
        ALTER USER replica_user WITH PASSWORD '123456';
    END IF;
END
$$;

ALTER USER replica_user WITH NOCREATEDB NOCREATEROLE CONNECTION LIMIT 50;
GRANT app_ro_role TO replica_user;

DO $$
DECLARE
    db_record RECORD;
BEGIN
    FOR db_record IN
        SELECT datname
        FROM pg_database
        WHERE datistemplate = false
          AND datname NOT IN ('postgres', 'template0', 'template1')
    LOOP
        EXECUTE format('GRANT CONNECT ON DATABASE %I TO app_ro_role', db_record.datname);
    END LOOP;
END
$$;

\echo 'Replica user setup complete'
