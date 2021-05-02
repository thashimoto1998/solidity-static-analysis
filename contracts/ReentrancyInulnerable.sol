pragma solidity 0.7.6;

contract ReentrancyInvulnerable {
    
    mapping(address => uint) private shares;

    function b() external {
        uint amount = shares[msg.sender];
        shares[msg.sender] = 0;
        msg.sender.transfer(amount);
    }
}