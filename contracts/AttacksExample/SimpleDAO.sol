pragma solidity 0.7.6;

contract SimpleDAO {
    mapping (address => uint) public credit;
    function donate(address to) public payable { credit[to] += msg.value; }
    function queryCredit(address to) public returns (uint) {
        return credit[to];
    }
    function withdraw(uint amount) public {
        if (credit[msg.sender] >= amount) {
            msg.sender.transfer(amount);
            credit[msg.sender] -= amount;
        }
    }
}