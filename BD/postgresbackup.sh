#!/bin/bash

# Configuration de base : datestamp e.g. YYYYMMDD

DATE=`date -I`

# Dossier où sauvegarder les backups

BACKUP_DIR="/backup/postgres"

# Sauvegarde

mkdir $BACKUP_DIR/$DATE
sudo -u postgres pg_dumpall -c > $BACKUP_DIR/$DATE/backup.sql

