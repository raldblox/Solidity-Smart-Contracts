const main = async () => {
  const namingContractFactory = await hre.ethers.getContractFactory('CSP');
  const namingContract = await namingContractFactory.deploy();
  await namingContract.deployed();
  console.log("Contract deployed to:", namingContract.address);

  let txn = await namingContract.mintBlox(); await txn.wait();
  await txn.wait();
  console.log("Done.");

  const balance = await hre.ethers.provider.getBalance(namingContract.address);
  console.log("Contract balance:", hre.ethers.utils.formatEther(balance));
}

const runMain = async () => {
  try {
    await main();
    process.exit(0);
  } catch (error) {
    console.log(error);
    process.exit(1);
  }
};

runMain();