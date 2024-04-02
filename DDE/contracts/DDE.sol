pragma solidity ^0.8.20; //SPDX-License-Inde


import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol"; //prova, voglio vedere quanto costa

contract DDE{
string public name = "Digital deflationary Euro";
string public symbol = "DDE";
uint256 public totalSupply = 1000 * 5; // mille token con 5 decimali
address public owner = 0x0d9E9930Df25C3Efe1042528F658d2C74856AeE8;

mapping(address => uint256) public balanceOf;
mapping(address => uint256) public balances;
mapping(address => mapping(address => uint256)) public allowance;

event Transfer(address indexed from, address indexed to, uint256 value);
event Approval(address indexed owner, address indexed spender, uint256 value);
event Mint(address indexed to, uint256 value);
event Burn(address indexed from, uint256 value);
event updateReferencePrice(uint256 referencePrice,uint inflation, uint256 month);
event updateInflation(uint256); 
event stabilityFee(uint256 referencePrice, uint256 fee, uint256 acquisto);

constructor() { //ok
	balanceOf[msg.sender] = totalSupply;
	owner = msg.sender;
	uint256 time = block.timestamp;
	uint160 year = 365.24 days;
	uint256 month = 30 days; 
	uint256 yearsOld = time - 1;
	uint256 reserve = AggregatorV3Interface(0x0d9E9930Df25C3Efe1042528F658d2C74856AeE8);
	uint256 referencePrice;
	uint256 referencePriceOld;
	uint256 data;

}

function mint(address to, uint256 value) public { //only owner ok
	require(msg.sender == owner);
	balances[to] += value;
	totalSupply += value;
	emit Mint(to, value);
}

function burn(address from, uint256 value) public { //only owner ok
	require(msg.sender == owner);
	require(balances[from] >= value, "Saldo insufficiente");
	balances[from] -= value;
	totalSupply -= value;
	emit Burn(from, value);
}

function annualPrice(uint256 referencePrice, uint256 time, uint256 data, uint256 dataOld)public {
	dataOld = time - 1 years;
	data = time;
	//require(data == dataOld + year);

}

function InsertInflation(address to, uint256 value, uint _inputInflation, uint256 inflationOwner)public { 
	require(msg.sender=owner);
	//require 4 week
	address = owner;
	inflationOwner = _inputInflation;
	//introdurre votazione democratica con l'approvazione dell'owner
	referencePrice = referencePrice + inflationOwner;
}

// Funzione per calcolare il nuovo prezzo di riferimento con l'inflazione mensile divisa in secondi per mese

function updateReferencePrice(uint256 referencePrice,uint inflation, uint256 month) public {
	// require la data precedente e controllare che sia giusta ovvero un mese
	referencePriceOld = refencePrice;
	referencePrice = annualPrice + inflation;
	if (refencePriceOld <= referencePrice){ 
	referencePrice = annualPrice + inflation / ( month * 86.400); //aumenta il prezzo
	}else{ 
	referencePrice = annualPrice - inflation /  ( month * 86.400); // riduce il prezzo
	}
}

function stabilityFee(uint256 referencePrice, uint256 fee, uint256 acquisto)public {
	if (referencePrice < acquisto){
		fee = referencePrice - acquisto ;
		payable(owner).transfer(fee);
	}else{
		//avverto l'utente della transazione che più alta del 1% altrimenti fee
		fee = refencePrice - acquisto;
		payable(owner).transfer(fee);
	}
}
/*
function Reserve(){
	//proof of reserve

}
*/
function transfer(address to, uint256 value) external returns (bool) {  //ok
	require(balanceOf[msg.sender] >= value, "Insufficient balance");
	balanceOf[msg.sender] -= value;
	balanceOf[to] += value;
	emit Transfer(msg.sender, to, value);
	return true;
}

function approve(address spender, uint256 value) external returns (bool) { //ok
	allowance[msg.sender][spender] = value;
	emit Approval(msg.sender, spender, value);
	return true;
}

function transferFrom(address from, address to, uint256 value) external returns (bool) { //ok
	require(balanceOf[from] >= value, "Insufficient balance");
	require(allowance[from][msg.sender] >= value, "Insufficient allowance");
	balanceOf[from] -= value;
	balanceOf[to] += value;
	allowance[from][msg.sender] -= value;
	emit Transfer(from, to, value);
	return true;
}
}




