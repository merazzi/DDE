pragma solidity 0.8.20; //SPDX-License-Identifier: UNLICENSED

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract DigitalDeflationaryEuro{
string public name = "Digital deflationary Euro";
string public symbol = "DDE";
uint256 public totalSupply = 1000 * 5; // mille token con 5 decimali
address public owner = 0x0d9E9930Df25C3Efe1042528F658d2C74856AeE8;
uint256 public price;
uint256 public annual;
uint256 public monthly;


mapping(address => uint256) public balanceOf;
mapping(address => uint256) public balances;
mapping(address => mapping(address => uint256)) public allowance;

event Transfer(address indexed from, address indexed to, uint256 value);
event Approval(address indexed owner, address indexed spender, uint256 value);
event Mint(address indexed to, uint256 value);
event Burn(address indexed from, uint256 value); 
event stabilityFee(uint256 referencePrice, uint256 fee, uint256 acquisto);

constructor() { //ok
	balanceOf[msg.sender] = totalSupply;
	owner = msg.sender;
	//uint256 reserve = AggregatorV3Interface();
	//uint256 priceExchange = AggregatorV3Interface();
	}

function newBasePrice(uint256 referencePrice, uint256 basePrice)public {
	if(annual != 0){
	require(block.timestamp == annual, "update refencePrice");
	basePrice = referencePrice;
	annual = block.timestamp + 48 weeks;
	}else{
	annual = block.timestamp + 48 weeks;
	}
}

function InsertInflation(uint256 _inputInflation, uint256 inflationOwner)private  { 
	if(monthly != 0){
	require(msg.sender==owner,"Only owner can use this function but work for create voter system");
	require(block.timestamp == monthly,"ok");
	inflationOwner = _inputInflation;
	monthly = block.timestamp + 4 weeks;
	}else{
	monthly = block.timestamp + 4 weeks;
	}
	}

// Funzione per calcolare il nuovo prezzo di riferimento con l'inflazione mensile fatta su mese 

function updateReferencePrice(uint256 inflationOwner, uint256 referencePriceOld, uint256 referencePrice, uint256 basePrice) public{
	referencePriceOld = referencePrice;
	referencePrice = basePrice + (basePrice/100) * inflationOwner;
	if (referencePrice >= referencePriceOld){ 
	price = referencePrice;
	}else{ 
	price = referencePriceOld;
	}
}
}
