FROM python:alpine

ARG CLI_VERSION=1.16.312
ARG KUBECTL_VERSION=v1.17.0
ARG HELM_VERSION=v2.16.1

RUN apk -uv add --no-cache groff jq less curl && \
    pip install --no-cache-dir awscli==$CLI_VERSION && \
    curl --silent --location "https://github.com/weaveworks/eksctl/releases/download/latest_release/eksctl_Linux_amd64.tar.gz" | tar xz -C /tmp && \
    mv /tmp/eksctl /usr/local/bin && \
    cd /usr/local/bin && \
    curl -LO https://storage.googleapis.com/kubernetes-release/release/"$KUBECTL_VERSION"/bin/linux/amd64/kubectl && \
    chmod +x kubectl && \
    cd /bin && \
    curl --silent --location "https://get.helm.sh/helm-$HELM_VERSION-linux-amd64.tar.gz" | tar xz && \
    mv /bin/linux-amd64/ /bin/helm && \
    chmod +x /bin/helm/helm && \
    ln -snf /bin/helm/helm /usr/bin/helm

WORKDIR /aws

CMD sh
