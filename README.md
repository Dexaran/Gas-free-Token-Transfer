# Gas-free transfers of a [ERC-223](https://eips.ethereum.org/EIPS/eip-223) token

This contract is deployed at Sepolia Testnet: https://sepolia.etherscan.io/address/0xb05f2a2724d3d8e916b9e1c1b4fe3408a08efe8d

The contract allows a user to send token transfers and pay the fee in the token. It accepts the deposit from a user, where ERC-223 `_data` encodes a subsequent call of the [processTransferWithFee](https://github.com/Dexaran/Gas-free-Token-Transfer/blob/83af3766df3c1df943d92b0c49e06f44b3551d45/GasFreeTokenTransfer.sol#L31) function. `_fee` parameter determines the amount of tokens that the contract will send to the producer of the block this transaction is included to. The remaining amount of tokens is sent to the `_destination`.

Example:
https://sepolia.etherscan.io/tx/0x7af53c4129fe6049c94bf4a4b2dcc2c56bb50183efc0d1fa858ccc4c05fa252c
