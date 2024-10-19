// Script to deploy the contract

async function main() {
    const [deployer] = await ethers.getSigners();
    console.log("Deploying contracts with the account:", deployer.address);
  
    const SlippageBot = await ethers.getContractFactory("SlippageBot");
    const bot = await SlippageBot.deploy();
  
    console.log("Contract deployed to:", bot.address);
}
  
main()
.then(() => process.exit(0))
.catch((error) => {
    console.error(error);
    process.exit(1);
});