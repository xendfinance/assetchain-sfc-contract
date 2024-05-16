pragma solidity ^0.5.0;

import "../sfc/UpdaterConsts.sol";

contract UnitTestUpdaterConsts is UpdaterConsts {
    constructor(address _sfcConsts, address _owner) UpdaterConsts(_sfcConsts, _owner) public {
    }

    function execute2(address sfcTo) public {
        _execute(sfcTo);
    }
}
