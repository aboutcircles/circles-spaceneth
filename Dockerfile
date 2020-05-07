# use the base image to build with because we need to ensure that the library is built for the correct version
FROM nethermind/nethermind@sha256:845d55cdfc5f4a7efa7ae6fe12326c8533af2afd2c607e4a3625d76c3a918020 as faketime
RUN apk -U add git build-base
RUN git clone https://github.com/wolfcw/libfaketime /libfaketime
WORKDIR /libfaketime
RUN make && make install

# FROM nethermind/nethermind:1.8.30-alpine
FROM nethermind/nethermind@sha256:845d55cdfc5f4a7efa7ae6fe12326c8533af2afd2c607e4a3625d76c3a918020

COPY --from=faketime /usr/local/lib/faketime/libfaketimeMT.so.1 /lib/faketime.so
COPY ./keydonix-chainspec.json /nethermind/chainspec/keydonix.json
COPY ./keydonix-config.cfg /nethermind/configs/keydonix.cfg

ENV LD_PRELOAD="/lib/faketime.so"
ENV FAKETIME_DONT_FAKE_MONOTONIC="1"

ENTRYPOINT [ "./Nethermind.Runner", "--config", "keydonix" ]
