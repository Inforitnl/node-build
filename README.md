# bitbucket-pipelines node-build

[![logo](./logo.jpg)](https://inforit.nl)

Docker image to automate node builds on bitbucket (and local)

Comes preinstalled with Firefox and Chromium for (unit)-testing during build.
Also sonar-scanner is installed to enable sonar analyzing 

## Instructions

1. update dockerfile
2. build local version:

    ```sh
    docker build -t inforitnl/node-build .
    ```

3. push new version to dockerhub:

    ```sh
    docker push inforitnl/node-build
    ```

4. tag and push again (optional but recommended):

    ```sh
    docker tag inforitnl/node-build inforitnl/node-build:1
    docker push inforitnl/node-build:1
    ```

## Usage

```sh
image: inforitnl/node-build

pipelines:
  default:
    - step:
        script:
          - /node-build.sh
```

## scripts

| Command | Description                         |
| ------- | ----------------------------------- |
| build   | build the container with latest tag |
| push    | pushes the container                |
