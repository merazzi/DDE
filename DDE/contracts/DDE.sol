pragma solidity ^0.8.20; //SPDX-License-Inde


import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol"; //prova, voglio vedere quanto costa

contract DigitalDeflationaryEuro{
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
	uint256 yearschain = block.timestamp + 1 year;
	uint32 monthly = block.timestamp + 1 month;
	uint256 reserve = AggregatorV3Interface(_Reserve);
	uint256 basePrice;
	uint256 referencePrice;
	uint256 priceExchange = AggregatorV3Interface(_PriceTracker);
	uint256 data;

}
/*
contract TokenPriceKeeper {
    AggregatorV3Interface internal priceFeed; // L'interfaccia dell'oracolo Chainlink

    constructor(address _priceFeedAddress) {
        priceFeed = AggregatorV3Interface(_priceFeedAddress);
    }

    // Funzione per ottenere il prezzo attuale del token
    function getTokenPrice() external view returns (int256) {
        (, int256 price, , , ) = priceFeed.latestRoundData();
        return price;
    }
}
*/


function basePrice(uint256 referencePrice, uint256 time, uint256 data, uint256 dataOld)public {
	require(time == yearschain, "update refencePrice");
	basePrice = refencePrice;
	refencePrice = 0;
	yearschain = block.timestamp + 1 year;
}

function InsertInflation(address to, uint _inputInflation, uint256 inflationOwner)public { 
	require(msg.sender=owner,"Only owner can use this function but work for create voter system");
	require(time == monthly,"ok");
	inflationOwner = _inputInflation;
}

// Funzione per calcolare il nuovo prezzo di riferimento con l'inflazione mensile divisa in secondi per mese

function updateReferencePrice(uint256 referencePrice,uint256 inflationOwner) public {
	refencePriceOld = refencePrice;
	refencePrice = basePrice + (basePrice/100) * inflationOwner
	if (refencePriceOld <= referencePrice){ 
	price = refencePrice / (1 month * 86.400); //aumenta il prezzo
	}else{ 
	price = refencePrice / (1 month * 86.400); // riduce il prezzo
	}
}

function price(){
require(time == lastUpdate + 1 day,"update giornaliero")
price += price;
lastUpdate = block.timestamp + 1 day;
}

function priceExchange(uint256){




}

function stabilityFee(uint256 referencePrice, uint256 fee, uint256 acquisto)public {
	if (referencePrice < priceExchange){
		fee = referencePrice - priceExchange;
		payable(owner).transfer(fee);
	}else{
		//avverto l'utente della transazione che più alta del 1% altrimenti fee
		fee = refencePrice - priceExchange;
		payable(owner).transfer(fee);
	}
}

function Reserve(){
	emit //scrivo all'utente la funzione
	return reserve
}


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

}




