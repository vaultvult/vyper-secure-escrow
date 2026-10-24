# @version ^0.3.7

event Deposit:
    sender: indexed(address)
    amount: uint256

event Withdrawal:
    receiver: indexed(address)
    amount: uint256

buyer: public(address)
seller: public(address)
is_completed: public(bool)
balances: public(HashMap[address, uint256])

@external
def __init__(_seller: address):
    self.buyer = msg.sender
    self.seller = _seller
    self.is_completed = False

@external
@payable
def deposit():
    assert msg.sender == self.buyer, "Only buyer can deposit"
    assert not self.is_completed, "Escrow already completed"
    
    self.balances[msg.sender] += msg.value
    log Deposit(msg.sender, msg.value)

@external
@nonreentrant("lock") # Vyper has built-in reentrancy guards
def release_funds():
    assert msg.sender == self.buyer, "Only buyer can release funds"
    assert not self.is_completed, "Escrow already completed"
    
    amount: uint256 = self.balances[self.buyer]
    assert amount > 0, "No funds to release"
    
    # State change before external call (Checks-Effects-Interactions pattern)
    self.balances[self.buyer] = 0
    self.is_completed = True
    
    send(self.seller, amount)
    log Withdrawal(self.seller, amount)
