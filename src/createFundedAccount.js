const { ethers, Wallet} = require('ethers');
const provider = new ethers.JsonRpcProvider('http://localhost:8545');

async function createFundedAccount() {
	const accounts = await provider.listAccounts();
	const fundedAccountsWithKnownPrivateKey = [];

	for (const account of accounts) {
		const balance = await provider.getBalance(account);

		if (balance < 1) {
			continue;
		}

		const wallet = Wallet.createRandom();
		const gasLimit = await provider.estimateGas({
			from: account.address,
			to: wallet.address,
			value: 1000000000000000000000n,
		});

		const tx = {
			to: wallet.address,
			value: 10000000000000000000000n,
			gasPrice: 100n,
			gasLimit: gasLimit,
		};

		const response = await account.sendTransaction(tx);
		await response.wait();

		fundedAccountsWithKnownPrivateKey.push(wallet);

		// We only need one funded account
		break;
	}

	for (const wallet of fundedAccountsWithKnownPrivateKey) {
		console.log(`${wallet.privateKey}`);
		break;
	}
}

createFundedAccount();
