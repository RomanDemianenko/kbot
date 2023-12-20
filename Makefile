APP=$(shell basename $(shell git remote get-url origin))
REGISTRY=romandemianenko/
TELEBOT = 6689052259:AAGMbM_kW5dQ8sXlXhwYhmtMEx88CSSGucw
VERSION=$(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD)
TARGETOS ?= linux
TARGETARCH ?= amd64
IMAGE_TAG=${REGISTRY}${APP}:${VERSION}-$(TARGETOS)-${TARGETARCH}

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
	docker buildx build --platform darwin/arm64,linux/amd64,windows/amd64 -t $(REGISTRY)$(APP):$(VERSION) .

image:
	docker build . -t ${IMAGE_TAG}

push:
	docker push ${IMAGE_TAG}

clean:
	rm -rf kbot
	docker rmi $(IMAGE_TAG)

linux:
	$(MAKE) build TARGETOS=linux TARGETARCH=amd64

mac:
	$(MAKE) build TARGETOS=darwin TARGETARCH=arm64

windows:
	$(MAKE) build TARGETOS=windows TARGETARCH=amd64