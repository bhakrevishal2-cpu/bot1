FROM --platform=$BUILDPLATFORM golang:1.25-alpine3.21 AS builder
ARG TARGETOS
ARG TARGETARCH
WORKDIR /app
COPY . .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o /app/fsb -ldflags="-w -s" ./cmd/fsb

FROM scratch
COPY --from=builder /app/fsb /app/fsb
EXPOSE ${PORT}
ENTRYPOINT ["/app/fsb", "run"]
