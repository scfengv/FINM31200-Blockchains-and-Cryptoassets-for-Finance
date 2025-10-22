# SimpleStorage Smart Contract - Foundry/Forge

A simple smart contract example built with Foundry/Forge that demonstrates basic storage operations.

## Prerequisites

Install Foundry:
```bash
curl -L https://foundry.paradigm.xyz | bash
foundryup
```

## Project Setup

1. Initialize Foundry in your project (if not already done):
```bash
forge init --no-commit
```

2. Install dependencies (if any):
```bash
forge install
```

## Building

Compile the contracts:
```bash
forge build
```

## Testing

Run all tests:
```bash
forge test
```

Run tests with verbosity (shows logs):
```bash
forge test -vvv
```

Run specific test:
```bash
forge test --match-test testStore
```

Run tests with gas reporting:
```bash
forge test --gas-report
```

Run tests with coverage:
```bash
forge coverage
```

## Local Deployment

### 1. Start Local Anvil Node
```bash
anvil
```

This will start a local Ethereum node at `http://127.0.0.1:8545` with 10 test accounts.

### 2. Deploy Contract Locally
In a new terminal:
```bash
forge script scripts/DeploySimpleStorage.s.sol:DeploySimpleStorage --rpc-url http://127.0.0.1:8545 --broadcast --private-key <PRIVATE_KEY_FROM_ANVIL>
```

Example with Anvil's first default private key:
```bash
forge script scripts/DeploySimpleStorage.s.sol:DeploySimpleStorage --rpc-url http://127.0.0.1:8545 --broadcast --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
```

## Interacting with Deployed Contract

### Using Cast (Foundry's CLI tool)

Get the deployed contract address from the deployment output, then:

```bash
# Store a number
cast send <CONTRACT_ADDRESS> "store(uint256)" 42 --rpc-url http://127.0.0.1:8545 --private-key <PRIVATE_KEY>

# Retrieve the stored number
cast call <CONTRACT_ADDRESS> "retrieve()" --rpc-url http://127.0.0.1:8545

# Add a person
cast send <CONTRACT_ADDRESS> "addPerson(string,uint256)" "Alice" 7 --rpc-url http://127.0.0.1:8545 --private-key <PRIVATE_KEY>

# Get person count
cast call <CONTRACT_ADDRESS> "getPeopleCount()" --rpc-url http://127.0.0.1:8545
```

## Contract Features

- **store(uint256)**: Store a favorite number
- **retrieve()**: Retrieve the stored favorite number
- **addPerson(string, uint256)**: Add a person with their favorite number
- **getPerson(uint256)**: Get person details by index
- **getPeopleCount()**: Get total number of people stored
- **nameToFavoriteNumber(string)**: Mapping to look up favorite numbers by name

## Project Structure

```
contracts/
  └── SimpleStorage.sol       # Main contract
scripts/
  └── DeploySimpleStorage.s.sol  # Deployment script
tests/
  └── SimpleStorage.t.sol     # Unit tests
```

## Additional Commands

Format code:
```bash
forge fmt
```

Check for security issues with Slither:
```bash
slither contracts/SimpleStorage.sol
```

Generate documentation:
```bash
forge doc
```

## Network Configuration

Edit `foundry.toml` to configure different networks:

```toml
[profile.default]
src = 'contracts'
out = 'out'
libs = ['lib']

[rpc_endpoints]
mainnet = "${MAINNET_RPC_URL}"
sepolia = "${SEPOLIA_RPC_URL}"
```

## Environment Variables

Create a `.env` file for sensitive data:
```
PRIVATE_KEY=your_private_key_here
SEPOLIA_RPC_URL=your_rpc_url_here
ETHERSCAN_API_KEY=your_api_key_here
```

Load environment variables:
```bash
source .env
```