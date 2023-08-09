const { ethers, upgrades } = require("hardhat");
require("dotenv").config();

async function main() {
  const [deployer] = await ethers.getSigners();

  console.log("Deploying contracts with the account:", deployer.address);

  const DataManagementContract = await ethers.getContractFactory("DataManagementContract");
  const dataManagement = await upgrades.deployProxy(DataManagementContract);

  await dataManagement.deployed();

  console.log("DataManagementContract deployed to:", dataManagement.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
