// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.2;

abstract contract IERC223 {
    function name()        public view virtual returns (string memory);
    function symbol()      public view virtual returns (string memory);
    function decimals()    public view virtual returns (uint8);
    function totalSupply() public view virtual returns (uint256);
    function balanceOf(address who) public virtual view returns (uint);
    function transfer(address to, uint value) public virtual returns (bool success);
    function transfer(address to, uint value, bytes calldata data) public payable virtual returns (bool success);
    event Transfer(address indexed from, address indexed to, uint value, bytes data);
}

contract GasFreeTokenTransfer
{
    uint256 public amount_received;

    function tokenReceived(address _from, uint256 _amount, bytes calldata _data) public returns (bytes4)
    {
        require(_data.length > 0);
        /*
        TxParams memory transaction = abi.decode(_data, (TxParams));

        // Process fee payment.
        IERC223(msg.sender).transfer(block.coinbase, transaction.fee, hex"000000");

        // Process sending to destination.
        IERC223(msg.sender).transfer(transaction.destination, _amount - transaction.fee, transaction.call_data);
        */
        amount_received = _amount;
        (bool success, bytes memory _ret) = address(this).delegatecall(_data);
        delete(_ret);
        delete(amount_received);
        assert(success);
        return 0x8943ec02;
    }

    function processTransferWithFee(address _destination, uint256 _fee, bytes calldata _data) public
    {
        // Process fee payment.
        IERC223(msg.sender).transfer(block.coinbase, _fee, hex"000000");

        // Process sending to destination.
        IERC223(msg.sender).transfer(_destination, amount_received - _fee, _data);
    }
}
