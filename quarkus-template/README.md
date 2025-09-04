# quarkus-template

A Helm chart for Kubernetes

## TL;DR

```bash
helm repo add discover https://idlab-discover.github.io/charts/
helm install quarkus-template dscover/quarkus-template
```

## Introduction

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

## Prerequisites

- Kubernetes 1.12+
- Helm 3.2.0+

## Installing the Chart

To install the chart with the release name `my-release`:

```bash
helm install my-release discover/quarkus-template
```

The command deploys a Quarkus application on the Kubernetes cluster in the default configuration. The [configuration](#configuration) section lists the parameters that can be configured during installation.

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```bash
helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` | Affinity configuration. |
| applicationProperties | string | `""` | Additional application.properties entries |
| applicationYaml | object | `{}` | Additional application.yaml entries |
| autoscaling.enabled | bool | `false` | Enable autoscaling |
| autoscaling.maxReplicas | int | `100` | Maximum number of replicas |
| autoscaling.minReplicas | int | `1` | Minimum number of replicas |
| autoscaling.targetCPUUtilizationPercentage | int | `80` | Target CPU utilization percentage |
| clickhouse.enabled | bool | `false` | Enable Clickhouse client |
| deploymentStrategy | object | `{}` | Deployment strategy. |
| env | list | `[]` | Additional environment variables. |
| fullnameOverride | string | `""` | Override the full name of the chart. |
| global.applicationYaml | object | `{}` |  |
| global.clickhouse.applicationYaml | object | `{}` |  |
| global.clickhouse.host | string | `""` | Clickhouse host |
| global.clickhouse.port | string | `""` | Clickhouse port |
| global.deploymentStrategy | object | `{}` |  |
| global.env | list | `[]` | Global environment variables |
| global.host | string | `""` | Hostname for the ingress |
| global.image.pullPolicy | string | `"IfNotPresent"` | Image pull policy |
| global.image.registry | string | `"gitlab.ilabt.imec.be:4567/discover/packages"` | Image registry |
| global.image.tag | string | `""` | Image tag |
| global.imagePullSecrets | list | `[]` | Global image pull secrets |
| global.ingressRoutes.matchHost | bool | `false` | Automatically create IngressRoute for the host |
| global.ingressRoutes.proxy | string | `"none"` | Proxy protocol for the IngressRoute |
| global.ingressRoutes.tlsEnabled | bool | `false` | Enable TLS for the IngressRoute |
| global.kafka.applicationYaml | object | `{}` |  |
| global.kafka.bootstrapServers | string | `""` | Kafka bootstrap servers |
| global.keycloakAdmin.enabled | bool | `false` | Enable Keycloak admin client |
| global.keycloakAdmin.existingSecret | string | `""` | Existing secret for Keycloak admin |
| global.keycloakAdmin.password | string | `""` | Keycloak admin password |
| global.keycloakAdmin.passwordSecretKey | string | `""` | Key for password in existing secret |
| global.keycloakAdmin.realm | string | `""` | Keycloak realm |
| global.keycloakAdmin.serverUrl | string | `""` | Keycloak server URL |
| global.keycloakAdmin.username | string | `""` | Keycloak admin username |
| global.keycloakAdmin.usernameSecretKey | string | `""` | Key for username in existing secret |
| global.livenessProbe | object | `{}` |  |
| global.minio.accessKey | string | `""` | Minio access key |
| global.minio.accessKeySecretKey | string | `""` | Key for access key in existing secret |
| global.minio.applicationYaml | object | `{}` |  |
| global.minio.existingSecret | string | `""` | Existing secret for Minio |
| global.minio.host | string | `""` | Minio host |
| global.minio.port | string | `""` | Minio port |
| global.minio.secretKey | string | `""` | Minio secret key |
| global.minio.secretKeySecretKey | string | `""` | Key for secret key in existing secret |
| global.minio.secure | bool | `true` | Use secure connection to Minio |
| global.minio.skipTlsVerify | bool | `true` | Skip TLS verification for Minio |
| global.minio.useTls | bool | `false` | Use TLS for Minio |
| global.oidc.applicationYaml | object | `{}` |  |
| global.oidc.authServerUrl | string | `""` | OIDC auth server URL |
| global.oidc.clientId | string | `""` | OIDC client ID |
| global.oidc.clientIdSecretKey | string | `"client-id"` | Key for client ID in existing secret |
| global.oidc.clientSecret | string | `""` | OIDC client secret |
| global.oidc.clientSecretSecretKey | string | `"client-secret"` | Key for client secret in existing secret |
| global.oidc.existingSecret | string | `""` | Existing secret for OIDC |
| global.oidc.realm | string | `""` | OIDC realm |
| global.oidc.realmSecretKey | string | `""` | Key for realm in existing secret |
| global.openfga.applicationYaml | object | `{}` |  |
| global.openfga.enabled | bool | `false` | Enable Openfga configuration |
| global.openfga.existingSecret | string | `""` | Existing secret for OpenFGA |
| global.openfga.storeId | string | `""` | OpenFGA store ID |
| global.openfga.storeIdSecretKey | string | `""` | Key for store ID in existing secret |
| global.openfga.url | string | `""` | OpenFGA API URL |
| global.quarkus.httpPort | int | `8080` | Quarkus HTTP port |
| global.quarkus.logging.level | string | `"INFO"` | Logging level |
| global.quarkus.metricsPort | string | `""` | Quarkus metrics port |
| global.readinessProbe | object | `{}` |  |
| global.truststore | object | `{}` |  |
| image.name | string | `""` | Name of the image. Defaults to the chart name. |
| image.pullPolicy | string | `""` | Image pull policy. |
| image.registry | string | `""` | Registry for the image. Overrides the global registry. |
| image.tag | string | `""` | Tag for the image. Overrides the chart appVersion. |
| imagePullSecrets | list | `[]` | Secrets for pulling images from a private repository. |
| ingress.annotations | object | `{}` | Annotations for the Ingress |
| ingress.className | string | `""` | Ingress class name |
| ingress.enabled | bool | `false` | Enable Ingress |
| ingress.hosts | list | `[{"host":"chart-example.local","paths":[{"path":"/","pathType":"ImplementationSpecific"}]}]` | Hosts for the Ingress |
| ingress.tls | list | `[]` | TLS settings for the Ingress |
| ingressRoutes.enabled | bool | `false` | Enable IngressRoute |
| ingressRoutes.matchHost | string | `nil` | Match host for IngressRoute |
| ingressRoutes.routes | list | `[]` | Routes for the IngressRoute |
| ingressRoutes.tlsEnabled | bool | `false` | Enable TLS for IngressRoute |
| job.backoffLimit | int | `5` | Job backoff limit |
| job.enabled | bool | `false` | Enable the job |
| job.restartPolicy | string | `"OnFailure"` | Job restart policy |
| kafka.enabled | bool | `false` | Enable Kafka client |
| keycloakAdmin.enabled | bool | `false` | Enable Keycloak Admin client |
| livenessProbe | object | `{}` | Liveness probe configuration. |
| minio.enabled | bool | `false` | Enable Minio client |
| nameOverride | string | `""` | Override the chart name. |
| nodeSelector | object | `{}` | Node selector configuration. |
| oidc.enabled | bool | `false` | Enable OIDC support |
| openfga.enabled | bool | `false` | Enable OpenFGA client |
| podAnnotations | object | `{}` | Annotations to add to the pod. |
| podLabels | object | `{}` | Labels to add to the pod. |
| podMonitor.enabled | bool | `false` | Enable PodMonitor creation |
| podMonitor.interval | string | `"15s"` | Scrape interval for PodMonitor |
| podSecurityContext | object | `{}` | Security context for the pod. |
| quarkus.httpPort | int | `8080` | Quarkus HTTP port |
| quarkus.metricsPort | string | `""` | Quarkus metrics port |
| readinessProbe | object | `{}` | Readiness probe configuration. |
| replicaCount | int | `1` | Number of replicas for the deployment. |
| resources | object | `{}` | Resource requests and limits. |
| securityContext | object | `{}` | Security context for the container. |
| service.port | int | `80` | Service port. |
| service.type | string | `"ClusterIP"` | Service type. |
| tolerations | list | `[]` | Tolerations configuration. |
| volumeMounts | list | `[]` | Additional volume mounts. |
| volumes | list | `[]` | Additional volumes. |

