FROM nethermind/nethermind@sha256:f3683e1be999870704477a3e56612e3c3af31f1a014cef427e06d9c4b965a05c

COPY ./keydonix-chainspec.json /nethermind/chainspec/keydonix.json
COPY ./keydonix-config.cfg /nethermind/configs/keydonix.cfg

ENTRYPOINT [ "./Nethermind.Runner", "--config", "keydonix" ]
