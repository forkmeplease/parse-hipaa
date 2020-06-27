#!/bin/bash

set -e
psql -v ON_ERROR_STOP=1 --username "${POSTGRES_USER}" --dbname "${POSTGRES_DB}" <<-EOSQL
    CREATE USER ${PG_PARSE_USER} LOGIN CONNECTION LIMIT 100 ENCRYPTED PASSWORD '${PG_PARSE_PASSWORD}';
    CREATE DATABASE ${PG_PARSE_DB} OWNER ${PG_PARSE_USER};
    \c ${PG_PARSE_DB};
    CREATE EXTENSION postgis;
    CREATE EXTENSION postgis_topology;
EOSQL

exec "$@"