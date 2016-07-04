#!/bin/sh

if [ -z "${PG_USER}" ]; then
  export PGUSER=postgres
fi

if [ -z "${PG_PASSWORD}" ]; then
  export PGPASSWORD=
fi

if [ -z "${PG_PORT}" ]; then
  export PG_PORT=5432
fi

if [ -z "${PG_HOST}" ]; then
  export PGHOST=db
fi
