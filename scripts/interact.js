// Script to interact with the contract (swap, add liquidity, etc.) 
async function main() {
    const botAddress = "YOUR_CONTRACT_ADDRESS"; // Replace with deployed contract address
    const bot = await ethers.getContractAt("SlippageBot", botAddress);

    const tokenIn = "TOKEN_IN_ADDRESS";  // Replace with token in address
    const tokenOut = "TOKEN_OUT_ADDRESS"; // Replace with token out address
    const amountIn = ethers.utils.parseUnits("1", 18);  // Set input token amount 

    const tx = await bot.swapTokens(tokenIn, tokenOut, amountIn, 0, Math.floor(Date.now() / 1000) + 60);
    console.log("Transaction hash:", tx.hash);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });