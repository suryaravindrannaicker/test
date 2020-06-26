FROM golang:latest
RUN mkdir /app
ADD . /app/
WORKDIR /app
RUN CGO_ENABLED=0 go test -v
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o sqrt

FROM alpine:3.10
RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=0 app .
CMD ["./sqrt"]
