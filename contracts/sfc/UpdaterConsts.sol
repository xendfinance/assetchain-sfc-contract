pragma solidity ^0.5.0;

import "./NodeDriver.sol";
import "./SFC.sol";

contract UpdaterConsts {
    address public sfcConsts;
    address public owner;

    constructor(address _sfcConsts, address _owner) public {
        sfcConsts = _sfcConsts;
        owner = _owner;
        require(sfcConsts != address(0) && owner != address(0), "0 address");
    }

    function execute() public {
        address sfcTo = 0xFC00FACE00000000000000000000000000000000;
        _execute(sfcTo);
    }

    function _execute(address sfcTo) internal {
        ConstantsManager consts = ConstantsManager(sfcConsts);
        consts.initialize();
        consts.updateMinSelfStake(100001 * 1e18);
        consts.updateMaxDelegatedRatio(16 * Decimal.unit());
        consts.updateValidatorCommission((15 * Decimal.unit()) / 100);

        consts.updateBurntFeeShare(0);
        consts.updateTreasuryFeeShare((10 * Decimal.unit()) / 100);
        consts.updateUnlockedRewardRatio((30 * Decimal.unit()) / 100);

        consts.updateMinLockupDuration(86400 * 14);
        consts.updateMaxLockupDuration(86400 * 365);
        consts.updateWithdrawalPeriodEpochs(3);
        consts.updateWithdrawalPeriodTime(60 * 60 * 24 * 7);
        consts.updateBaseRewardPerSecond(0);
        consts.updateOfflinePenaltyThresholdTime(5 days);
        consts.updateOfflinePenaltyThresholdBlocksNum(1000);
        consts.updateTargetGasPowerPerSecond(2000000);
        consts.updateGasPriceBalancingCounterweight(3600);
        consts.transferOwnership(owner);
    }
}
