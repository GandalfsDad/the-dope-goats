
const ethers = require("ethers");

const main = async () => {
    //Get the contract and deploy it
    const nftContractFactory = await hre.ethers.getContractFactory('DopeGoats');
    const nftContract = await nftContractFactory.deploy();
    await nftContract.deployed();
    console.log("Contract deployed to:", nftContract.address);
  
    let txn = await nftContract.makeDopeGoat("#44ee33","#ff8866",true,{ value: ethers.utils.parseEther("0.01") });
    await txn.wait()

    txn = await nftContract.makeDopeGoat("#ffffff","#000000",false,{ value: ethers.utils.parseEther("0.01") });
    await txn.wait()
    
    let birth = await nftContract.giveBirth(1,2,false);
    await txn.wait();

    let uri = await nftContract.tokenURI(1);
    console.log(uri);
    
  
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