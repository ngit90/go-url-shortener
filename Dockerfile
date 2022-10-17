FROM golang:1.16-alpine AS build
WORKDIR /GO_SHORTENER_WM
COPY . .
RUN go mod tidy
RUN go mod vendor
RUN GOOS=linux GOARCH=amd64 go build -mod=vendor -o target/go-url-shortener main.go


FROM golang:1.16-alpine
WORKDIR /usr/src/myapp
COPY --from=build /GO_SHORTENER_WM/target/go-url-shortener /usr/src/myapp/go-url-shortener
CMD /usr/src/myapp/go-url-shortener
