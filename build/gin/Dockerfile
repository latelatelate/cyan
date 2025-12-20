FROM golang:1.25-alpine AS builder
WORKDIR /opt/web
RUN go mod init web
RUN go get github.com/labstack/echo/v4
COPY src/server.go .
RUN go build -o server server.go

FROM alpine:latest
WORKDIR /opt/web
COPY --from=builder /opt/web/server .

CMD ["./server"]