Assignment 3 – Gitea Backup and Restore using AWS S3
Overview

This project demonstrates how to deploy Gitea using Docker on an EC2 instance, create backups of the Gitea data directory, store them in Amazon S3, and restore the data in case of failure.

The system ensures that repository data can be recovered using a stored backup.

Architecture

Components used in the system:

Amazon EC2 – hosts the Docker container running Gitea

Docker – runs the Gitea container

Amazon S3 – stores backup archives

Gitea – Git service hosting repositories

Data flow:

Gitea stores repository data in ~/data

Backup archive is created using tar

Backup is uploaded to Amazon S3

Backup can be downloaded and restored if data is lost

Backup Procedure
Step 1 — Create backup archive
tar -czf gitea-backup-$(date +%Y%m%dT%H%M%SZ).tar.gz ~/data
Step 2 — Upload backup to S3
aws s3 cp gitea-backup-*.tar.gz s3://third-assignment/backups/
Step 3 — Verify backup in S3
aws s3 ls s3://third-assignment/backups/
Restore Procedure
Step 1 — Stop the Gitea container
docker stop gitea
Step 2 — Download backup from S3
aws s3 cp s3://third-assignment/backups/gitea-backup-20260314T014142Z.tar.gz /tmp/gitea-backup.tar.gz
Step 3 — Simulate failure by deleting data
rm -rf ~/data
mkdir ~/data
Step 4 — Restore backup
sudo tar -xzf /tmp/gitea-backup.tar.gz -C ~/data

Fix permissions:

sudo chown -R 1000:1000 ~/data
Step 5 — Restart container
docker start gitea

Verify container:

docker ps
Step 6 — Confirm restore

Open the Gitea web interface:

http://3.144.231.26:3000

Login and verify that the repository has been successfully restored.


Conclusion

This project demonstrates a simple backup and recovery system for Gitea using Docker and Amazon S3. The solution ensures that repository data can be recovered quickly in case of accidental deletion or system failure.
