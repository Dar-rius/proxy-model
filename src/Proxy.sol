pragma solidity ^0.8.25;

contract Proxy {
    address logic;

    fallback() external payable{
        _delegateLogic(logic);
    }

    function _implementation(address _logic) external{
        logic = _logic;
    }

    function _delegateLogic(address implementation) internal {
        assembly{
            calldatacopy(0, 0, calldatasize())

            let result := delegatecall(gas(),implementation, 0, calldatasize(), 0, 0)

            returndatacopy(0, 0, returndatasize())
            
            switch result
            case 0{
                revert(0, returndatasize())
            }
            default{
                revert(0, returndatasize())
            }
        }
    }
}
