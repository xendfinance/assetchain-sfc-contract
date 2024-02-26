pragma solidity ^0.5.0;

import "./SFC.sol";
import "../erc20/base/ERC20Burnable.sol";
import "../erc20/base/ERC20Mintable.sol";
import "../common/Initializable.sol";

contract Spacer {
    address private _owner;
}

contract StakeTokenizer is Spacer, Initializable {
    SFC internal sfc;

    mapping(address => mapping(uint256 => uint256)) public outstandingSVITRA;

    address public sVITRATokenAddress;

    function initialize(address payable _sfc, address _sVITRATokenAddress) public initializer {
        sfc = SFC(_sfc);
        sVITRATokenAddress = _sVITRATokenAddress;
    }

    function mintSVITRA(uint256 toValidatorID) external {
        revert("sVITRA minting is disabled");
//        address delegator = msg.sender;
//        uint256 lockedStake = sfc.getLockedStake(delegator, toValidatorID);
//        require(lockedStake > 0, "delegation isn't locked up");
//        require(lockedStake > outstandingSVITRA[delegator][toValidatorID], "sVITRA is already minted");
//
//        uint256 diff = lockedStake - outstandingSVITRA[delegator][toValidatorID];
//        outstandingSVITRA[delegator][toValidatorID] = lockedStake;
//
//        // It's important that we mint after updating outstandingSVITRA (protection against Re-Entrancy)
//        require(ERC20Mintable(sVITRATokenAddress).mint(delegator, diff), "failed to mint sVITRA");
    }

    function redeemSVITRA(uint256 validatorID, uint256 amount) external {
        require(outstandingSVITRA[msg.sender][validatorID] >= amount, "low outstanding sVITRA balance");
        require(IERC20(sVITRATokenAddress).allowance(msg.sender, address(this)) >= amount, "insufficient allowance");
        outstandingSVITRA[msg.sender][validatorID] -= amount;

        // It's important that we burn after updating outstandingSVITRA (protection against Re-Entrancy)
        ERC20Burnable(sVITRATokenAddress).burnFrom(msg.sender, amount);
    }

    function redeemSVITRAFor(address payer, address delegator, uint256 validatorID, uint256 amount) external {
        require(msg.sender == address(sfc), "not SFC");
        require(outstandingSVITRA[delegator][validatorID] >= amount, "low outstanding sVITRA balance");
        require(IERC20(sVITRATokenAddress).allowance(payer, address(this)) >= amount, "insufficient allowance");
        outstandingSVITRA[delegator][validatorID] -= amount;

        // It's important that we burn after updating outstandingSVITRA (protection against Re-Entrancy)
        ERC20Burnable(sVITRATokenAddress).burnFrom(payer, amount);
    }

    function allowedToWithdrawStake(address sender, uint256 validatorID) public view returns(bool) {
        return outstandingSVITRA[sender][validatorID] == 0;
    }
}
