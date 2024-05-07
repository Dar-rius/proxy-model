pragma solidity ^0.8.25;

contract Proxy {
    //Error
    error failVerifyContract(address target);
    
    address target;

    fallback() external payable{
        _delegateLogic(target);
    }

    function _implementation(address _target) external{
        target = _verifyTarget(_target);
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

    function _verifyTarget(address target) internal view returns(address){
        require(target != address(0));
        if (target.code.length == 0){
            revert failVerifyContract(target);
        }
        return target;
    }
}
