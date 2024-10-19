
## Uniswap Trading Bot

A Solidity-based bot designed for automated token swaps and liquidity management on Uniswap V2. This bot interacts with Ethereum networks and can be deployed on testnets (like Ropsten) or mainnet.

### Project Structure

```plaintext
uniswap-bot/
├── contracts/         # Contains the Solidity contract
├── scripts/           # Deployment and interaction scripts
├── .env               # Environment variables (API keys, private key)
├── hardhat.config.js  # Hardhat configuration for Solidity and networks
└── README.md          # Project documentation and setup instructions
```

### Contract logit

- **Owner and OnlyOwner**: Only the contract owner can execute critical functions such as swaps and adding liquidity.
- **Uniswap V2 Router and Factory**: Utilizes the `UniswapV2Router02` contract to perform swaps and add liquidity. The `UniswapV2Factory` helps retrieve token pairs.
- **Key Functions**:
  - **swapTokens**: Swaps tokens using the Uniswap router.
  - **addLiquidity**: Adds liquidity to a Uniswap pool.
  - **withdrawETH** and **withdrawTokens**: Allow the owner to withdraw ETH or tokens from the contract.
  - **getPair**: Returns the contract for the token pair on Uniswap (if it exists).

### Setup

Install dependencies and set up environment variables

```bash
npm install
```

IN .env

```plaintext 
INFURA_API_KEY=your_key
PRIVATE_KEY=your_key
```

Compile the Solidity smart contract using Hardhat 

```bash
npx hardhat compile
```

To deploy the contract to Ropsten (or any network), run

```bash
npx hardhat run scripts/deploy.js --network ropsten
```

Once deployed, note the contract address from the output.


Use the provided interact.js script to interact with the deployed contract (e.g., swap tokens). You must modify the script with your token addresses and amounts before running it

```bash
npx hardhat run scripts/interact.js --network ropsten
```

