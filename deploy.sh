RPC_URL=http://localhost:8545
CHAIN_ID=99

git submodule update --init --recursive

echo "Creating funded EOA..."
PRIVATE_KEY=$(node src/createFundedAccount.js)

echo "Writing .env file to circles-contracts-v2/.env ..."
cat <<EOF > circles-contracts-v2/.env
PRIVATE_KEY=$PRIVATE_KEY
RPC_URL=$RPC_URL
CHAIN_ID=$CHAIN_ID
EOF

cd circles-contracts-v2/script/deployments/

echo "Installing dependencies ..."
npm i

echo "Deploying Circles contracts ..."
./genericDeploy.sh
