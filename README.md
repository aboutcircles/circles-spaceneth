# Circles spaceneth
This repository contains a Dockerfile that allows to run a stand-alone nethermind node with spaceneth configuration.
It's meant for testing and CI purposes.

## Usage
### Run in docker
Clone the repository and run the following commands:
```shell
docker build . -t circles-spaceneth
docker run -it --network=host circles-spaceneth
```

When started, the image provides a JSON-RPC API on port 8545 and a HTTP API on port 5000.
The api on port 5000 is used to manipulate the time of the node.

* JSON RPC: http://localhost:8545
* Time Control endpoint: http://localhost:5000/set_time

### Get a funded account private key
You can get a funded account private key by running:
```shell
node src/createFundedAccount.js
```
Use this key to e.g. deploy contracts or to generally interact with the node.
You can run this command multiple times to get multiple funded accounts.

### Manipulate time
You can fast-forward the time by running:
```shell
curl -X POST -H "Content-Type: application/json" -d '{"fake_time": "+1d x1"}' http://localhost:5000/set_time
```
**Explanation**:
```json
{
  "fake_time": "+1d x1"
}
```
`+1d` means to offset the current time by 1 day.
`x1` means that the time will pass as real time. If you want to fast-forward the time, you can increase the number of `x` (e.g. `x10`).
