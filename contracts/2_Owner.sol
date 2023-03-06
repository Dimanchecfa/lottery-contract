// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "hardhat/console.sol";

/**
 * @title Owner
 * @dev Set & change owner
 */
contract Wallet {
    struct Account {
        string name;
        uint solde;
    }
    address[] private  peopleAdress;

    mapping(address => Account) public accounts;

    receive() external payable {
        accounts[msg.sender].solde += msg.value;
    }

    function withdrawMoney(address payable _to , uint _amount) external {
        require(_amount <= accounts[msg.sender].solde, "Solde insuffisant");
        accounts[msg.sender].solde -= _amount;
        _to.transfer(_amount);
    }

    function getBalance() external view returns(uint) {
        return accounts[msg.sender].solde;
    }

    function createAccount(string memory _name) external {
        Account memory new_account = Account(_name , 0);
        accounts[msg.sender] = new_account;
        peopleAdress.push(msg.sender);
    }

    function getAllAccounts() external view returns(Account[] memory){
        Account[] memory allAccount = new Account[](peopleAdress.length);
        for(uint i = 0; i < peopleAdress.length ; i++)
        {
            address addr = peopleAdress[i];
            allAccount[i] = accounts[addr];
        }
        return allAccount;
    }


}  