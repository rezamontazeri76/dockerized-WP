#!/bin/bash

# Current date in YYYY-MM-DD-HHMMSS format for unique backup filenames
DATE=$(date +%F-%H%M%S)

# Backup directory on the host
BACKUP_DIR="/mnt/mysql"

# creat directory
if [ ! -d $BACKUP_DIR ]; then
  mkdir -p $BACKUP_DIR
fi

# Database credentials and details
DB_HOST="db" #name of the mysql container
DB_USER="$MYSQL_USER"
DB_PASSWORD="$MYSQL_PASSWORD"
DB_NAME="wordpress"
NETWORK="internal-network" #name of the network where mysql container is running. You can check the list of the docker neworks using doocker network ls

# Docker image version of MySQL
MYSQL_IMAGE="mysql:8.0"

# Backup filename
BACKUP_FILENAME="$BACKUP_DIR/$DB_NAME-$DATE.sql"

# Run mysqldump within a new Docker container
docker exec -it $DB_HOST mysqldump --lock-tables --user=$DB_USER --password=$DB_PASSWORD  $DB_NAME > $BACKUP_FILENAME

# Compress the backup file
gzip $BACKUP_FILENAME
