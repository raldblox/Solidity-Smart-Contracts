const main = async () => {
  const [owner, randomPerson] = await hre.ethers.getSigners();
  const namingContractFactory = await hre.ethers.getContractFactory('Web3User');
  const namingContract = await namingContractFactory.deploy();
  await namingContract.deployed();
  console.log("Contract deployed to:", namingContract.address);
  console.log("Contract deployed by:", owner.address);
  const txn = await namingContract.registerName("raldblox");
  await txn.wait();

  const namingOwner = await namingContract.getNameId("raldblox");
  console.log("Owner of username:", namingOwner);
};

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