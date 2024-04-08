# Circles node (spaceneth)
This repository aims to collect all the necessary components to run a Circles node.
As of now it's only meant for development and testing purposes. For this purpose, it uses a nethermind node in spaceneth configuration, a block explorer (blockscout) and a time controller that lets you fast-forward nethermind's time.

It includes git submodules for:
* [v1 Circles contracts](https://github.com/CirclesUBI/circles-contracts)
* [v2 Circles contracts](https://github.com/CirclesUBI/circles-contracts-v2)
* [circles-nethermind-plugin](https://github.com/CirclesUBI/circles-nethermind-plugin)

Future additions:
* IPFS node to pin ERC-1155 metadata
* Modes for chiado and gnosis chain

## Requirements
* Docker with docker compose plugin
* Node.js


## Usage
### 1. Clone the repository
```shell
git clone --recurse-submodules https://github.com/CirclesUBI/circles-nethermind-plugin.git
```

### 2. Build and run the docker environment
First the nethermind node is built with the Circles plugin, then this node is used in the docker-compose environment.
```shell
./build.sh        # Build nethermind with Circles plugin
docker compose up # Run the environment
```
The environment will start a nethermind node, a block explorer and the time_controller:

* JSON RPC with [Circles extensions](https://github.com/CirclesUBI/circles-nethermind-plugin?tab=readme-ov-file#circles-nethermind-plug-in): http://localhost:8545
* Blockscout: http://localhost:4000
* Time Control endpoint: http://localhost:5000/set_time

### 3. Deploy the circles contracts
You can deploy the Circles contracts by running:
```shell
./deploy.sh
```
This will take a while, so be patient if there's no immediate output.
After this command has finished, you'll see the addresses of the deployed contracts and will be able to interact with it.

Visit the block explorer at http://localhost:4000 to see the deployed contracts.

*TODO: verify contracts in blockscout*

## Utilities
### Get a funded account private key
You can get a funded account private key by running:
```shell
npm install
node src/createFundedAccount.js
```
Use this key to interact with the contracts.
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

*NOTE: This will restart the nethermind node.*
