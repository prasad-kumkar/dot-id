FROM ubuntu:18.04

RUN apt-get update && apt-get install -y curl
RUN apt-get install -y cmake pkg-config libssl-dev git build-essential clang libclang-dev curl libz-dev
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"
RUN rustup update nightly-2020-08-23 && rustup target add wasm32-unknown-unknown --toolchain nightly-2020-08-23
COPY . .
# RUN make init
RUN cargo build --release
CMD cargo run --release -- --dev --tmp