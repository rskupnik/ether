# Paperless Setup Documentation

This document describes the PaperlessNGX setup in the Ether homelab environment. PaperlessNGX is a document management system that allows for digitizing and organizing documents.

## Overview

PaperlessNGX is deployed as a Kubernetes application using Helm charts in the `paperless` namespace. The setup includes:
- PaperlessNGX application
- PostgreSQL database for document metadata
- Redis for caching and task queuing
- Persistent storage for documents
- Backup automation

## Architecture

The Paperless setup is deployed using the Helm chart from `codeberg.org/wrenix/helm-charts` with version 0.2.1. The architecture follows standard Kubernetes patterns with:

- A Helm chart deployment for PaperlessNGX
- PostgreSQL database for metadata storage
- Redis for caching and task queuing
- Persistent volume claim for document storage
- Backup automation using Kubernetes CronJobs

## Deployment Configuration

### Helm Chart

The deployment uses the `paperless-ngx` Helm chart from `oci://codeberg.org/wrenix/helm-charts` with the following configuration:

- **Release name**: `paperless`
- **Namespace**: `paperless`
- **Version**: `0.2.1`

### Key Configuration Values

In `values.yaml`:
- Paperless URL: `https://papers.nora`
- Database configuration using existing secret `db-creds`
- Redis integration with proper password handling
- OCR language settings for Polish (`pol`) and English (`eng`)
- Port configuration set to 8000

### Storage

The application uses a persistent volume claim named `paperless-data` that references a PersistentVolume named `qnap-paperless-pv`. The storage is provided by an NFS share at `192.168.0.185:/paperless` with 100Gi capacity.

### Backup Strategy

Paperless has a comprehensive backup strategy implemented through Kubernetes CronJobs:

1. **Database Backup**: `paperless-backup-db` - Dumps PostgreSQL database using `pg_dumpall`
2. **Media Backup**: `paperless-backup-media` - Backs up media files using rsync
3. **Redis Backup**: `paperless-backup-redis` - Backs up Redis data (if applicable)

The backup jobs run daily at 3:00 AM and are orchestrated by `paperless-backup-orchestrator` CronJob which:
- Scales the Paperless deployment to 0 replicas to ensure data consistency
- Runs the database backup job
- Runs the media backup job
- Runs the Redis backup job
- Scales the Paperless deployment back to 1 replica
- Sends notification via ntfy service

Backup location: `/mnt/backup/paperless/`

## Security

- Database credentials are stored in sealed secrets
- Redis password is managed through existing secrets
- SSH key for offsite backups is encrypted using SOPS
- All backup operations are logged and monitored

## Access

The Paperless application is accessible via:
- URL: `https://papers.nora`
- The application is configured to use X-Forward-Host headers for proper URL handling

## Monitoring

The backup jobs can be monitored using:
```bash
kubectl get jobs -n paperless
kubectl logs job/paperless-backup-db -n paperless
```

## Troubleshooting

### Checking Backup Status

```bash
kubectl get jobs -n paperless
kubectl get cronjobs -n paperless
```

### Viewing Job Logs

```bash
kubectl logs job/paperless-backup-db -n paperless
kubectl logs job/paperless-backup-media -n paperless
kubectl logs job/paperless-backup-redis -n paperless
```

## Maintenance

Regular maintenance includes:
- Monitoring backup jobs for success
- Verifying document storage is properly mounted
- Checking database and Redis health
- Ensuring proper OCR language settings for document processing