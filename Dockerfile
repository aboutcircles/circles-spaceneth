# use the base image to build with because we need to ensure that the library is built for the correct version
FROM nethermind/nethermind@sha256:d116112a3dd06eb93df21a874b6f770d384a5a0dbda3e3fe3b56e47f671b2b17 as faketime
RUN apt-get update && apt-get install --yes git build-essential
RUN git clone https://github.com/wolfcw/libfaketime /libfaketime
WORKDIR /libfaketime
RUN make && make install

# FROM nethermind/nethermind:1.10.71
FROM nethermind/nethermind@sha256:d116112a3dd06eb93df21a874b6f770d384a5a0dbda3e3fe3b56e47f671b2b17

COPY --from=faketime /usr/local/lib/faketime/libfaketimeMT.so.1 /lib/faketime.so
COPY ./keydonix-chainspec.json /nethermind/chainspec/keydonix.json
COPY ./keydonix-config.cfg /nethermind/configs/keydonix.cfg

ENV LD_PRELOAD="/lib/faketime.so"
ENV FAKETIME_DONT_FAKE_MONOTONIC="1"

ENTRYPOINT [ "./Nethermind.Runner", "--config", "keydonix" ]
