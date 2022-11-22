
## Dockerfile

```
FROM golang AS build
RUN go install golang.org/x/tools/cmd/present@latest \
    && mv pkg/mod/golang.org/x/tools@v0.3.0/cmd/present / \
    && mkdir -p /home/docs/
RUN printf '# Title of document\n## Hello\nhello\n## Slide\n text' > //home/docs/index.slide \ 
    && echo '# Title of document\n## Hello\nhello\n## Article\n text' > //home/docs/index.article 

WORKDIR /home/docs
EXPOSE 3999

#ENTRYPOINT ["/go/bin/present", "-http", "localhost:3999"]
ENTRYPOINT ["/go/bin/present", "-http", ":3999", "-base", "/present/", "-play=false"]
```

## Run image

```
$ docker run --rm -p3999:3999 present
```

## Enhancements
- custom templates
- mount content director as volume
