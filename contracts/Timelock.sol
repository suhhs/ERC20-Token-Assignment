pragma solidity ^0.8.0;

import "../node_modules/@openzeppelin/contracts/token/ERC20/IERC20.sol";
//https://trufflesuite.com/docs/truffle/getting-started/interacting-with-your-contracts.html

//duration of lock
//release time
//owner address
//There were multiple examples and studies where the release time was manual, however its better to be automatic
//for proof-of-work and proof-of-trust
contract Timelock {
    uint public constant duration = 1 minutes;
    uint public immutable _releaseTime;
    address payable public immutable owner;


//constructor for pass variable in migration
//if address != owner address then it will fail 
    constructor(address payable _owner) {
        _releaseTime = block.timestamp + duration;
        owner = _owner;
    }

// deposit function to place amount into address
    function deposit(address _token, uint amount) external {
        IERC20(_token).transferFrom(msg.sender, address(this), amount);
    }
    receive() external payable {}

//withdraw function that takes amount from specific address
//if deployed with address that is not owner, then it will fail
//second requirement is that the timestamp has to be 1 minute after blocks timestamp of being deployed.
//I understood it slightly for security to use address(0) because its very unlikely to have private key of said variable
//On success it would go to else and withdraw
    function withdraw(address token_, uint amount) external {
        require(msg.sender == owner, 'only owner can req withdrawal');
        require(block.timestamp >= _releaseTime, 'too early to withdraw');
        if(token_ == address(0)) {
            owner.transfer(amount);
        } else {
            IERC20(token_).transfer(owner, amount);
        }
    }
}