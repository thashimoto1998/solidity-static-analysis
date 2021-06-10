pragma solidity >=0.6.0 <0.8.0;

import "./B.sol";
import "./IC.sol";
import "./D.sol";
import  "./E.sol";

contract A is B {
    using E for e;

    address public cContractAddress;

    D public dContract;
    address public dContractAddress;

    constructor(
        address _cContractAddress,
        address _dContractAddress
    ) {
        cContractAddress = _cContractAddress;
        dContract = D(_dContractAddress);
    }

    function aFunc() public {
        // call parent contract(B contract) function
        func();

        // call C contract function via interface
        IC(cContractAddress).func();

        // call D contract function 
        dContract.func();

        // call E library
        E.func();

        overloadingFunc(uint(10));
        overloadingFunc(uint(10), true);
    }

    function overloadingFunc(uint _in) public {}
    function overloadingFunc(uint _in, bool _really) public {}
}