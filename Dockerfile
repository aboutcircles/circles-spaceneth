# FROM nethermind/nethermind:1.6.24-alpine
FROM nethermind/nethermind@sha256:f57275ac03689d318428c8656273a1d6527aa402aa96fecd5e62e5f0b018631b

COPY ./keydonix-chainspec.json /nethermind/chainspec/keydonix.json
COPY ./keydonix-config.cfg /nethermind/configs/keydonix.cfg

ENTRYPOINT [ "./Nethermind.Runner", "--config", "keydonix" ]
