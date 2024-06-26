contract management{

address public owner = 0x0d9E9930Df25C3Efe1042528F658d2C74856AeE8;

event Mint(address indexed to, uint256 value);
event Burn(address indexed from, uint256 value); 

function mint(address to, uint256 value) public { 
	require(msg.sender == owner);
	balances[to] += value;
	totalSupply += value;
	emit Mint(to, value);
}

function burn(address from, uint256 value) public {
	require(msg.sender == owner);
	require(balances[from] >= value, "Saldo insufficiente");
	balances[from] -= value;
	totalSupply -= value;
	emit Burn(from, value);
}
}
