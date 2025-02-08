//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {FundMe} from "../src/FundMe.sol";
import {HelperConfig} from "./HelperConfig.s.sol";

contract DeployFundMe is Script {
    function run() external returns (FundMe) {
        HelperConfig helperConfig = new HelperConfig(); // This line will not compile because the HelperConfig contract is not yet implemented
        // address ethUsdPriceFeed = helperConfig.activeNetworkConfig();
        vm.startBroadcast(); // Start broadcasting the transaction
        address priceFeed = helperConfig.getConfigByChainId(block.chainid).priceFeed;
        FundMe fundMe = new FundMe(priceFeed);
        vm.stopBroadcast(); // Stop broadcasting the transaction
        return fundMe;
    }
}
