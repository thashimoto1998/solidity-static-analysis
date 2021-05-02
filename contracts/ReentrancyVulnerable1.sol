pragma solidity 0.7.6;

contract ReentrancyVulnerable1 {
    
    mapping(address => uint) private shares;

    function b() external {
        uint amount = shares[msg.sender];
        msg.sender.transfer(amount);
        shares[msg.sender] = 0;
    }
}