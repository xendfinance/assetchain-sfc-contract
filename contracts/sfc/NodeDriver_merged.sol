pragma solidity ^0.5.0;
pragma experimental ABIEncoderV2;

/**
 * @dev Wrappers over Solidity's arithmetic operations with added overflow
 * checks.
 *
 * Arithmetic operations in Solidity wrap on overflow. This can easily result
 * in bugs, because programmers usually assume that an overflow raises an
 * error, which is the standard behavior in high level programming languages.
 * `SafeMath` restores this intuition by reverting the transaction when an
 * operation overflows.
 *
 * Using this library instead of the unchecked operations eliminates an entire
 * class of bugs, so it's recommended to use it always.
 */
library SafeMath {
    /**
     * @dev Returns the addition of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `+` operator.
     *
     * Requirements:
     * - Addition cannot overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");

        return c;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return sub(a, b, "SafeMath: subtraction overflow");
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting with custom message on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     * - Subtraction cannot overflow.
     *
     * _Available since v2.4.0._
     */
    function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b <= a, errorMessage);
        uint256 c = a - b;

        return c;
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `*` operator.
     *
     * Requirements:
     * - Multiplication cannot overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");

        return c;
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return div(a, b, "SafeMath: division by zero");
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts with custom message on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     *
     * _Available since v2.4.0._
     */
    function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        // Solidity only automatically asserts when dividing by 0
        require(b > 0, errorMessage);
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold

        return c;
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return mod(a, b, "SafeMath: modulo by zero");
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts with custom message when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     *
     * _Available since v2.4.0._
     */
    function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b != 0, errorMessage);
        return a % b;
    }
}

/**
 * @title Initializable
 *
 * @dev Helper contract to support initializer functions. To use it, replace
 * the constructor with a function that has the `initializer` modifier.
 * WARNING: Unlike constructors, initializer functions must be manually
 * invoked. This applies both to deploying an Initializable contract, as well
 * as extending an Initializable contract via inheritance.
 * WARNING: When used with inheritance, manual care must be taken to not invoke
 * a parent initializer twice, or ensure that all initializers are idempotent,
 * because this is not dealt with automatically as with constructors.
 */
contract Initializable {

  /**
   * @dev Indicates that the contract has been initialized.
   */
  bool private initialized;

  /**
   * @dev Indicates that the contract is in the process of being initialized.
   */
  bool private initializing;

  /**
   * @dev Modifier to use in the initializer function of a contract.
   */
  modifier initializer() {
    require(initializing || isConstructor() || !initialized, "Contract instance has already been initialized");

    bool isTopLevelCall = !initializing;
    if (isTopLevelCall) {
      initializing = true;
      initialized = true;
    }

    _;

    if (isTopLevelCall) {
      initializing = false;
    }
  }

  /// @dev Returns true if and only if the function is running in the constructor
  function isConstructor() private view returns (bool) {
    // extcodesize checks the size of the code stored in an address, and
    // address returns the current address. Since the code is still not
    // deployed when running a constructor, any checks on its code size will
    // yield zero, making it an effective way to detect if a contract is
    // under construction or not.
    address self = address(this);
    uint256 cs;
    assembly { cs := extcodesize(self) }
    return cs == 0;
  }

  // Reserved storage space to allow for layout changes in the future.
  uint256[50] private ______gap;
}

/**
 * @dev Contract module which provides a basic access control mechanism, where
 * there is an account (an owner) that can be granted exclusive access to
 * specific functions.
 *
 * This module is used through inheritance. It will make available the modifier
 * `onlyOwner`, which can be aplied to your functions to restrict their use to
 * the owner.
 */
