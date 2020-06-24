
#!/bin/bash
set -e

# create the empty database here, so we can set it up with pg_statement
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE ROLE aiida;
    ALTER ROLE aiida WITH SUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'md54456c1e25617bf54c4c993d4c4430a72';
    CREATE DATABASE aiida_db WITH
        OWNER = aiida
        TEMPLATE = template0;
EOSQL

# TODO I had to make aiida a superuser, otherwise it can't reset the query statistics
# this does not seem to work https://stackoverflow.com/a/55845979/5033292
psql -v ON_ERROR_STOP=1 --username aiida --dbname aiida_db <<-EOSQL
    CREATE EXTENSION pg_stat_statements;
    SELECT pg_stat_statements_reset();
EOSQL
