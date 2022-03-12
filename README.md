## Pushing a Docker container image to Docker Hub

1. Log in to a Docker registry

```console
docker login -u <insert-username> -p <insert-password>
```
 
2. Build image from dockerfile.

```console
docker build -t walljcg/geodata .
```

3. push docker image to docker registry

 ```console
 docker push walljcg/geodata:latest
 ```
