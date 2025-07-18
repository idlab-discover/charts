# IDLab Discover Charts

```bash
helm repo add idlab-discover https://idlab-discover.github.io/charts
helm repo update
```

## Quarkus Template Chart

This chart provides a template for deploying Quarkus applications on Kubernetes using Helm. It includes configurations for common services such as OpenFGA and MinIO.

### Features

- Configurable OpenFGA integration
- MinIO object storage support
- Health checks and readiness probes
- Ingress routes for HTTP traffic
- Customizable environment variables
- Support for application YAML configurations
- StripPrefix middleware for Ingress routes
- Support for custom labels and annotations
- Configurable resource requests and limits
