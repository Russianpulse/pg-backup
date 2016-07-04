#!/bin/sh

###############################################################################
# Set Defaults
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

###############################################################################
# Backup

echo "`date`: Dump DB.." >> /var/log/backup.log

PGPASSWORD=$PG_PASSWORD
pg_dump -Fc --no-acl --no-owner -U $PG_USER -h $PG_HOST $PG_DBNAME > /backup/database.dump

echo "`date`: Uploading to FTP.." >> /var/log/backup.log

PASSPHRASE=$CRYPT_PASSPHRASE

duplicity /backup/database.dump $FTP_URL --allow-source-mismatch --full-if-older-than=7D

echo "`date`: Done!" >> /var/log/backup.log
