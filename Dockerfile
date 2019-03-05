FROM golang:latest as builder

WORKDIR /go/src/github.com/JekaTka/shippy-vessel-service

COPY . .

RUN go get
RUN CGO_ENABLED=0 GOOS=linux go build -o vessel-service -a -installsuffix cgo main.go repository.go handler.go datastore.go


FROM alpine:latest

RUN apk --no-cache add ca-certificates

RUN mkdir /app
WORKDIR /app
COPY --from=builder /go/src/github.com/JekaTka/shippy-vessel-service .

CMD ["./vessel-service"]