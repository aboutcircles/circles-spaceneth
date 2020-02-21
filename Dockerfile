# FROM nethermind/nethermind:1.6.7-alpine
FROM nethermind/nethermind@sha256:363dcbb3c12f2695df5b7354f49f24e377e6efee3709756cef34aef179e92afd

COPY ./keydonix-chainspec.json /nethermind/chainspec/keydonix.json
COPY ./keydonix-config.cfg /nethermind/configs/keydonix.cfg

ENTRYPOINT [ "./Nethermind.Runner", "--config", "keydonix" ]
