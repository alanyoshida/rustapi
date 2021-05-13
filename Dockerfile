FROM rust:1.31 as builder
WORKDIR /usr/src/myapp
COPY . .
RUN cargo install --path .

# Use distroless as minimal base image to package the gopherapi binary
# Refer to https://github.com/GoogleContainerTools/distroless for more details
FROM gcr.io/distroless/static:nonroot as final
WORKDIR /
COPY --from=builder /usr/local/cargo/bin/myapp /usr/local/bin/myapp
USER nonroot:nonroot

ENTRYPOINT ["myapp"]
