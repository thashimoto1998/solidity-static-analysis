import { HardhatUserConfig } from "hardhat/types";

import '@nomiclabs/hardhat-waffle';
import "@typechain/hardhat";

const config: HardhatUserConfig = {
  solidity: {
    compilers: [{ version: "0.7.6", settings: {} }],
  },
}

export default config;