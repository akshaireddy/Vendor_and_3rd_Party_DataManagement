import { ethers } from "hardhat";
// const { ethers } = require("hardhat");
require("dotenv").config();

async function main() {
  const [deployer] = await ethers.getSigners();

  // Replace with the actual contract address
  const contractAddress = process.env.CONTRACT_ADDRESS;

  const DataManagementContract = await ethers.getContractFactory("DataManagementContract");
  const dataManagement = await upgrades.upgradeProxy(contractAddress, DataManagementContract);

  console.log("DataManagementContract upgraded at:", dataManagement.address);

  // Interact with the contract functions here
  console.log("Owner:", await dataManagement.owner());

  // Call other functions as needed
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
