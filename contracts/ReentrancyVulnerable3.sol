pragma solidity 0.7.6;

contract ReentrancyVurnerable3 {
    mapping (address => uint) private userBalances;
    mapping (address => bool) private claimedBonus;
    mapping (address => uint) private rewardsForA;

    function withdrawReward(address payable recipient) public {
        uint amountToWithdraw = rewardsForA[recipient];
        rewardsForA[recipient] = 0;
        recipient.transfer(amountToWithdraw);
    }

    function getFirstWithdrawalBonus(address payable recipient) public {
        require(!claimedBonus[recipient]); // Each recipient should only be able to claim the bonus once

        rewardsForA[recipient] += 100;
        withdrawReward(recipient); // At this point, the caller will be able to execute getFirstWithdrawlBonus again.
        claimedBonus[recipient] = true;
    }
}