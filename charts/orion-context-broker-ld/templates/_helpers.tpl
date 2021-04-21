{{/*
Expand the name of the chart.
*/}}
{{- define "orion-context-broker-ld.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "orion-context-broker-ld.fullname" -}}
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
{{- define "orion-context-broker-ld.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "orion-context-broker-ld.labels" -}}
helm.sh/chart: {{ include "orion-context-broker-ld.chart" . }}
{{ include "orion-context-broker-ld.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "orion-context-broker-ld.selectorLabels" -}}
app.kubernetes.io/name: {{ include "orion-context-broker-ld.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
fiware/component: context-broker
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "orion-context-broker-ld.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "orion-context-broker-ld.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
