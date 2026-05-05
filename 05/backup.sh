#!/bin/bash

DB_CONTAINER_NAME="db"
DB_NAME="baza_danych"
DB_USER="admin1"
BACKUP_DIR="backups"
DATE=$(date +"%Y%m%d_%H%M")
FILENAME="backup_${DATE}.sql"

mkdir -p "$BACKUP_DIR"

echo "Rozpoczynam backup bazy: $DB_NAME..."

docker compose exec -T "$DB_CONTAINER_NAME" pg_dump -U "$DB_USER" "$DB_NAME" > "$BACKUP_DIR/$FILENAME"

if [ $? -eq 0 ] && [ -s "$BACKUP_DIR/$FILENAME" ]; then
    echo "Backup zakończony sukcesem: $BACKUP_DIR/$FILENAME"
else
    echo "BŁĄD: Backup nie powiódł się lub plik jest pusty!"
    rm -f "$BACKUP_DIR/$FILENAME"
    exit 1
fi

echo "Usuwanie backupów starszych niż 7 dni..."
find "$BACKUP_DIR" -type f -name "backup_*.sql" -mtime +7 -delete

echo "Zadanie zakończone."