# hookguard-example

Minimal Uniswap v4 hook project with [HookGuard](https://github.com/chaosxcode/hookguard)
**preinstalled** — every pull request gets scanned for documented v4 risk
patterns (permissionless attachment, missing PoolManager guards, revert-DoS
surfaces…) with line annotations.

## Scan it yourself

```bash
pip install hookguard
hookguard scan --local . 
# or against any repo:
hookguard scan https://github.com/chaosxcode/hookguard-example
```

Expected result: **clean** — this template deliberately shows the guard
patterns scanners look for (`beforeInitialize` gating + `onlyPoolManager`).

## Use as your starting point

1. **Use this template** (or fork), rename things, build your logic.
2. The `.github/workflows/hookguard.yml` job runs on every PR automatically.
3. Findings annotate the offending lines; MEDIUMs never block merges by default.
4. Tune with `fail-on:` / `paths:` inputs — see the
   [action reference](https://github.com/chaosxcode/hookguard#use-it-in-ci).
