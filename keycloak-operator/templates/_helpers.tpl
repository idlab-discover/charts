{{- define "keycloak-operator.name" -}}
{{- default .Chart.Name .Values.nameOverride }}
{{- end -}}

{{- define "keycloak-operator.fullname" -}}
{{- printf "%s-%s" (include "keycloak-operator.name" .) .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end -}}
