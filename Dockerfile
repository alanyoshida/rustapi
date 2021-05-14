FROM rust:1.31 as builder
WORKDIR /rustapi
COPY . .
RUN rustup override set nightly
RUN cargo install --path .

# Use distroless as minimal base image to package the gopherapi binary
# Refer to https://github.com/GoogleContainerTools/distroless for more details
# FROM gcr.io/distroless/static:nonroot as final
# WORKDIR /
# COPY --from=builder /usr/local/cargo/bin/rustapi /
# USER nonroot:nonroot
# ENTRYPOINT ["/rustapi"]

FROM alpine:latest as final
WORKDIR /
COPY --from=builder /usr/local/cargo/bin/rustapi /

CMD ["/rustapi"]