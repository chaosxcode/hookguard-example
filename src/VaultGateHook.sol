/// @title VaultGateHook — minimal, cleanly-gated example hook
/// @notice Ships scanning-clean on purpose: it demonstrates the guard
///         patterns HookGuard looks for (beforeInitialize gate +
///         PoolManager-only callbacks) as the recommended starting point.

pragma solidity ^0.8.24;

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

    /// Zero permissions: this template performs no callback logic yet.
    /// Declare flags here as you add callbacks.
    function getHookPermissions() public pure returns (bytes32 perms_) {
        perms_; // all false
    }

    /// Only senders allowlisted by governance may attach pools.
    function _beforeInitialize(address sender) internal {
        if (!allowedHooks[sender]) revert UnknownPool();
        emit PoolGated(sender);
    }

    function beforeSwap(bytes32 poolId) external onlyPoolManager returns (bytes4) {
        return this.beforeSwap.selector;
    }
}
