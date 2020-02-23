# FROM nethermind/nethermind:1.6.8-alpine
FROM nethermind/nethermind@sha256:5ff6f6243a87b7fa753fd31c91cbae0dfb756717ee8620fb27c9fc62f433bc60

COPY ./keydonix-chainspec.json /nethermind/chainspec/keydonix.json
COPY ./keydonix-config.cfg /nethermind/configs/keydonix.cfg

ENTRYPOINT [ "./Nethermind.Runner", "--config", "keydonix" ]
