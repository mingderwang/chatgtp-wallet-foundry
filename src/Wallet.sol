// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Wallet {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    // EIP-1271 compliant function to validate a signature
    function isValidSignature(bytes32 hash, bytes memory signature) public view returns (bytes4) {
        bytes32 messageHash = keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32", hash));
        address recoveredSigner = recoverSigner(messageHash, signature);
        
        if (recoveredSigner == owner) {
            return 0x1626ba7e; // Magic value for valid signatures
        } else {
            return 0xffffffff; // Invalid signature
        }
    }

    function recoverSigner(bytes32 _hash, bytes memory _signature) internal pure returns (address) {
        (bytes32 r, bytes32 s, uint8 v) = splitSignature(_signature);
        return ecrecover(_hash, v, r, s);
    }

    function splitSignature(bytes memory sig) internal pure returns (bytes32 r, bytes32 s, uint8 v) {
        require(sig.length == 65, "Invalid signature length");

        assembly {
            r := mload(add(sig, 32))
            s := mload(add(sig, 64))
            v := byte(0, mload(add(sig, 96)))
        }

        return (r, s, v);
    }
}
