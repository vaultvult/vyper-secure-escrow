
---

### Vyper (EVM) - `vyper-secure-escrow`

```markdown
# Vyper Secure Escrow ⚖️

![Vyper](https://img.shields.io/badge/Vyper-000000?style=for-the-badge&logo=vyper&logoColor=white)
![EVM](https://img.shields.io/badge/EVM-000000?style=for-the-badge&logo=ethereum&logoColor=white)

## Overview
A gas-optimized, reentrancy-safe escrow contract written in **Vyper**. 

Escrow contracts are prime targets for reentrancy attacks (similar to The DAO hack). Vyper's Python-inspired, minimalist syntax is designed to make secure code the default. This contract demonstrates how to safely handle fund transfers between a buyer and a seller.

## 🔒 Security Features
- **`@nonreentrant("lock")`:** Utilizes Vyper's built-in reentrancy guard to prevent recursive external calls.
- **Checks-Effects-Interactions (CEI):** The state is updated (`balances` zeroed out and `is_completed` set to True) *before* the external `send()` call is executed.
- **No Infinite Loops:** Vyper enforces strict bounds on loops, preventing gas-griefing Denial of Service (DoS) attacks.

## 🚀 Usage
Compile and test using the Vyper compiler:
```bash
vyper SecureEscrow.vy
