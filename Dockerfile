FROM python:alpine
LABEL maintainer="Kenzo Okuda <kyokuheki@gmail.com>"

ENV YAMLLINT_CONFIG_FILE=/.yamllint.yaml

RUN set -x \
 && pip3 install \
    yamllint

COPY ./.yamllint.yaml /.yamllint.yaml
COPY --chmod=755 ./cloudconfiglint.py /cloudconfiglint.py
COPY --chmod=755 ./run.sh /run.sh

ENTRYPOINT ["/run.sh"]
CMD ["--help"]
