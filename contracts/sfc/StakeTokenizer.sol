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

    mapping(address => mapping(uint256 => uint256)) public outstandingSRWA;

    address public sRWATokenAddress;

    function initialize(address payable _sfc, address _sRWATokenAddress) public initializer {
        sfc = SFC(_sfc);
        sRWATokenAddress = _sRWATokenAddress;
    }

    function mintSRWA(uint256 toValidatorID) external {
        revert("sRWA minting is disabled");
//        address delegator = msg.sender;
//        uint256 lockedStake = sfc.getLockedStake(delegator, toValidatorID);
//        require(lockedStake > 0, "delegation isn't locked up");
//        require(lockedStake > outstandingSRWA[delegator][toValidatorID], "sRWA is already minted");
//
//        uint256 diff = lockedStake - outstandingSRWA[delegator][toValidatorID];
//        outstandingSRWA[delegator][toValidatorID] = lockedStake;
//
//        // It's important that we mint after updating outstandingSRWA (protection against Re-Entrancy)
//        require(ERC20Mintable(sRWATokenAddress).mint(delegator, diff), "failed to mint sRWA");
    }

    function redeemSRWA(uint256 validatorID, uint256 amount) external {
        require(outstandingSRWA[msg.sender][validatorID] >= amount, "low outstanding sRWA balance");
        require(IERC20(sRWATokenAddress).allowance(msg.sender, address(this)) >= amount, "insufficient allowance");
        outstandingSRWA[msg.sender][validatorID] -= amount;

        // It's important that we burn after updating outstandingSRWA (protection against Re-Entrancy)
        ERC20Burnable(sRWATokenAddress).burnFrom(msg.sender, amount);
    }

    function redeemSRWAFor(address payer, address delegator, uint256 validatorID, uint256 amount) external {
        require(msg.sender == address(sfc), "not SFC");
        require(outstandingSRWA[delegator][validatorID] >= amount, "low outstanding sRWA balance");
        require(IERC20(sRWATokenAddress).allowance(payer, address(this)) >= amount, "insufficient allowance");
        outstandingSRWA[delegator][validatorID] -= amount;

        // It's important that we burn after updating outstandingSRWA (protection against Re-Entrancy)
        ERC20Burnable(sRWATokenAddress).burnFrom(payer, amount);
    }

    function allowedToWithdrawStake(address sender, uint256 validatorID) public view returns(bool) {
        return outstandingSRWA[sender][validatorID] == 0;
    }
}
