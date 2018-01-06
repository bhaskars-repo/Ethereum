pragma solidity ^0.4.15;

import "./IDmvRegister.sol";
import "./AmountOwed2.sol";

/*
 * A Vehicle instance is first created in the Ethereum blockchain by the dealer.
 * Once the payment is received, the dealer transfers ownership to the buyer.
 */

contract Vehicle3 is AmountOwed2 {
    enum DealStatus { Open, Closed }
    
    uint _vin;
    uint _cost;
    uint _fees;
    address _buyer;
    address _dealer;
    DealStatus _status;
    IDmvRegister _dmvif;
    
    event BoughtEvt(uint flag, uint vin, uint value, address buyer);
    
    function getVin() public view returns (uint) {
        return _vin;
    }
    
    function getCost() public view returns (uint) {
        return _cost;
    }
    
    function getOwner() public view returns (address) {
        return _buyer;
    }
    
    function getDealer() public view returns (address) {
        return _dealer;
    }
    
    function getStatus() public view returns (DealStatus) {
        return _status;
    }
    
    // The keyword 'payable' is important for accepting ethers from the buyer
    function buyVehicle() public payable validateAmount(_cost+_fees, _dealer) {
        uint _gas = 1000000;
        uint _amt = msg.value;
        // Only the assigned owner can close the deal
        if (msg.sender == _buyer) {
            BoughtEvt(1, _vin, _amt, _buyer);
            _status = DealStatus.Closed;
            _dealer.transfer(_cost);
            _amt = _amt - _cost;
            BoughtEvt(2, _vin, _amt, _buyer);
            _dmvif.registerVehicle.value(_amt).gas(_gas)(_vin, _buyer);
            _amt = _amt - _fees;
            BoughtEvt(3, _vin, _amt, _buyer);
            // selfDestruct(_dealer);
        } else {
            BoughtEvt(4, _vin, msg.value, _buyer);
        }
    }
    
    // fees will include the gas price
    function Vehicle3(uint vin, uint cost, uint fees, address buyer, address dmvcon) public {
        _vin = vin;
        _cost = cost;
        _fees = fees;
        _buyer = buyer;
        _dealer = msg.sender;
        _status = DealStatus.Open;
        _dmvif = IDmvRegister(dmvcon);
        BoughtEvt(0, _vin, 0, _buyer);
    }
}
