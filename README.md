# 🛡️ InsurePay - Decentralized Insurance Payments  

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)  

Automate insurance payments on Ethereum with secure, admin-controlled policies and direct wallet transfers.  

---

## 📝 Overview  
**InsurePay** is a Solidity smart contract that streamlines insurance payments on the blockchain. Designed for transparency and efficiency, it allows:  
- 🏢 Insurance providers to register policies with fixed payment amounts.  
- 👥 Users to make direct, one-click payments to verified insurer wallets.  
- 🔒 Admins to maintain full control over policy management.  

Key guarantees:  
✅ Payments are irreversible and tamper-proof  
✅ Real-time tracking via blockchain events  
✅ Strict admin-only policy configuration  

---

## ✨ Features  

### 🔒 Admin Control  
- Add/update policies with custom wallets, amounts, and types.  
- Remove outdated or inactive policies.  
- Restricted management via `onlyOwner` modifier.  

### 💸 Secure Payments  
- Users pay exact policy amounts (reverts on incorrect ETH).  
- Direct ETH transfers to insurer wallets in one transaction.  
- Automatic validation of policy existence.  

### 📊 Transparency  
- Event logging for all critical actions (`InsuranceAdded`, `PaymentProcessed`).  
- Public view functions to verify policy details.  

### ⚙️ Modular Design  
- Easily extendable for ERC20 payments or policy expiration logic.  

---

## 📖 Contract Summary  

### Core Functions  
| 🔧 Function Name       | 📋 Description                                                                 |
|-----------------------|-------------------------------------------------------------------------------|
| `addInsurance()`      | Admin registers policy (ID, company, wallet, amount, type).                  |
| `removeInsurance()`   | Admin deletes policy by ID.                                                  |
| `payInsurance()`      | User pays policy (exact ETH amount required).                                |

### View Functions  
| 🔍 Function Name       | 📋 Description                                   |
|-----------------------|-------------------------------------------------|
| `insurances()`        | Returns policy details by ID.                   |

---

## ⚙️ Prerequisites  

1. **🛠️ Tools**:  
   - [🖥️ Hardhat](https://hardhat.org/) or [Remix IDE](https://remix.ethereum.org)  
   - [MetaMask](https://metamask.io/) (for live network testing)  

2. **🌐 Environment**:  
   - Solidity Compiler: `^0.8.24`  
   - Test Networks: Sepolia/Goerli (recommended)  



---





