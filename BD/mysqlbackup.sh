#!/bin/bash

# Configuration de base : datestamp e.g. YYYYMMDD

DATE=`date -I`

# Dossier où sauvegarder les backups

BACKUP_DIR="/backup/mysql"

# Identifiants MySQL

MYSQL_USER="root"
MYSQL_PASSWORD="root"

# Commandes MySQL

MYSQL=/usr/bin/mysql
MYSQLDUMP=/usr/bin/mysqldump

# Sauvegarde

mkdir $BACKUP_DIR/$DATE
mysqldump -u root -C --all-databases > $BACKUP_DIR/$DATE/backup.sql.tgz

