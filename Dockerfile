FROM scratch as base
WORKDIR /app

FROM golang as build
WORKDIR /src
COPY ./src .
#disable crosscompiling 
ENV CGO_ENABLED=0
#compile linux only
ENV GOOS=linux
RUN go build  -ldflags '-w -s' -a -installsuffix cgo -o build


FROM base AS final
WORKDIR /app
COPY --from=build /src/build ./codeeducation
CMD ["./codeeducation"]



