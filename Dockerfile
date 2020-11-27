FROM python:alpine
LABEL maintainer Kenzo Okuda <kyokuheki@gmail.com>

ENV YAMLLINT_CONFIG_FILE=/.yamllint.yaml

RUN set -x \
 && pip3 install \
    yamllint

COPY ./.yamllint.yaml /.yamllint.yaml

ENTRYPOINT ["/usr/local/bin/yamllint"]
CMD ["--help"]