contract Ownable is Initializable {
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    function initialize(address sender) internal initializer {
        _owner = sender;
        emit OwnershipTransferred(address(0), _owner);
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        require(isOwner(), "Ownable: caller is not the owner");
        _;
    }

    /**
     * @dev Returns true if the caller is the current owner.
     */
    function isOwner() public view returns (bool) {
        return msg.sender == _owner;
    }

    /**
     * @dev Leaves the contract without owner. It will not be possible to call
     * `onlyOwner` functions anymore. Can only be called by the current owner.
     *
     * > Note: Renouncing ownership will leave the contract without an owner,
     * thereby removing any functionality that is only available to the owner.
     */
    function renounceOwnership() public onlyOwner {
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public onlyOwner {
        _transferOwnership(newOwner);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     */
    function _transferOwnership(address newOwner) internal {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }

    uint256[50] private ______gap;
}

interface SFCI {

    struct WithdrawalRequest {
        uint256 epoch;
        uint256 time;
        uint256 amount;
    }

    function currentSealedEpoch() external view returns (uint256);

    function getEpochSnapshot(uint256) external view returns (uint256 endTime, uint256 epochFee, uint256 totalBaseRewardWeight, uint256 totalTxRewardWeight, uint256 _baseRewardPerSecond, uint256 totalStake, uint256 totalSupply);

    function getLockupInfo(address, uint256) external view returns (uint256 lockedStake, uint256 fromEpoch, uint256 endTime, uint256 duration);

    function getStake(address, uint256) external view returns (uint256);

    function getStashedLockupRewards(address, uint256) external view returns (uint256 lockupExtraReward, uint256 lockupBaseReward, uint256 unlockedReward);

    function getValidator(uint256) external view returns (uint256 status, uint256 deactivatedTime, uint256 deactivatedEpoch, uint256 receivedStake, uint256 createdEpoch, uint256 createdTime, address auth);

    function getValidatorID(address) external view returns (uint256);

    function getValidatorPubkey(uint256) external view returns (bytes memory);

    function getWithdrawalRequest(address, uint256, uint256) external view returns (uint256 epoch, uint256 time, uint256 amount);

    function isOwner() external view returns (bool);

    function lastValidatorID() external view returns (uint256);

    function minGasPrice() external view returns (uint256);

    function owner() external view returns (address);

    function renounceOwnership() external;

    function slashingRefundRatio(uint256) external view returns (uint256);

    function stakeTokenizerAddress() external view returns (address);

    function stashedRewardsUntilEpoch(address, uint256) external view returns (uint256);

    function totalActiveStake() external view returns (uint256);

    function totalSlashedStake() external view returns (uint256);

    function totalStake() external view returns (uint256);

    function totalSupply() external view returns (uint256);

    function transferOwnership(address newOwner) external;

    function treasuryAddress() external view returns (address);

    function version() external pure returns (bytes3);

    function currentEpoch() external view returns (uint256);

    function updateConstsAddress(address v) external;

    function constsAddress() external view returns (address);

    function getEpochValidatorIDs(uint256 epoch) external view returns (uint256[] memory);

    function getEpochReceivedStake(uint256 epoch, uint256 validatorID) external view returns (uint256);

    function getEpochAccumulatedRewardPerToken(uint256 epoch, uint256 validatorID) external view returns (uint256);

    function getEpochAccumulatedUptime(uint256 epoch, uint256 validatorID) external view returns (uint256);

    function getEpochAccumulatedOriginatedTxsFee(uint256 epoch, uint256 validatorID) external view returns (uint256);

    function getEpochOfflineTime(uint256 epoch, uint256 validatorID) external view returns (uint256);

    function getEpochOfflineBlocks(uint256 epoch, uint256 validatorID) external view returns (uint256);

    function rewardsStash(address delegator, uint256 validatorID) external view returns (uint256);

    function getLockedStake(address delegator, uint256 toValidatorID) external view returns (uint256);

    function createValidator(bytes calldata pubkey) external payable;

    function getSelfStake(uint256 validatorID) external view returns (uint256);

    function delegate(uint256 toValidatorID) external payable;

    function undelegate(uint256 toValidatorID, uint256 amount) external;

    function isSlashed(uint256 validatorID) external view returns (bool);

    function withdraw(uint256 toValidatorID, uint256 wrID) external;

    function deactivateValidator(uint256 validatorID, uint256 status) external;

    function pendingRewards(address delegator, uint256 toValidatorID) external view returns (uint256);

    function stashRewards(address delegator, uint256 toValidatorID) external;

    function claimRewards(uint256 toValidatorID) external;

    function restakeRewards(uint256 toValidatorID) external;

    function updateBaseRewardPerSecond(uint256 value) external;

    function updateOfflinePenaltyThreshold(uint256 blocksNum, uint256 time) external;

    function updateSlashingRefundRatio(uint256 validatorID, uint256 refundRatio) external;

    function updateStakeTokenizerAddress(address addr) external;

    function updateTreasuryAddress(address v) external;

    function burnRWA(uint256 amount) external;

    function sealEpoch(uint256[] calldata offlineTime, uint256[] calldata offlineBlocks, uint256[] calldata uptimes, uint256[] calldata originatedTxsFee, uint256 epochGas) external;

    function sealEpochValidators(uint256[] calldata nextValidatorIDs) external;

    function isLockedUp(address delegator, uint256 toValidatorID) external view returns (bool);

    function getUnlockedStake(address delegator, uint256 toValidatorID) external view returns (uint256);

    function lockStake(uint256 toValidatorID, uint256 lockupDuration, uint256 amount) external;

    function relockStake(uint256 toValidatorID, uint256 lockupDuration, uint256 amount) external;

    function unlockStake(uint256 toValidatorID, uint256 amount) external returns (uint256);

    function initialize(uint256 sealedEpoch, uint256 _totalSupply, address nodeDriver, address lib, address consts, address _owner) external;

    function setGenesisValidator(address auth, uint256 validatorID, bytes calldata pubkey, uint256 status, uint256 createdEpoch, uint256 createdTime, uint256 deactivatedEpoch, uint256 deactivatedTime) external;

    function setGenesisDelegation(address delegator, uint256 toValidatorID, uint256 stake, uint256 lockedStake, uint256 lockupFromEpoch, uint256 lockupEndTime, uint256 lockupDuration, uint256 earlyUnlockPenalty, uint256 rewards) external;

    function updateVoteBookAddress(address v) external;

    function voteBookAddress() external view returns (address);

    function liquidateSRWA(address delegator, uint256 toValidatorID, uint256 amount) external;

    function updateSRWAFinalizer(address v) external;

    function getWrRequests(
        address delegator,
        uint256 validatorID,
        uint256 offset,
        uint256 limit
    ) external view returns (WithdrawalRequest[] memory);

}

interface NodeDriverExecutable {
    function execute() external;
}

contract NodeDriverAuth_merged is Initializable, Ownable {
    using SafeMath for uint256;

    SFCI internal sfc;
    NodeDriver internal driver;

    // Initialize NodeDriverAuth_merged, NodeDriver and SFC in one call to allow fewer genesis transactions
    function initialize(address payable _sfc, address _driver, address _owner) external initializer {
        Ownable.initialize(_owner);
        driver = NodeDriver(_driver);
        sfc = SFCI(_sfc);
    }

    modifier onlySFC() {
        require(msg.sender == address(sfc), "caller is not the SFC contract");
        _;
    }

    modifier onlyDriver() {
        require(msg.sender == address(driver), "caller is not the NodeDriver contract");
        _;
    }

    function migrateTo(address newDriverAuth) external onlyOwner {
        driver.setBackend(newDriverAuth);
    }

    function _execute(address executable, address newOwner, bytes32 selfCodeHash, bytes32 driverCodeHash) internal {
        _transferOwnership(executable);
        NodeDriverExecutable(executable).execute();
        _transferOwnership(newOwner);
        //require(driver.backend() == address(this), "ownership of driver is lost");
        require(_getCodeHash(address(this)) == selfCodeHash, "self code hash doesn't match");
        require(_getCodeHash(address(driver)) == driverCodeHash, "driver code hash doesn't match");
    }

    function execute(address executable) external onlyOwner {
        _execute(executable, owner(), _getCodeHash(address(this)), _getCodeHash(address(driver)));
    }

    function mutExecute(address executable, address newOwner, bytes32 selfCodeHash, bytes32 driverCodeHash) external onlyOwner {
        _execute(executable, newOwner, selfCodeHash, driverCodeHash);
    }

    function incBalance(address acc, uint256 diff) external onlySFC {
        require(acc == address(sfc), "recipient is not the SFC contract");
        driver.setBalance(acc, address(acc).balance.add(diff));
    }

    function upgradeCode(address acc, address from) external onlyOwner {
        require(isContract(acc) && isContract(from), "not a contract");
        driver.copyCode(acc, from);
    }

    function copyCode(address acc, address from) external onlyOwner {
        driver.copyCode(acc, from);
    }

    function incNonce(address acc, uint256 diff) external onlyOwner {
        driver.incNonce(acc, diff);
    }

    function updateNetworkRules(bytes calldata diff) external onlyOwner {
        driver.updateNetworkRules(diff);
    }

    function updateMinGasPrice(uint256 minGasPrice) external onlySFC {
        driver.updateNetworkRules(bytes(strConcat("{\"Economy\":{\"MinGasPrice\":", uint256ToStr(minGasPrice), "}}")));
    }

    function updateNetworkVersion(uint256 version) external onlyOwner {
        driver.updateNetworkVersion(version);
    }

    function advanceEpochs(uint256 num) external onlyOwner {
        driver.advanceEpochs(num);
    }

    function updateValidatorWeight(uint256 validatorID, uint256 value) external onlySFC {
        driver.updateValidatorWeight(validatorID, value);
    }

    function updateValidatorPubkey(uint256 validatorID, bytes calldata pubkey) external onlySFC {
        driver.updateValidatorPubkey(validatorID, pubkey);
    }

    function setGenesisValidator(address _auth, uint256 validatorID, bytes calldata pubkey, uint256 status, uint256 createdEpoch, uint256 createdTime, uint256 deactivatedEpoch, uint256 deactivatedTime) external onlyDriver {
        sfc.setGenesisValidator(_auth, validatorID, pubkey, status, createdEpoch, createdTime, deactivatedEpoch, deactivatedTime);
    }

    function setGenesisDelegation(address delegator, uint256 toValidatorID, uint256 stake, uint256 lockedStake, uint256 lockupFromEpoch, uint256 lockupEndTime, uint256 lockupDuration, uint256 earlyUnlockPenalty, uint256 rewards) external onlyDriver {
        sfc.setGenesisDelegation(delegator, toValidatorID, stake, lockedStake, lockupFromEpoch, lockupEndTime, lockupDuration, earlyUnlockPenalty, rewards);
    }

    function deactivateValidator(uint256 validatorID, uint256 status) external onlyDriver {
        sfc.deactivateValidator(validatorID, status);
    }

    function sealEpochValidators(uint256[] calldata nextValidatorIDs) external onlyDriver {
        sfc.sealEpochValidators(nextValidatorIDs);
    }

    function sealEpoch(uint256[] calldata offlineTimes, uint256[] calldata offlineBlocks, uint256[] calldata uptimes, uint256[] calldata originatedTxsFee, uint256 usedGas) external onlyDriver {
        sfc.sealEpoch(offlineTimes, offlineBlocks, uptimes, originatedTxsFee, usedGas);
    }

    function isContract(address account) internal view returns (bool) {
        uint256 size;
        // solhint-disable-next-line no-inline-assembly
        assembly {size := extcodesize(account)}
        return size > 0;
    }

    function decimalsNum(uint256 num) internal pure returns (uint256) {
        uint decimals;
        while (num != 0) {
            decimals++;
            num /= 10;
        }
        return decimals;
    }

    function uint256ToStr(uint256 num) internal pure returns (string memory) {
        if (num == 0) {
            return "0";
        }
        uint decimals = decimalsNum(num);
        bytes memory bstr = new bytes(decimals);
        uint strIdx = decimals - 1;
        while (num != 0) {
            bstr[strIdx] = byte(uint8(48 + num % 10));
            num /= 10;
            strIdx--;
        }
        return string(bstr);
    }

    function strConcat(string memory _a, string memory _b, string memory _c) internal pure returns (string memory) {
        bytes memory _ba = bytes(_a);
        bytes memory _bb = bytes(_b);
        bytes memory _bc = bytes(_c);
        string memory abc = new string(_ba.length + _bb.length + _bc.length);
        bytes memory babc = bytes(abc);
        uint k = 0;
        uint i = 0;
        for (i = 0; i < _ba.length; i++) {
            babc[k++] = _ba[i];
        }
        for (i = 0; i < _bb.length; i++) {
            babc[k++] = _bb[i];
        }
        for (i = 0; i < _bc.length; i++) {
            babc[k++] = _bc[i];
        }
        return string(babc);
    }

    function _getCodeHash(address addr) internal view returns (bytes32) {
        bytes32 codeHash;
        assembly {codeHash := extcodehash(addr)}
        return codeHash;
    }
}

contract NodeDriver is Initializable {
    uint256 private erased0;
    NodeDriverAuth_merged internal backend;
    EVMWriter internal evmWriter;

    event UpdatedBackend(address indexed backend);

    function setBackend(address _backend) external onlyBackend {
        emit UpdatedBackend(_backend);
        backend = NodeDriverAuth_merged(_backend);
    }

    modifier onlyBackend() {
        require(msg.sender == address(backend), "caller is not the backend");
        _;
    }

    event UpdateValidatorWeight(uint256 indexed validatorID, uint256 weight);
    event UpdateValidatorPubkey(uint256 indexed validatorID, bytes pubkey);

    event UpdateNetworkRules(bytes diff);
    event UpdateNetworkVersion(uint256 version);
    event AdvanceEpochs(uint256 num);

    function initialize(address _backend, address _evmWriterAddress) external initializer {
        backend = NodeDriverAuth_merged(_backend);
        emit UpdatedBackend(_backend);
        evmWriter = EVMWriter(_evmWriterAddress);
    }

    function setBalance(address acc, uint256 value) external onlyBackend {
        evmWriter.setBalance(acc, value);
    }

    function copyCode(address acc, address from) external onlyBackend {
        evmWriter.copyCode(acc, from);
    }

    function swapCode(address acc, address with) external onlyBackend {
        evmWriter.swapCode(acc, with);
    }

    function setStorage(address acc, bytes32 key, bytes32 value) external onlyBackend {
        evmWriter.setStorage(acc, key, value);
    }

    function incNonce(address acc, uint256 diff) external onlyBackend {
        evmWriter.incNonce(acc, diff);
    }

    function updateNetworkRules(bytes calldata diff) external onlyBackend {
        emit UpdateNetworkRules(diff);
    }

    function updateNetworkVersion(uint256 version) external onlyBackend {
        emit UpdateNetworkVersion(version);
    }

    function advanceEpochs(uint256 num) external onlyBackend {
        emit AdvanceEpochs(num);
    }

    function updateValidatorWeight(uint256 validatorID, uint256 value) external onlyBackend {
        emit UpdateValidatorWeight(validatorID, value);
    }

    function updateValidatorPubkey(uint256 validatorID, bytes calldata pubkey) external onlyBackend {
        emit UpdateValidatorPubkey(validatorID, pubkey);
    }

    modifier onlyNode() {
        require(msg.sender == address(0), "not callable");
        _;
    }

    // Methods which are called only by the node

    function setGenesisValidator(address _auth, uint256 validatorID, bytes calldata pubkey, uint256 status, uint256 createdEpoch, uint256 createdTime, uint256 deactivatedEpoch, uint256 deactivatedTime) external onlyNode {
        backend.setGenesisValidator(_auth, validatorID, pubkey, status, createdEpoch, createdTime, deactivatedEpoch, deactivatedTime);
    }

    function setGenesisDelegation(address delegator, uint256 toValidatorID, uint256 stake, uint256 lockedStake, uint256 lockupFromEpoch, uint256 lockupEndTime, uint256 lockupDuration, uint256 earlyUnlockPenalty, uint256 rewards) external onlyNode {
        backend.setGenesisDelegation(delegator, toValidatorID, stake, lockedStake, lockupFromEpoch, lockupEndTime, lockupDuration, earlyUnlockPenalty, rewards);
    }

    function deactivateValidator(uint256 validatorID, uint256 status) external onlyNode {
        backend.deactivateValidator(validatorID, status);
    }

    function sealEpochValidators(uint256[] calldata nextValidatorIDs) external onlyNode {
        backend.sealEpochValidators(nextValidatorIDs);
    }

    function sealEpoch(uint256[] calldata offlineTimes, uint256[] calldata offlineBlocks, uint256[] calldata uptimes, uint256[] calldata originatedTxsFee) external onlyNode {
        backend.sealEpoch(offlineTimes, offlineBlocks, uptimes, originatedTxsFee, 841669690);
    }

    function sealEpochV1(uint256[] calldata offlineTimes, uint256[] calldata offlineBlocks, uint256[] calldata uptimes, uint256[] calldata originatedTxsFee, uint256 usedGas) external onlyNode {
        backend.sealEpoch(offlineTimes, offlineBlocks, uptimes, originatedTxsFee, usedGas);
    }
}

interface EVMWriter {
    function setBalance(address acc, uint256 value) external;

    function copyCode(address acc, address from) external;

    function swapCode(address acc, address with) external;

    function setStorage(address acc, bytes32 key, bytes32 value) external;

    function incNonce(address acc, uint256 diff) external;
}
