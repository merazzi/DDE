// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";

contract DDE{
string public name = "Digital Deflazionitic Euro";
string public symbol = "DDE";
uint256 public totalSupply = 1000 * 10**5; // mille token con 5 decimali
 address public owner; //cambio con indrizzo wallet ed implementare la funzione

mapping(address => uint256) public balanceOf;
mapping(address => uint256) public balances;
mapping(address => mapping(address => uint256)) public allowance;
mapping(address => uint256) public loanBalance;
mapping(address => uint256) public collateralBalance;

uint256 public collateralRatio = 1; // Rapporto tra il valore del collaterale e il valore del prestito

event Transfer(address indexed from, address indexed to, uint256 value);
event Approval(address indexed owner, address indexed spender, uint256 value);
event Loan(address indexed borrower, uint256 value, uint256 collateral);
event Repayment(address indexed borrower, uint256 value);
event CollateralAdded(address indexed borrower, uint256 value);
event Mint(address indexed to, uint256 value);
event Burn(address indexed from, uint256 value);
event updateReferencePrice(uint256 referencePrice);
event stabilityFee();

//creation and burn da mettere sotto l’owner
constructor() {
balanceOf[msg.sender] = totalSupply;
owner = msg.sender;
}

function mint(address to, uint256 value) public {
	require(msg.sender == owner);
	balances[to] += value;
	totalSupply += value;
	emit Mint(to, value);
}

// Funzione per eseguire il burning di token esistenti
function burn(address from, uint256 value) public {
	require(msg.sender == owner);
	require(balances[from] >= value, "Saldo insufficiente");
	balances[from] -= value;
	totalSupply -= value;
	emit Burn(from, value);
}

// Funzione per modificare l’inflazione di riferimento

// Funzione per calcolare il nuovo prezzo di riferimento con l'inflazione mensile
/*  function updateReferencePrice() public {
	
}

function InsertInflation(address to, uint256 value) public{
        //owner and 
}

function stabilityFee(){
	

}

  */ 

function transfer(address to, uint256 value) external returns (bool) {
require(balanceOf[msg.sender] >= value, "Insufficient balance");
balanceOf[msg.sender] -= value;
balanceOf[to] += value;
emit Transfer(msg.sender, to, value);
return true;
}

function approve(address spender, uint256 value) external returns (bool) {
allowance[msg.sender][spender] = value;
emit Approval(msg.sender, spender, value);
return true;
}

function transferFrom(address from, address to, uint256 value) external returns (bool) {
require(balanceOf[from] >= value, "Insufficient balance");
require(allowance[from][msg.sender] >= value, "Insufficient allowance");
balanceOf[from] -= value;
balanceOf[to] += value;
allowance[from][msg.sender] -= value;
emit Transfer(from, to, value);
return true;
}

function lend(uint256 value, uint256 collateral) external {
require(balanceOf[msg.sender] >= value, "Insufficient balance");
require(collateral >= value / collateralRatio, "Insufficient collateral");

balanceOf[msg.sender] -= value;
loanBalance[msg.sender] += value;
collateralBalance[msg.sender] += collateral;
emit Loan(msg.sender, value, collateral);
}

function repayLoan(uint256 value) external {
require(loanBalance[msg.sender] >= value, "Insufficient loan balance");

loanBalance[msg.sender] -= value;
balanceOf[msg.sender] += value;
emit Repayment(msg.sender, value);
}

function addCollateral(uint256 collateral) external {
require(balanceOf[msg.sender] >= collateral, "Insufficient balance for collateral");

balanceOf[msg.sender] -= collateral;
collateralBalance[msg.sender] += collateral;

emit CollateralAdded(msg.sender, collateral);
}
}

