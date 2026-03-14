#!/bin/bash

DATE=$(date +%Y%m%d%H%M%S)
BACKUP_FILE=gitea-backup-$DATE.tar.gz

tar -czf /tmp/$BACKUP_FILE $HOME/data

aws s3 cp /tmp/$BACKUP_FILE s3://third-assignment/backups/
