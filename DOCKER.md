# Running project in Docker

# Starting

```bash
docker-compose up --build -d
```

# Stopping

```bash
docker-compose down
```

### Build and push the api image to docker hub

#### Build and push in one command
````bash
docker buildx build --push --platform linux/amd64 -t zoltansco/aerztekasse:aerztekasse-app-2025.04.02a -f Dockerfile .
````
