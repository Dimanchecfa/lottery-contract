pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract SLToken is ERC20 {
    address owner;
    address approvedContract;

    constructor() ERC20("Super Lotery Token" , "SLT"){
         owner = msg.sender;
    }

    function setApprovedContract(address _aprovedContract) external onlyOwner {
        approvedContract = _aprovedContract;
    }

    function mint(address _to , uint _numberOfToken) external {
        require(msg.sender == approvedContract, "Not approved");
        _mint(_to, _numberOfToken);
    }

    modifier onlyOwner() {
        require(msg.sender == owner,"Not enough found");
        _;
    }
}