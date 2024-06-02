pragma solidity 0.8.20; //SPDX-License-Identifier: UNLICENSED
import "./DDE.sol"; 

contract stability_and_transfer{
DigitalDeflationaryEuro public price;
DigitalDeflationaryEuro public totalSupply;
DigitalDeflationaryEuro public owner;
AggregatorV3Interface internal priceFeed; // L'interfaccia dell'oracolo Chainlink

mapping(address => uint256) public balanceOf;
mapping(address => uint256) public balances;
mapping(address => mapping(address => uint256)) public allowance;

event Transfer(address indexed from, address indexed to, uint256 value);
event Approval(address indexed owner, address indexed spender, uint256 value);
event stabilityFee(uint256 referencePrice, uint256 fee, uint256 acquisto);

constructor(address _price, address _totalSupply) {
	price = DigitalDeflationaryEuro(_price);
	totalSupply = DigitalDeflationaryEuro(_totalSupply);
	uint256 fee;
	balanceOf[msg.sender] = totalSupply;
	//uint256 priceExchange AggregatorV3Interface(0x0d9E9930Df25C3Efe1042528F658d2C74856AeE8);
	//priceFeed = AggregatorV3Interface(_priceFeedAddress); da mettere sopra
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
/*
function priceExchange(uint256){ //prezzo medio

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
	if (price < priceExchange){
		fee = price - priceExchange;
		payable(owner).transfer(fee);
	}else{
		//avverto l'utente della transazione che più alta del 1% altrimenti fee
		fee = price - priceExchange;
		payable(owner).transfer(fee);
	}
	emit Transfer(from, to, value);
	return true;
}
}
