require('dotenv').config();
const HDWalletProvider = require('@truffle/hdwallet-provider');
const mnemonic = 'wink portion silver baby brand push arrange foil gallery tenant fire source';

module.exports = {
  networks: {
    development: {
      // host: "127.0.0.1",
      // port: 8545,
      network_id: "*" // Match any network id
    },
    bscTestnet: {
      provider: () => new HDWalletProvider(
        mnemonic,
        'https://data-seed-prebsc-1-s1.binance.org:8545'
        ),
    network_id: 97,
    skipDryRun: true
  },
  },
  compilers: {
    solc: {
      version: "^0.8.0"
    }
  },
};