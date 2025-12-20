# Build stage - use Alpine for smaller builder
FROM golang:1.25-alpine AS builder

WORKDIR /opt/web

RUN go mod init web
RUN go get github.com/labstack/echo/v4

COPY src/server.go .

ARG PORT=8080
RUN go build -o server server.go

# Final stage - minimal Alpine runtime
FROM alpine:latest

WORKDIR /opt/web

COPY --from=builder /opt/web/server .

ARG PORT=8080
ENV PORT=${PORT}

EXPOSE ${PORT}

CMD ["./server"]