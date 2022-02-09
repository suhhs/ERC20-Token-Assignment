const SimpleToken = artifacts.require('AssignmentToken');
const Timelock = artifacts.require('TimeLock');

module.exports = async function (deployer) {
  await deployer.deploy(SimpleToken, 'Suhhs Token', 'TKN');
  await deployer.deploy(Timelock, '0x38E808522f2d9C46CA09d5Cf7440D266AE109A6a');
};