APP=$(shell basename $(shell git remote get-url origin))
REGISTRY=europe-docker.pkg.dev/absolute-surf-405213/k8s-k3s-demo
VERSION=$(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD)
TARGETOS ?= linux
TARGETARCH ?= amd64


format:
	gofmt -s -w ./

lint:
	golint

test:
	go test ./...

get:
	go get

build: format get
	CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -v -o kbot -ldflags "-X="github.com/RomanDemianenko/kbot/cmd.appVersion=${VERSION}

buildx: format get
	docker buildx build --platform darwin/arm64,linux/amd64,windows/amd64 -t $(REGISTRY)/$(APP):$(VERSION) .


image:
	docker build . -t ${REGISTRY}/${APP}:${VERSION}-${TARGETOS}

push:
	docker push ${REGISTRY}/${APP}:${VERSION}-${TARGETOS}

clean:
	rm -rf kbot

linux:
	$(MAKE) build TARGETOS=linux TARGETARCH=amd64

mac:
	$(MAKE) build TARGETOS=darwin TARGETARCH=arm64

windows:
	$(MAKE) build TARGETOS=windows TARGETARCH=amd64