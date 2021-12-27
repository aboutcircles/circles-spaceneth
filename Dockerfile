# use the base image to build with because we need to ensure that the library is built for the correct version
FROM nethermind/nethermind@sha256:19a32be067168b993d9f590340a6434fcd8c0d9afbadd454010a24e078d75beb as faketime
RUN apt-get update && apt-get install --yes git build-essential
RUN git clone https://github.com/wolfcw/libfaketime /libfaketime
WORKDIR /libfaketime
RUN make && make install

# FROM nethermind/nethermind:1.12.3
FROM nethermind/nethermind@sha256:19a32be067168b993d9f590340a6434fcd8c0d9afbadd454010a24e078d75beb

COPY --from=faketime /usr/local/lib/faketime/libfaketimeMT.so.1 /lib/faketime.so
COPY ./keydonix-chainspec.json /nethermind/chainspec/keydonix.json
COPY ./keydonix-config.cfg /nethermind/configs/keydonix.cfg

ENV LD_PRELOAD="/lib/faketime.so"
ENV FAKETIME_DONT_FAKE_MONOTONIC="1"

ENTRYPOINT [ "./Nethermind.Runner", "--config", "keydonix" ]
