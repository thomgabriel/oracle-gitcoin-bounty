require('dotenv').config();

const HDWalletProvider = require('truffle-hdwallet-provider');
const infuraProjectId = process.env.INFURA_PROJECT_ID;

module.exports = {
  networks: {
    Kovan: {
      provider: () => new HDWalletProvider("lawsuit gallery hire setup liberty skull dream neutral luxury anxiety crumble please", "https://kovan.infura.io/v3/" + "0ca13cfcf1da4c72a9f6671d222bd905"),
      networkId: 42,       // Kovan's id
    },
    Ropsten: {
      provider: () => new HDWalletProvider("lawsuit gallery hire setup liberty skull dream neutral luxury anxiety crumble please", "https://ropsten.infura.io/v3/" + "0ca13cfcf1da4c72a9f6671d222bd905"),
      networkId: 3,       // Ropsten's id
    },
  },
};