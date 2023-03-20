# Statically linked OpenSSL

Statically linked [OpenSSL] container image with [Bash]

> 6,0M (1,1M bash)

```bash
ghcr.io/awesome-containers/static-openssl:latest
ghcr.io/awesome-containers/static-openssl:3.1.0

docker.io/awesomecontainers/static-openssl:latest
docker.io/awesomecontainers/static-openssl:3.1.0
```

Slim statically linked [OpenSSL] container image with [Bash] packaged with [UPX]

> 2,6M (578K bash)

```bash
ghcr.io/awesome-containers/static-openssl:latest-slim
ghcr.io/awesome-containers/static-openssl:3.1.0-slim

docker.io/awesomecontainers/static-openssl:latest-slim
docker.io/awesomecontainers/static-openssl:3.1.0-slim
```

[OpenSSL]: https://www.openssl.org/
[Bash]: https://github.com/awesome-containers/static-bash
[UPX]: https://upx.github.io/

<!--
```bash
image="localhost/${PWD##*/}"

podman build -t "$image:latest" .
podman build -t "$image:latest-slim" -f Containerfile-slim \
  --build-arg STATIC_OPENSSL_IMAGE="$image" \
  --build-arg STATIC_OPENSSL_VERSION=latest --no-cache .

echo "$image:latest"
podman inspect "$image:latest" | jq '.[].Size' | numfmt --to=iec
echo "$image:latest-slim"
podman inspect "$image:latest-slim" | jq '.[].Size' | numfmt --to=iec

```
-->
