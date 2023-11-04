FROM golang:1.19.3 AS builder

WORKDIR /src

COPY . .

RUN CGO_ENABLED=0 go build -o app

FROM alpine:3.18.4

ARG USERNAME=app
RUN addgroup -S ${USERNAME} && adduser -S ${USERNAME} -G ${USERNAME}
USER ${USERNAME}

WORKDIR /app

COPY --from=builder /src/app .

EXPOSE 8080

CMD ["/app/app"]
