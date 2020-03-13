# FROM nethermind/nethermind:1.6.30-alpine
FROM nethermind/nethermind@sha256:d0ead44545e8fa68226321a16340c06293e68a5cfc4750e38d8aa5dae9d4353d

COPY ./keydonix-chainspec.json /nethermind/chainspec/keydonix.json
COPY ./keydonix-config.cfg /nethermind/configs/keydonix.cfg

ENTRYPOINT [ "./Nethermind.Runner", "--config", "keydonix" ]
