Run "A Tour of GO" locally.

https://go.dev/tour/welcome/3

# Dockerfile

```
FROM golang AS build
RUN go install golang.org/x/website/tour@latest

EXPOSE 3999

ENTRYPOINT ["/go/bin/tour", "-http", "localhost:3999"]
```

# Build image

```
$ docker build . -t tour
```

# Run Image

```
$ docker run --network host --rm tour
``` 

Finally, browse "http://localhost:3999".
