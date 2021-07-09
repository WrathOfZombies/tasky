# Set env variables default values
ARG VARIANT="1.16"

FROM golang:${VARIANT}-stretch AS build

ENV GO111MODULE="on"
ENV GOOS="linux"
ENV CGO_ENABLED=0

# Configure to reduce warnings and limitations as instruction from official VSCode Remote-Containers.
# See https://code.visualstudio.com/docs/remote/containers-advanced#_reducing-dockerfile-build-warnings.
ENV DEBIAN_FRONTEND=noninteractive

# Update the tools and download git
RUN apt update && apt upgrade -y && \
    apt install -y git \
    make openssh-client

# Get the debugging tools - Delve
RUN go get github.com/uudashr/gopkgs/v2/cmd/gopkgs github.com/ramya-rao-a/go-outline github.com/cweill/gotests/gotests github.com/fatih/gomodifytags github.com/josharian/impl github.com/haya14busa/goplay/cmd/goplay github.com/go-delve/delve/cmd/dlv golang.org/x/tools/gopls

# Download and install Air which we'll use for hot reloading
RUN curl -fLo install.sh https://raw.githubusercontent.com/cosmtrek/air/master/install.sh \
    && chmod +x install.sh && sh install.sh && cp ./bin/air /bin/air

# Run the hot reloading inside the container
ENTRYPOINT ["air"]
