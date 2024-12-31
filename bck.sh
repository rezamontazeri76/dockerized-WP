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
DB_USER="wpuser" #name of the database user
DB_PASSWORD="5sad4f54sdaf65sdf465sdaf6fsdeeee" #DB_USER password
DB_NAME="wordpress" #database name
NETWORK="internal-network" # name of the network where mysql container is running
MYSQL_IMAGE="mysql:8.0"

# Backup filename
BACKUP_FILENAME="$BACKUP_DIR/$DB_NAME-$DATE.sql"

# Run mysqldump within a new Docker container
docker exec -it $DB_HOST mysqldump --lock-tables --user=$DB_USER --password=$DB_PASSWORD  $DB_NAME > $BACKUP_FILENAME

# Compress the backup file
gzip $BACKUP_FILENAME
