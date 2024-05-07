pragma solidity ^0.8.25;

contract Wallet {
    //state: used
    bool initialize; 
    mapping(address => uint256) balance;
    event Transfer(address indexed _from, address indexed _to, uint256 _amount);

    //function initializer replace constructor
    function initializer() external {
        require(initialize != true);
        initialize = true;
    } 

    function getBalance(address _owner) external view returns(uint256){
        require(_owner != address(0));
        return balance[_owner];
    }

    function transfer(address payable _to, uint256 amount) external view returns(bool){
        require(_to != address(0));
        require(balance[msg.sender] >= amount);
        return true;
    }

    receive() payable external{
        balance[msg.sender] += msg.value;
    }


}
