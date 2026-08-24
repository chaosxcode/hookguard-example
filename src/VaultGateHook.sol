// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/// @title VaultGateHook — minimal, cleanly-gated example hook
/// @notice Ships scanning-clean on purpose: it demonstrates the guard
///         patterns HookGuard looks for (beforeInitialize gate +
///         PoolManager-only callbacks) as the recommended starting point.
interface IPoolManager {
    function getHookPermissions() external;
}

contract VaultGateHook {
    address public immutable poolManager;
    mapping(address => bool) public allowedHooks;

    error NotPoolManager();
    error UnknownPool();

    event PoolGated(address indexed poolHook);

    modifier onlyPoolManager() {
        if (msg.sender != poolManager) revert NotPoolManager();
        _;
    }

    constructor(address _poolManager) {
        poolManager = _poolManager;
    }

    /// Only pools created through our factory may attach.
    function _beforeInitialize(address sender, bytes32 poolId) internal {
        if (!allowedHooks[sender]) revert UnknownPool();
        emit PoolGated(sender);
    }

    function beforeSwap(bytes32 poolId) external onlyPoolManager returns (bytes4) {
        return this.beforeSwap.selector;
    }
}
