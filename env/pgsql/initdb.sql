CREATE ROLE fias
LOGIN
PASSWORD 'vagrant'
NOSUPERUSER
NOINHERIT
NOCREATEDB
NOCREATEROLE
NOREPLICATION;

CREATE DATABASE fias
    WITH OWNER = postgres
    ENCODING = 'UTF8'
    TABLESPACE = pg_default
    LC_COLLATE = 'C'
    LC_CTYPE = 'ru_RU.UTF-8'
    CONNECTION LIMIT = -1;

ALTER ROLE fias IN DATABASE fias
SET search_path = fias;

\c fias
CREATE SCHEMA fias;

ALTER SCHEMA fias
    OWNER TO fias;