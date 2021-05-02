pragma solidity 0.7.6;

contract ReentrancyVulnerable2 {
    mapping (address => uint) private userBalances;

    function transfer(address to, uint amount) public {
        if (userBalances[msg.sender] >= amount) {
            userBalances[to] += amount;
            userBalances[msg.sender] -= amount;
        }
    }

    function withdrawBalance() public {
        uint amountToWithdraw = userBalances[msg.sender];
        // At this point, the caller's code is executed, and can call transfer()
        msg.sender.transfer(amountToWithdraw);
        userBalances[msg.sender] = 0;
    }
}