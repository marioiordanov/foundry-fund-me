// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {FundMe} from "../src/FundMe.sol";
import {console} from "forge-std/console.sol";
import {HelperConfig} from "./HelperConfig.s.sol";

contract DeployFundMe is Script {
    constructor() {
        console.log("DeployFundMe.constructor()");
        console.log(" sender: ", msg.sender);
        console.log(" this address: ", address(this));
    }

    function run() external returns (FundMe) {
        // Before startBroadcast => not a real transaction
        // Everything outside of startBroadcast and stopBroadcast is not a real transaction and it is simulated
        HelperConfig helperConfig = new HelperConfig();

        console.log("DeployFundMe.run()");
        // After broadcast => real transaction
        vm.startBroadcast();
        console.log(" sender: ", msg.sender);
        address ethUsdPriceFeed = helperConfig.activeNetworkConfig();

        FundMe fundMe = new FundMe(ethUsdPriceFeed);
        console.log(" fundMe owner: ", fundMe.getOwner());
        vm.stopBroadcast();

        return fundMe;
    }

    function deploy() external {}
}
