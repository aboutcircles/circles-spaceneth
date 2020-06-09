# use the base image to build with because we need to ensure that the library is built for the correct version
FROM nethermind/nethermind@sha256:ed7658da4c844defcaa1bb7eaace297d06abdc791bd4a9b1050e3ec34e61054b as faketime
RUN apk -U add git build-base
RUN git clone https://github.com/wolfcw/libfaketime /libfaketime
WORKDIR /libfaketime
RUN make && make install

# FROM nethermind/nethermind:1.8.47-alpine
FROM nethermind/nethermind@sha256:ed7658da4c844defcaa1bb7eaace297d06abdc791bd4a9b1050e3ec34e61054b

COPY --from=faketime /usr/local/lib/faketime/libfaketimeMT.so.1 /lib/faketime.so
COPY ./keydonix-chainspec.json /nethermind/chainspec/keydonix.json
COPY ./keydonix-config.cfg /nethermind/configs/keydonix.cfg

ENV LD_PRELOAD="/lib/faketime.so"
ENV FAKETIME_DONT_FAKE_MONOTONIC="1"

ENTRYPOINT [ "./Nethermind.Runner", "--config", "keydonix" ]
