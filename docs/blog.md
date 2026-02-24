# Blog Setup Documentation

This document describes the personal blog setup in the Ether homelab environment. The blog is hosted as a Kubernetes application and serves as a platform for documenting projects and technical content.

## Overview

The personal blog is hosted as a Kubernetes application in the `blog` namespace. It's a static website that serves as a documentation platform for the homelab and personal projects. The setup includes:

- Static website hosting using Nginx
- Analytics integration with Umami
- Cloudflare Tunnel for external access
- GitOps deployment through ArgoCD

## Architecture

The blog is deployed using standard Kubernetes manifests with the following components:

- **Nginx Server**: Serves static content for the blog
- **Umami Analytics**: Integrated for tracking visitor analytics
- **Cloudflare Tunnel**: Provides external access with security features
- **Kubernetes Services**: Exposes the blog internally within the cluster

## Deployment Configuration

### Kubernetes Manifests

The blog deployment is defined in the `argo/apps/blog/` directory with the following key files:

1. **config.yaml** - Nginx configuration with server blocks for:
   - Main blog at `myzopotamia.dev`
   - Analytics dashboard at `stats.myzopotamia.dev` (Umami integration)
   - Security restrictions to block unauthorized access

2. **deployment.yaml** - Kubernetes Deployment manifest:
   - Uses the Docker image `registry.gitlab.com/myzreal/ether/blog:latest`
   - Runs Nginx container on port 80
   - Mounts the Nginx configuration from a ConfigMap
   - Uses image pull secrets for authentication

3. **service.yaml** - Kubernetes Service manifest:
   - Exposes the blog on port 80
   - Uses selector matching the deployment labels

### GitOps Integration

The blog is managed through ArgoCD with the following configuration in `argo/apps/argocd/apps/blog.yaml`:

- **Application Name**: `blog`
- **Namespace**: `blog`
- **Source Path**: `argo/apps/blog`
- **Sync Policy**: Automated with prune and self-heal enabled
- **Repository**: `https://github.com/rskupnik/ether.git`

## Hosting and Access

### Internal Access
- **Service Name**: `myzopotamia-blog`
- **Namespace**: `blog`
- **Port**: 80

### External Access
The blog is accessible externally through Cloudflare Tunnel at:
- **Main Blog**: `https://myzopotamia.dev`
- **Analytics Dashboard**: `https://stats.myzopotamia.dev`

## Analytics Integration

The blog integrates with Umami analytics for tracking visitor statistics:

- **Umami Service**: `umami.umami.svc.cluster.local:3000`
- **Endpoints**:
  - `/umami` - Proxy for Umami dashboard
  - `/api/send` - Proxy for analytics data collection
- **Security**: Direct access to Umami is blocked with 403 responses

## Security

### Access Control
- The Nginx configuration restricts direct access to Umami endpoints
- Only specific paths are allowed for analytics integration
- All other access to Umami is blocked with HTTP 403 responses

### External Access
- Cloudflare Tunnel provides secure external access
- IPTables rules and network policies are implemented for additional security

## Maintenance

### Monitoring
The blog can be monitored using standard Kubernetes commands:
```bash
kubectl get pods -n blog
kubectl get svc -n blog
kubectl get deployments -n blog
```

### Logs
```bash
kubectl logs -l app=myzopotamia-blog -n blog
```

### Updates
The blog is updated through GitOps by pushing changes to the repository, which are then automatically synced to the cluster by ArgoCD.

## Development

### Image Building
The blog image is built and pushed to:
- **Registry**: `registry.gitlab.com/myzreal/ether/blog`
- **Tag**: `latest`

### CI/CD Integration
The blog deployment is integrated with GitHub Actions runners for automated building and deployment to the cluster.

## Troubleshooting

### Common Issues
1. **Blog not accessible**: Check if the deployment is running and if Cloudflare Tunnel is properly configured
2. **Analytics not working**: Verify Umami service connectivity and proxy configuration
3. **Permission issues**: Check image pull secrets and service account permissions

### Checking Status
```bash
kubectl get pods -n blog
kubectl describe pod -l app=myzopotamia-blog -n blog
kubectl get svc myzopotamia-blog -n blog
```

## Backup and Recovery

While the blog is primarily a static website, the configuration is managed through GitOps, providing version control and recovery capabilities through the Git repository.

## Future Improvements

The blog setup could be enhanced by:
- Adding SSL certificate management
- Implementing more advanced analytics features
- Adding content management system capabilities
- Improving automated deployment workflows