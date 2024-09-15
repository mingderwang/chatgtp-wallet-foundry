## ChatGTP is Wrong

```
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
```

It's clear that, Wallet Contract can't use ecrecover to return the signer's address.

```
➜  chatgtp-wallet-foundry git:(main) ✗ forge test
[⠢] Compiling...
No files changed, compilation skipped

Ran 3 tests for test/Wallet.t.sol:WalletTest
[FAIL. Reason: assertion failed: 0xffffffff00000000000000000000000000000000000000000000000000000000 != 0x3078666666666666666600000000000000000000000000000000000000000000] testInvalidSignature() (gas: 18076)
[PASS] testOwnerIsSet() (gas: 10592)
[FAIL. Reason: assertion failed: 0xffffffff00000000000000000000000000000000000000000000000000000000 != 0x3078313632366261376500000000000000000000000000000000000000000000] testValidSignature() (gas: 25801)
Suite result: FAILED. 1 passed; 2 failed; 0 skipped; finished in 66.28ms (5.70ms CPU time)

Ran 1 test suite in 1.16s (66.28ms CPU time): 1 tests passed, 2 failed, 0 skipped (3 total tests)

Failing tests:
Encountered 2 failing tests in test/Wallet.t.sol:WalletTest
[FAIL. Reason: assertion failed: 0xffffffff00000000000000000000000000000000000000000000000000000000 != 0x3078666666666666666600000000000000000000000000000000000000000000] testInvalidSignature() (gas: 18076)
[FAIL. Reason: assertion failed: 0xffffffff00000000000000000000000000000000000000000000000000000000 != 0x3078313632366261376500000000000000000000000000000000000000000000] testValidSignature() (gas: 25801)

Encountered a total of 2 failing tests, 1 tests succeeded
```

## Foundry

**Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.**

Foundry consists of:

-   **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).
-   **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data.
-   **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network.
-   **Chisel**: Fast, utilitarian, and verbose solidity REPL.

## Documentation

https://book.getfoundry.sh/

## Usage

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Format

```shell
$ forge fmt
```

### Gas Snapshots

```shell
$ forge snapshot
```

### Anvil

```shell
$ anvil
```

### Deploy

```shell
$ forge script script/Counter.s.sol:CounterScript --rpc-url <your_rpc_url> --private-key <your_private_key>
```

### Cast

```shell
$ cast <subcommand>
```

### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```
