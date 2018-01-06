pragma solidity ^0.4.15;

/*
 * A Vehicle instance is first created in the Ethereum blockchain by the dealer.
 * Once the payment is received, the dealer transfers ownership to the buyer.
 */

contract Vehicle {
    uint vin_no;
    address owner;
    
    function getVinNo() public view returns (uint) {
        return vin_no;
    }
    
    function getOwner() public view returns (address) {
        return owner;
    }
    
    function soldTo(address buyer) public {
        // Only the current owner can transfer ownership
        if (msg.sender == owner) {
            owner = buyer;
        }
    }
    
    function Vehicle(uint vin, address dealer) public {
        vin_no = vin;
        owner = dealer;
    }
}
