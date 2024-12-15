# pragma version 0.4.0

from ethereum.ercs import IERC20
from snekmate.auth import ownable

initializes: ownable

event OwnerIsUpdated: newOwner: address
event SaleStartTimestampIsUpdated: newSaleStartTimestamp: uint256
event SaleEndTimestampIsUpdated: newSaleEndTimestamp: uint256

token: public(IERC20)
saleStartTimestamp: public(uint256)
saleEndTimestamp: public(uint256)

@deploy
def __init__(_owner: address, _token: IERC20, _saleStartTimestamp: uint256, _saleEndTimestamp: uint256):
    assert _saleStartTimestamp < _saleEndTimestamp, "Invalid sale timestamps"
    assert _owner != empty(address), "Invalid owner address"
    assert _token != empty(IERC20), "Invalid token address"

    ownable.__init__()
    
    self.saleStartTimestamp = _saleStartTimestamp
    self.saleEndTimestamp = _saleEndTimestamp
    self.token = _token

    log OwnerIsUpdated(_owner)
    log SaleStartTimestampIsUpdated(_saleStartTimestamp)
    log SaleEndTimestampIsUpdated(_saleEndTimestamp)
    
@external
def update_sale_start_timestamp(newSaleStartTimestamp: uint256):
    ownable._check_owner()
    assert newSaleStartTimestamp < self.saleEndTimestamp, "New start timestamp is higher than end timestamp"
    
    self.saleStartTimestamp = newSaleStartTimestamp
    log SaleStartTimestampIsUpdated(newSaleStartTimestamp)    