#!/bin/bash

# INIT_DB (default == true): Create table space and database
# RESTORE_BACKUP (default == false): Load /backup/*.sql and /backup/*.dmp in order

# Variables :
PGDATA="/var/lib/postgresql/data"
POSTGRES_TABLESPACE="tab_${DB_NAME}"

# Create directory for tablespace
mkdir -p ${PGDATA}/base/${POSTGRES_TABLESPACE}

if [ ${INIT_DB} == true ]; then
  echo "INIT-DB: === Simple init database actived (default) ==="
  echo "Role : ${USER_NAME}"
  psql -c "CREATE ROLE ${USER_NAME} PASSWORD '${USER_PASSWORD}' NOSUPERUSER NOCREATEDB NOCREATEROLE INHERIT LOGIN;"
  psql -c "ALTER ROLE ${USER_NAME} SUPERUSER;"

  # Base de données
  echo "Database : ${DB_NAME}"
  psql -c "CREATE TABLESPACE \"${POSTGRES_TABLESPACE}\" OWNER \"${USER_NAME}\" LOCATION '${PGDATA}/base/${POSTGRES_TABLESPACE}';"
  createdb -T template0 -D "${POSTGRES_TABLESPACE}" -O "${USER_NAME}" "${DB_NAME}"


  # Add Postgigs
  psql -d "$DB_NAME" -c "CREATE EXTENSION postgis;"

  psql -c "ALTER ROLE ${USER_NAME} NOSUPERUSER NOCREATEDB NOCREATEROLE INHERIT LOGIN;"
else
  echo "INIT-DB:=== Simple init database disabled ==="
fi

if [ ${RESTORE_BACKUP} == true ]; then
  ## === Backup restore enabled ===
  # Manage backup import
  # Find .sql and .dmp backup file in /backup dir
  echo "INIT_DB: === restore database enable ==="
  for fullfile in $(find /backup -maxdepth 1 -type f -name '*.sql' -o -name '*.dmp' | sort -V); do
    echo "INIT-DB: Start import $fullfile"
    filename=$(basename -- "$fullfile")
    extension="${filename##*.}"
    filename="${filename%.*}"

    # Detect file type
    filetype=$(file "$fullfile"| awk '{print $2}')
    if [ "$filetype" == "ASCII" ]; then
        echo "INIT-DB: sql retore"
        psql -f $fullfile
    else
        echo "INIT-DB: dmp retore"
        pg_restore -v -C -d postgres $fullfile
    fi
  done
else
  echo "INIT_DB: === restore database disabled ==="
fi

