// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";

contract DDE{
string public name = "Digital Deflazionitic Euro";
string public symbol = "DDE";
uint256 public totalSupply = 1000 * 10**5; // mille token con 5 decimali
address public owner = 0x0d9E9930Df25C3Efe1042528F658d2C74856AeE8

mapping(address => uint256) public balanceOf;
mapping(address => uint256) public balances;
mapping(address => mapping(address => uint256)) public allowance;

event Transfer(address indexed from, address indexed to, uint256 value);
event Approval(address indexed owner, address indexed spender, uint256 value);
event Mint(address indexed to, uint256 value);
event Burn(address indexed from, uint256 value);
event updateReferencePrice(uint256 referencePrice);
event updateInflation(uint256); 
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
function annualPrice(){
	if (monthy="december" && day=31){
		annualPrice = refencePrice
	}
}

function InsertInflation(address to, uint256 value, uint _inputInflation) public{
        //owner and voter set inflation european 
	address = owner
	voter = voter address con un amount di 1000 DDE
	inflationVote = _inputInflation
	if (inflationOwner == inflationUser){ //votazione deve essere uguale
		inflation = inflationVote	
	}else{
		msg.errore //errore
	}
}

// Funzione per calcolare il nuovo prezzo di riferimento con l'inflazione mensile divisa in secondi per mese

function updateReferencePrice() public {
	referencePriceOld = refencePrice 
	referencePrice = annualPrice + inflation 
	if (refencePriceOld =< referencePrice){ 
	referencePrice = annualPrice + inflation / (giorni * 86.400) //aumenta il prezzo
	}else{ 
	referencePrice = annualPrice - inflation /  (giorni * 86.400) // riduce il prezzo
	}
}

function stabilityFee(){
	if (referencePrice < //acquisto){
		fee = 0.002*(referencePrice* /* acquisto   */ - 1) // deve esserci l'uno percento di tolleranza
	}else{
		fee = 0.002*(/* acquisto   */  *referencePrice - 1) // deve esserci l'uno percento di tolleranza
	}
	
}

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


