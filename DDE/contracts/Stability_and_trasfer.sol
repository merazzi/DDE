// optimation fee
import "./DDE.sol";


contract stability_and_transfer{
DDE.sol public price;
// devo mettere apposto l'importazione della variabile price
constructor(address _indirizzoAltroContratto) {
	price = DDE.sol(_price);
	uint256 priceExchange = AggregatorV3Interface(0x0d9E9930Df25C3Efe1042528F658d2C74856AeE8);
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
function priceExchange(uint256){

}

function stabilityFee(uint256 price, uint256 fee){ //da mettere nelle funzioni di trasferimento
	if (price < priceExchange){
		fee = price - priceExchange;
		payable(owner).transfer(fee);
	}else{
		//avverto l'utente della transazione che più alta del 1% altrimenti fee
		fee = price - priceExchange;
		payable(owner).transfer(fee);
	}
	}
/*

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
