const ConstantsManager = artifacts.require("ConstantsManager");
const UpdaterConsts = artifacts.require("UpdaterConsts");
const SFCI = artifacts.require("SFCI");

module.exports = async function(deployer, network, accounts) {
  if (network === "test") return;

  console.log("Migration in progress");

  await deployer.deploy(ConstantsManager);
  const consts = await ConstantsManager.deployed();
  console.log("consts", consts.address);

  const deployerAddr = accounts[0];
  await deployer.deploy(UpdaterConsts, consts.address, deployerAddr);
  const upd = await UpdaterConsts.deployed();
  console.log("upd", upd.address);

  const sfc = await SFCI.at("0xFC00FACE00000000000000000000000000000000");

  console.log("Executing update");
  const tx2 = await upd.execute();
  console.log("Executed", tx2);

  console.log("Changing consts contract");
  const tx = await sfc.updateConstsAddress(consts.address);
  console.log("Changed", tx);
};
