// SPDX-License-Identifier: MIT
pragma solidity >= 0.8.2 < 0.9.0;


contract ProductStore {

    struct Product
    {
        string name;
        uint256 price;
    }
    Product[] public products;

    function addProduct (string memory name, uint256 price) public{
        products.push(Product(name,price));
    }
    function buyProduct (uint index) public payable {
        require(index < products.length, "Invalid product index");
        Product memory product = products[index];
        require(msg.value >= product.price, "Not enough ETH sent");
        
        if (msg.value > product.price)
        {
            payable(msg.sender).transfer (msg.value - product.price);
        }
    }
    function getProducts() view public returns(Product[] memory){
        return products;
    }
}