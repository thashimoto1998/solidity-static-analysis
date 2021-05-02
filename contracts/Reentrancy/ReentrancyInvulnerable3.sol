pragma solidity 0.7.6;

contract ReentrancyInvurnerable3 {
    mapping (address => uint) private userBalances;
    mapping (address => bool) private claimedBonus;
    mapping (address => uint) private rewardsForA;

    function untrustedWithdrawReward(address payable recipient) public {
        uint amountToWithdraw = rewardsForA[recipient];
        rewardsForA[recipient] = 0;
        recipient.transfer(amountToWithdraw);
    }

    function untrustedGetFirstWithdrawalBonus(address payable recipient) public {
        require(!claimedBonus[recipient]); // Each recipient should only be able to claim the bonus once

        claimedBonus[recipient] = true;
        rewardsForA[recipient] += 100;
        untrustedWithdrawReward(recipient); // claimedBonus has been set to true, so reentry is impossible
    }
}