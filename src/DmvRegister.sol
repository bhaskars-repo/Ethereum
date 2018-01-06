pragma solidity ^0.4.15;

import "./IDmvRegister.sol";
import "./AmountOwed2.sol";

/*
 * A DmvRegister contract is first created in the Ethereum  blockchain by the dmv. Once deployed
 * the contract address is used by the dealer in the creation of the Vehicle3 contract. When the
 * dealer receives  the  payment for the  vehicle from  the  buyer, the  vehicle registration is
 * triggered from the buyVehicle function in the Vehicle3 contract.
 */

contract DmvRegister is IDmvRegister, AmountOwed2 {
    struct OwnerLicense {
        bool registered;
        uint license;
        address owner;
    }

    uint _counter;
    uint _fees;
    address _dmv;
    mapping (uint => OwnerLicense) _licenseTbl;

    event RegisteredEvt(uint flag, uint vin, uint license, uint fees, address buyer);
    
    function getFees() public view returns (uint) {
        return _fees;
    }
    
    function getLicense(uint vin) public view returns (uint) {
        return _licenseTbl[vin].license;
    }
    
    // The keyword 'payable' is important for accepting ethers from the sender
    function registerVehicle(uint vin, address buyer) public payable validateAmount(_fees, _dmv) {
        var lic = _licenseTbl[vin];
        if (!lic.registered) {
            RegisteredEvt(1, vin, lic.license, msg.value, buyer);
            lic.owner = buyer;
            lic.license = _counter;
            lic.registered = true;
            _counter++;
            _dmv.transfer(_fees);
            RegisteredEvt(2, vin, lic.license, msg.value-_fees, buyer);
        } else {
            RegisteredEvt(3, vin, lic.license, msg.value, buyer);
        }
    }
    
    function DmvRegister(uint fees) public {
        _counter = 101;
        _fees = fees;
        _dmv = msg.sender;
        RegisteredEvt(0, 0, 0, fees, address(0));
    }
}
