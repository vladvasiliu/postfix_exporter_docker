FROM golang:1.12.0-alpine3.9 as builder

RUN apk update && \
    apk add git

WORKDIR /postfixe_exporter

RUN go get github.com/kumina/postfix_exporter
RUN CGO_ENABLED=0 GOOS=linux go build -tags nosystemd -a -installsuffix cgo -o app github.com/kumina/postfix_exporter


FROM alpine:3.9

LABEL version="1.0"
LABEL description="Prometheus Postfix exporter"
LABEL maintainer="Vlad Vasiliu <vladvasiliun@yahoo.fr>"

EXPOSE 9154
WORKDIR /bin
COPY --from=builder /postfix_exporter/app ./postfix_exporter
RUN apk add --no-cache curl
HEALTHCHECK --interval=5s --timeout=3s --start-period=5s CMD curl -s http://127.0.0.1:9154 -o /dev/null || exit 1
CMD [ "./postfix_exporter" ]

