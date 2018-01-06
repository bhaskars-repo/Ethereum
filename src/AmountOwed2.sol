pragma solidity ^0.4.15;

/*
 * This AmountOwed contract implements a common function modifier to check the value of tranfer
 * satisfies the amount owed to the service provider (dealer or dmv)
 */

contract AmountOwed2 {
    event AmountEvt(uint flag, uint value, uint amount, address context);

    // Modifiers can be used to change the behaviour of any function in a contract, such as checking
    // a condition prior to executing the function. Modifiers are inheritable properties of contracts
    // and may be overridden by derived contracts
    modifier validateAmount(uint amt, address context) {
        AmountEvt(1, msg.value, amt, context);
        require(msg.value >= amt);
        AmountEvt(2, msg.value, amt, context);
        _; // Function body
        AmountEvt(3, msg.value, amt, context);
    }
}
