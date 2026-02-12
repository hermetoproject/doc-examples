# npm example

This example demonstrates using Hermeto with a simple Node.js app that uses npm for dependency management.

## Pre-fetch dependencies

The `package-lock.json` file in this repo specifies which npm packages to download.
Run Hermeto to pre-fetch the dependencies into a local output directory:

```shell
hermeto fetch-deps --source . --output ./hermeto-output '{"type": "npm"}'
```

## Generate environment variables

Generate an environment file so you can pass the right settings to `npm install`:

```shell
hermeto generate-env ./hermeto-output -o ./hermeto.env --for-output-dir /tmp/hermeto-output
```

Currently Hermeto does not require any environment variables for npm, but this
may change in the future, so it is recommended to always generate this file.

## Inject project files

Next, inject the project files so that remote npm tarball URLs are rewritten to
point at the locally fetched artifacts:

```shell
hermeto inject-files ./hermeto-output --for-output-dir /tmp/hermeto-output
```

After this step, entries in `package-lock.json` like:

```diff
-      "resolved": "https://registry.npmjs.org/accepts/-/accepts-1.3.8.tgz",
+      "resolved": "file:///tmp/hermeto-output/deps/npm/accepts-1.3.8.tgz",
```

will point to files inside the mounted Hermeto output directory instead of the network.

## Build the application image

The `Containerfile` in this repo uses the `node:18` base image and runs `npm install`
inside the container. With the injected files and environment file in place, the
install step can run without network access.

Build the image while mounting the Hermeto data:

```shell
podman build . \
  --volume "$(realpath ./hermeto-output)":/tmp/hermeto-output:Z \
  --volume "$(realpath ./hermeto.env)":/tmp/hermeto.env:Z \
  --network none \
  --tag npm-basic-example
```

## Run the container

```shell
podman run -it --init -p 9000:9000 npm-basic-example
```

Then open `http://localhost:9000` in your browser to reach the app.
