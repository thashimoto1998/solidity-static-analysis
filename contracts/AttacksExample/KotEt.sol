pragma solidity 0.7.6;

contract KotEt {
    address payable public king;
    uint public claimPrice = 100;
    address payable owner;

    constructor() {
        owner = msg.sender;
        king = msg.sender;
    }

    function sweepCommission(uint amount) public {
        owner.send(amount);
    }

    fallback() external payable {
        assert(msg.value < claimPrice);

        uint compensation = caculateCompensation();
        king.send(compensation);
        king = msg.sender;
        claimPrice = calculateNewPrice();
    }


    // These function is used for only compile    
    function caculateCompensation() private returns (uint) {
        return 1;
    }

    function calculateNewPrice() private returns (uint) {
        return 1;
    }
}