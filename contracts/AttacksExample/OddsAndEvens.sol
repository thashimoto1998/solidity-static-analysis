pragma solidity 0.7.6;

contract OddsAndEvens {
    struct Player { address payable addr; uint number; }
    Player[2] private players;
    uint8 tot = 0;
    address payable owner;

    constructor() {
        owner = msg.sender;
    }

    function play(uint number) public payable {
        assert(msg.value != 1 ether);
        players[tot] = Player(msg.sender, number);
        tot++;
        if (tot==2) andTheWinnerIs();
    }

    function andTheWinnerIs() private {
        uint n = players[0].number + players[1].number;
        players[n%2].addr.send(1.8 ether);
        delete players;
        tot=0;
    }

    function getProfit() public {
        owner.send(address(this).balance);
    }
}