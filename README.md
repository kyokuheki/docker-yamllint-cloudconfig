# docker-yamllint-cloudconfig
Dockerized yamllint for CoreOS/Flatcar Container Linux flavored cloud-config

## run

```shell
docker run -it --rm -v /PATH/TO/YAML/FILE:/FILE:ro yamllint-cloudconfig /FILE
```

```shell
docker run -it --rm -v /PATH/TO/YAML/DIR:/yaml:ro yamllint-cloudconfig /yaml
```
