FROM golang:1.20-alpine
ENV BIND_ADDRESS=:8080
WORKDIR /usr/src/app
COPY go.mod main.go ./
RUN go build -o app
CMD ["./app"]