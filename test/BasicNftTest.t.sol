// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Test} from "../lib/forge-std/src/Test.sol";
import {DeployBasicNft} from "../script/DeployBasicNft.s.sol";
import {BasicNft} from "../src/BasicNft.sol";

contract BasicNftTest is Test {
    DeployBasicNft public deployer;
    BasicNft public basicNft;
    address public USER = makeAddr("user");
    string constant STBERNARD = "ipfs://QmVmPUUf1ERaknbaFf76cTMv1DL8RaKzoZ7z3dofsDEgp2";

    function setUp() public {
        deployer = new DeployBasicNft();
        basicNft = deployer.run();
    }

    function testNameIsCorrect() public view {
        string memory expectName = "Dogie";
        string memory actualName = basicNft.name();

        // strings -> array of bytes -->> cannot compare array of bytes
        // for(loop through and compare bytes) -->> too much!!
        // better hash them

        assert(keccak256(abi.encodePacked(expectName)) == (keccak256(abi.encodePacked(actualName))));
    }

    function testCanMintAngHaveABalance() public {
        vm.prank(USER);
        basicNft.mintNft(STBERNARD);

        assert(basicNft.balanceOf(USER) == 1);
        assert(keccak256(abi.encodePacked(STBERNARD)) == keccak256(abi.encodePacked(basicNft.tokenURI(0))));
    }
}
