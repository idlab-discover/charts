{{/*
Expand the name of the chart.
*/}}
{{- define "quarkus-template.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "quarkus-template.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "quarkus-template.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "quarkus-template.labels" -}}
helm.sh/chart: {{ include "quarkus-template.chart" . }}
{{ include "quarkus-template.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "quarkus-template.selectorLabels" -}}
app.kubernetes.io/name: {{ include "quarkus-template.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
The image reference for the Quarkus application
*/}}
{{- define "quarkus-template.image" }}
{{- $registry := coalesce .Values.image.registry .Values.global.image.registry }}
{{- $name := .Values.image.name | default .Chart.Name }}
{{- $tag := coalesce .Values.image.tag .Values.global.image.tag .Chart.AppVersion }}
{{- printf "%s/%s:%s" $registry $name $tag }}
{{- end }}

{{- define "quarkus-template.oidc.envConfig" -}}
{{- $authServerUrl := coalesce .Values.oidc.authServerUrl .Values.global.oidc.authServerUrl }}
{{- $existingSecret := coalesce .Values.oidc.existingSecret .Values.global.oidc.existingSecret }}
{{- $clientIdSecretKey := coalesce .Values.oidc.clientIdSecretKey .Values.global.oidc.clientIdSecretKey }}
{{- $clientId := coalesce .Values.oidc.clientId .Values.global.oidc.clientId }}
{{- $clientSecretSecretKey := coalesce .Values.oidc.clientSecretSecretKey .Values.global.oidc.clientSecretSecretKey }}
{{- $clientSecret := coalesce .Values.oidc.clientSecret .Values.global.oidc.clientSecret }}
- name: QUARKUS_OIDC_AUTH_SERVER_URL
  value: {{ $authServerUrl | quote }}
{{- if and $existingSecret $clientIdSecretKey }}
- name: QUARKUS_OIDC_CLIENT_ID
  valueFrom:
    secretKeyRef:
      name: {{ $existingSecret }}
      key: {{ $clientIdSecretKey }}
{{- else if $clientId }}
- name: QUARKUS_OIDC_CLIENT_ID
  value: {{ $clientId | quote }}
{{- end }}
{{- if and $existingSecret $clientSecretSecretKey }}
- name: QUARKUS_OIDC_CREDENTIALS_SECRET
  valueFrom:
    secretKeyRef:
      name: {{ $existingSecret }}
      key: {{ $clientSecretSecretKey }}
{{- else if $clientSecret }}
- name: QUARKUS_OIDC_CREDENTIALS_SECRET
  value: {{ $clientSecret | quote }}
{{- end }}
{{- end }}

{{- define "quarkus-template.oidc.envConfig.additional" -}}
{{- end }}

{{- define "quarkus-template.keycloakAdmin.envConfig" -}}
{{- $enabled := ternary .Values.keycloakAdmin.enabled .Values.global.keycloakAdmin.enabled (hasKey .Values.keycloakAdmin "enabled") }}
{{- $serverUrl := coalesce .Values.keycloakAdmin.serverUrl .Values.global.keycloakAdmin.serverUrl }}
{{- $realm := coalesce .Values.keycloakAdmin.realm .Values.global.keycloakAdmin.realm }}
{{- $existingSecret := coalesce .Values.keycloakAdmin.existingSecret .Values.global.keycloakAdmin.existingSecret }}
{{- $usernameSecretKey := coalesce .Values.keycloakAdmin.usernameSecretKey .Values.global.keycloakAdmin.usernameSecretKey }}
{{- $username := coalesce .Values.keycloakAdmin.username .Values.global.keycloakAdmin.username }}
{{- $passwordSecretKey := coalesce .Values.keycloakAdmin.passwordSecretKey .Values.global.keycloakAdmin.passwordSecretKey }}
{{- $password := coalesce .Values.keycloakAdmin.password .Values.global.keycloakAdmin.password }}
- name: QUARKUS_KEYCLOAK_ADMIN_CLIENT_ENABLED
  value: {{ $enabled | quote }}
- name: QUARKUS_KEYCLOAK_ADMIN_CLIENT_SERVER_URL
  value: {{ $serverUrl | quote }}
- name: QUARKUS_KEYCLOAK_ADMIN_CLIENT_GRANT_TYPE
  value: "password"
- name: QUARKUS_KEYCLOAK_ADMIN_CLIENT_REALM
  value: {{ $realm | quote }}
{{- if and $existingSecret $usernameSecretKey }}
- name: QUARKUS_KEYCLOAK_ADMIN_CLIENT_USERNAME
  valueFrom:
    secretKeyRef:
      name: {{ $existingSecret }}
      key: {{ $usernameSecretKey }}
{{- else if $username }}
- name: QUARKUS_KEYCLOAK_ADMIN_CLIENT_USERNAME
  value: {{ $username | quote }}
{{- end }}
{{- if and $existingSecret $passwordSecretKey }}
- name: QUARKUS_KEYCLOAK_ADMIN_CLIENT_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ $existingSecret }}
      key: {{ $passwordSecretKey }}
{{- else if $password }}
- name: QUARKUS_KEYCLOAK_ADMIN_CLIENT_PASSWORD
  value: {{ $password | quote }}
{{- end }}
{{- end }}


{{- define "quarkus-template.kafka.envConfig" -}}
- name: KAFKA_BOOTSTRAP_SERVERS
  value: {{ coalesce .Values.kafka.bootstrapServers .Values.global.kafka.bootstrapServers | quote }}
{{- end }}

{{- define "quarkus-template.kafka.envConfig.additional" -}}
{{- end }}

{{- define "quarkus-template.clickhouse.envConfig" -}}
{{- end }}

{{- define "quarkus-template.clickhouse.envConfig.additional" -}}
{{- end }}

{{- define "quarkus-template.s3.envConfig" -}}
{{- $endpoint := coalesce .Values.s3.endpoint .Values.global.s3.endpoint }}
{{- $region := coalesce .Values.s3.region .Values.global.s3.region }}
{{- $existingSecret := coalesce .Values.s3.existingSecret .Values.global.s3.existingSecret }}
{{- $accessKeySecretKey := coalesce .Values.s3.accessKeySecretKey .Values.global.s3.accessKeySecretKey }}
{{- $accessKey := coalesce .Values.s3.accessKey .Values.global.s3.accessKey }}
{{- $secretKeySecretKey := coalesce .Values.s3.secretKeySecretKey .Values.global.s3.secretKeySecretKey }}
{{- $secretKey := coalesce .Values.s3.secretKey .Values.global.s3.secretKey }}
- name: QUARKUS_S3_ENDPOINT_OVERRIDE
  value: "{{ $endpoint }}"
- name: QUARKUS_S3_AWS_REGION
  value: "{{ $region }}"
{{- if and $existingSecret $accessKeySecretKey }}
- name: QUARKUS_S3_AWS_CREDENTIALS_STATIC_PROVIDER_ACCESS_KEY_ID
  valueFrom:
    secretKeyRef:
      name: {{ $existingSecret }}
      key: {{ $accessKeySecretKey }}
{{- else if $accessKey }}
- name: QUARKUS_S3_AWS_CREDENTIALS_STATIC_PROVIDER_ACCESS_KEY_ID
  value: {{ $accessKey | quote }}
{{- end }}
{{- if and $existingSecret $secretKeySecretKey }}
- name: QUARKUS_S3_AWS_CREDENTIALS_STATIC_PROVIDER_SECRET_ACCESS_KEY
  valueFrom:
    secretKeyRef:
      name: {{ $existingSecret }}
      key: {{ $secretKeySecretKey }}
{{- else if $secretKey }}
- name: QUARKUS_S3_AWS_CREDENTIALS_STATIC_PROVIDER_SECRET_ACCESS_KEY
  value: {{ $secretKey | quote }}
{{- end }}
{{- end }}

{{- define "quarkus-template.s3.envConfig.additional" -}}
{{- end }}

{{- define "quarkus-template.minio.envConfig" -}}
{{- $useTls := ternary .Values.minio.useTls .Values.global.minio.useTls (hasKey .Values.minio "useTls") }}
{{- $host := coalesce .Values.minio.host .Values.global.minio.host }}
{{- $port := coalesce .Values.minio.port .Values.global.minio.port }}
{{- $skipTlsVerify := ternary .Values.minio.skipTlsVerify .Values.global.minio.skipTlsVerify (hasKey .Values.minio "skipTlsVerify") }}
{{- $existingSecret := coalesce .Values.minio.existingSecret .Values.global.minio.existingSecret }}
{{- $accessKeySecretKey := coalesce .Values.minio.accessKeySecretKey .Values.global.minio.accessKeySecretKey }}
{{- $accessKey := coalesce .Values.minio.accessKey .Values.global.minio.accessKey }}
{{- $secretKeySecretKey := coalesce .Values.minio.secretKeySecretKey .Values.global.minio.secretKeySecretKey }}
{{- $secretKey := coalesce .Values.minio.secretKey .Values.global.minio.secretKey }}
- name: QUARKUS_MINIO_URL
  value: "{{ $useTls | ternary "https" "http" }}://{{ $host }}{{- if $port }}:{{ $port }}{{- end }}"
- name: QUARKUS_MINIO_SECURE
  value: {{ not $skipTlsVerify | quote }}
{{- if and $existingSecret $accessKeySecretKey }}
- name: QUARKUS_MINIO_ACCESS_KEY
  valueFrom:
    secretKeyRef:
      name: {{ $existingSecret }}
      key: {{ $accessKeySecretKey }}
{{- else if $accessKey }}
- name: QUARKUS_MINIO_ACCESS_KEY
  value: {{ $accessKey | quote }}
{{- end }}
{{- if and $existingSecret $secretKeySecretKey }}
- name: QUARKUS_MINIO_SECRET_KEY
  valueFrom:
    secretKeyRef:
      name: {{ $existingSecret }}
      key: {{ $secretKeySecretKey }}
{{- else if $secretKey }}
- name: QUARKUS_MINIO_SECRET_KEY
  value: {{ $secretKey | quote }}
{{- end }}
{{- end }}

{{- define "quarkus-template.minio.envConfig.additional" -}}
{{- end }}

{{- define "quarkus-template.openfga.envConfig" -}}
{{- $url := coalesce .Values.openfga.url .Values.global.openfga.url }}
{{- $existingSecret := coalesce .Values.openfga.existingSecret .Values.global.openfga.existingSecret }}
{{- $storeIdSecretKey := coalesce .Values.openfga.storeIdSecretKey .Values.global.openfga.storeIdSecretKey }}
{{- $storeId := coalesce .Values.openfga.storeId .Values.global.openfga.storeId }}
- name: QUARKUS_OPENFGA_URL
  value: {{ $url | quote }}
{{- if and $existingSecret $storeIdSecretKey }}
- name: QUARKUS_OPENFGA_STORE
  valueFrom:
    secretKeyRef:
      name: {{ $existingSecret }}
      key: {{ $storeIdSecretKey }}
{{- else if $storeId }}
- name: QUARKUS_OPENFGA_STORE
  value: {{ $storeId | quote }}
{{- end }}
{{- end }}
