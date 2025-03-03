// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Script} from "../lib/forge-std/src/Script.sol";
import {DevOpsTools} from "../lib/foundry-devOps/src/DevOpsTools.sol";
import {BasicNft} from "../src/BasicNft.sol";

contract MintBasicNft is Script {

    string constant STBERNARD = "https://bafybeigkpf3iudp5t33u7nhaa66jdpyxfo57ehua3uibgo5elbyzyqktty.ipfs.dweb.link?filename=stBernard.json";

    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "BasicNft",
            block.chainid
        );
        mingNftOnContract(mostRecentlyDeployed);

    }

    function mingNftOnContract(address contractAddress) public {
        vm.startBroadcast();
        BasicNft(contractAddress).mintNft(STBERNARD);
        vm.stopBroadcast();
    }
}