# Generic fetcher example

This example demonstrates using Hermeto's generic fetcher to build a container image with OWASP Dependency-Check tool.

## Pre-fetch dependencies

The `artifacts.lock.yaml` file specifies which files to download. Run Hermeto to fetch the dependencies:

```shell
hermeto fetch-deps --source . --output ./hermeto-output generic
```

## Build the container image

Build the container image while mounting the Hermeto output directory:

```shell
podman build . \
  --volume "$(realpath ./hermeto-output)":/tmp/hermeto-output \
  --network none \
  --tag dependency-check-example
```

## Run the container

```shell
podman run dependency-check-example
```
