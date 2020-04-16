# use the base image to build with because we need to ensure that the library is built for the correct version
FROM nethermind/nethermind@sha256:046c9a82e3789b9e91b680a4f78d8c774f3eb67eada8d4b721914f69b34834f3 as faketime
RUN apk -U add git build-base
RUN git clone https://github.com/wolfcw/libfaketime /libfaketime
WORKDIR /libfaketime
RUN make && make install

# FROM nethermind/nethermind:1.7.13-alpine
FROM nethermind/nethermind@sha256:046c9a82e3789b9e91b680a4f78d8c774f3eb67eada8d4b721914f69b34834f3

COPY --from=faketime /usr/local/lib/faketime/libfaketimeMT.so.1 /lib/faketime.so
COPY ./keydonix-chainspec.json /nethermind/chainspec/keydonix.json
COPY ./keydonix-config.cfg /nethermind/configs/keydonix.cfg

ENV LD_PRELOAD="/lib/faketime.so"
ENV FAKETIME_DONT_FAKE_MONOTONIC="1"

ENTRYPOINT [ "./Nethermind.Runner", "--config", "keydonix" ]
