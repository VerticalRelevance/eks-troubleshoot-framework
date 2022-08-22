# syntax=docker/dockerfile:1

FROM golang:1.19

WORKDIR /app

COPY go.mod ./
COPY go.sum ./
RUN go mod download


COPY cmd/ ./cmd/
RUN ls -la ./cmd/*

COPY config/ ./config/
RUN ls -la ./config/*

COPY design/ ./design/
RUN ls -la ./design/*

COPY ffi/ ./ffi/
RUN ls -la ./ffi/*

COPY pkg/ ./pkg/
RUN ls -la ./pkg/*

COPY schemas/ ./schemas/
RUN ls -la ./schemas/*

COPY scripts/ ./scripts/
RUN ls -la ./scripts/*



#ARG BUILDFLAGS='-tags netgo containers_image_ostree_stub exclude_graphdriver_devicemapper exclude_graphdriver_btrfs containers_image_openpgp -installsuffix netgo'
#RUN go build $BUILDFLAGS -o bin/preflight github.com/replicatedhq/troubleshoot/cmd/preflight
RUN go build -tags "netgo containers_image_ostree_stub exclude_graphdriver_devicemapper exclude_graphdriver_btrfs containers_image_openpgp" -installsuffix netgo -o bin/preflight github.com/replicatedhq/troubleshoot/cmd/preflight
#RUN go build -o bin/preflight github.com/replicatedhq/troubleshoot/cmd/preflight
ENTRYPOINT ["/app/bin/preflight"]

# Set volumn to path of file

# Capture KUBECONFIG & AWS Creds


