/**
 * Use this file to configure your truffle project. It's seeded with some
 * common settings for different networks and features like migrations,
 * compilation and testing. Uncomment the ones you need or modify
 * them to suit your project as necessary.
 *
 * More information about configuration can be found at:
 *
 * truffleframework.com/docs/advanced/configuration
 *
 * To deploy via Infura you'll need a wallet provider (like truffle-hdwallet-provider)
 * to sign your transactions before they're sent to a remote public node. Infura accounts
 * are available for free at: infura.io/register.
 *
 * You'll also need a mnemonic - the twelve word phrase the wallet uses to generate
 * public/private key pairs. If you're publishing your code to GitHub make sure you load this
 * phrase from a file you've .gitignored so it doesn't accidentally become public.
 *
 */

// const fs = require('fs');
// const mnemonic = fs.readFileSync(".secret").toString().trim();
const Web3 = require("web3");
const net = require("net");
const HDWalletProvider = require("@truffle/hdwallet-provider");
const dotenv = require("dotenv");
dotenv.config();

module.exports = {
  networks: {
    dev: {
      network_id: "*",
      provider: () =>
        new HDWalletProvider({
          privateKeys: [process.env.SECRET],
          providerOrUrl: process.env.RPC_URL
        }),
      gasPrice: process.env.GAS_PRICE
      // from: "0x354e68da6285df1fd80d60f4a3e4f54d7a6c1bac"
      // gas                  - use gas and gasPrice if creating type 0 transactions
      // gasPrice             - all gas values specified in wei
      // maxFeePerGas         - use maxFeePerGas and maxPriorityFeePerGas if creating type 2 transactions (https://eips.ethereum.org/EIPS/eip-1559)
      // maxPriorityFeePerGas -
      // from - default address to use for any transaction Truffle makes during migrations
      // provider - web3 provider instance Truffle should use to talk to the Ethereum network.
      //          - function that returns a web3 provider instance (see below.)
      //          - if specified, host and port are ignored.
      // production: - set to true if you would like to force a dry run to be performed every time you migrate using this network (default: false)
      //             - during migrations Truffle performs a dry-run if you are deploying to a 'known network'
      // skipDryRun: - set to true if you don't want to test run the migration locally before the actual migration (default: false)
      // confirmations: - number of confirmations to wait between deployments (default: 0)
      // timeoutBlocks: - if a transaction is not mined, keep waiting for this number of blocks (default: 50)
      // deploymentPollingInterval: - duration between checks for completion of deployment transactions
      // networkCheckTimeout: - amount of time for Truffle to wait for a response from the node when testing the provider (in milliseconds)
      //                      - increase this number if you have a slow internet connection to avoid connection errors (default: 5000)
      // disableConfirmationListener: - set to true to disable web3's confirmation listener
    }
    // how to deploy: 1. unlock account ; 2. ddeploy
  },

  // Set default mocha options here, use special reporters etc.
  mocha: {
    // timeout: 100000
  },

  // Configure your compilers
  compilers: {
    solc: {
      version: "^0.5.17",
      // docker: true,        // Use "0.5.1" you've installed locally with docker (default: false)
      settings: {
        // See the solidity docs for advice about optimization and evmVersion
        optimizer: {
          enabled: true,
          runs: 10000
        }
        //  evmVersion: "byzantium"
      }
    }
  },
  plugins: ["solidity-coverage"]
};
