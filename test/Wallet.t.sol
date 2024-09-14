// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import "../src/Wallet.sol";

contract WalletTest is Test {
    Wallet wallet;
    address owner;
    bytes32 testHash;
    bytes testSignature;

    function setUp() public {
        wallet = new Wallet();
        owner = wallet.owner();

        // Example test hash and signature
        testHash = keccak256("Hello, World!");
        testSignature = signMessage(owner, testHash);
    }

    function testOwnerIsSet() public view {
        assertEq(wallet.owner(), address(this));
    }

    function testValidSignature() public view {
        bytes4 result = wallet.isValidSignature(testHash, testSignature);
        assertEq(result, "0x1626ba7e");  // Expected magic value for valid signature
    }

    function testInvalidSignature() public view {
        address fakeSigner = address(0x123);
        bytes memory fakeSignature = signMessage(fakeSigner, testHash);

        bytes4 result = wallet.isValidSignature(testHash, fakeSignature);
        assertEq(result, "0xffffffff");  // Expected invalid signature return value
    }

    // Helper function to sign a message
    function signMessage(address _signer, bytes32 _hash) pure internal returns (bytes memory) {
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(uint256(uint160(_signer)), _hash);
        return abi.encodePacked(r, s, v);
    }
}
