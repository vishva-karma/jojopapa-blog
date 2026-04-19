#!/usr/bin/env bash
main() {
    HUGO_VERSION="0.160.1"

    export TZ=Europe/Berlin

    #Install hugo
    echo "Installing hugo v${HUGO_VERSION}"
    curl -LJO https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_linux-amd64.tar.gz
    tar -xf hugo_${HUGO_VERSION}_linux-amd64.tar.gz
    cp hugo /opt/buildhome
    rm LICENSE README.md hugo_${HUGO_VERSION}_linux-amd64.tar.gz

    # Verify installed versions
    echo "Verifying dependency versions:"
    echo "Hugo version: $(hugo version)"
    echo "Node version: $(node --version)"
    echo "Golang version: $(go version)"

    # Clone themes repository
    echo "Cloning themes repository"
    git submodule update --init --recursive
    git config core.quotePath false

    # Build the site
    echo "Building the site"
    hugo --minify --gc

}

set -euo pipefail
main "$@"
