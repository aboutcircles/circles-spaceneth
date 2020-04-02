# FROM nethermind/nethermind:1.7.13-alpine
FROM nethermind/nethermind@sha256:046c9a82e3789b9e91b680a4f78d8c774f3eb67eada8d4b721914f69b34834f3

COPY ./keydonix-chainspec.json /nethermind/chainspec/keydonix.json
COPY ./keydonix-config.cfg /nethermind/configs/keydonix.cfg

ENTRYPOINT [ "./Nethermind.Runner", "--config", "keydonix" ]
