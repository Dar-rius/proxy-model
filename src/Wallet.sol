pragma solidity ^0.8.25;

contract Wallet {
    //state: used
    bool used; 

    //function initializer replace constructor
    function initializer() external {
        require(used != true);
        used = true;
    } 

}
