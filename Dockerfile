ARG TARGETPLATFORM

FROM --platform=${TARGETPLATFORM} golang:1.20 as builder

WORKDIR /go/src/app
COPY . .
RUN make build
RUN make test

FROM --platform=${TARGETPLATFORM} scratch 
WORKDIR /
COPY --from=builder /go/src/app/kbot .
COPY --from=alpine:latest /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
ENTRYPOINT ["./kbot", "start"]