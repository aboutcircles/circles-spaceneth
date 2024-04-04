FROM nethermind/nethermind

COPY ./circles-chainspec.json /nethermind/chainspec/circles.json
COPY ./circles-config.cfg /nethermind/configs/circles.cfg

ENTRYPOINT [ "./Nethermind.Runner", "--config", "circles" ]
