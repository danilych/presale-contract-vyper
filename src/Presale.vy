# pragma version 0.4.0

from ethereum.ercs import IERC20
from snekmate.auth import ownable
from interfaces import IPresale

initializes: ownable

exports: (
    ownable.owner,
    ownable.transfer_ownership,
    ownable.renounce_ownership,
)

# @notice Token which is used for presale.
token: public(IERC20)

# @notice Liquidity of tokens in the contract.
liquidity: public(uint256)

# @notice Sale start timestamp.
saleStartTimestamp: public(uint256)

# @notice Sale end timestamp.
saleEndTimestamp: public(uint256)

# @param _token Token which is used for presale.
# @param _saleStartTimestamp Sale start timestamp.
# @param _saleEndTimestamp Sale end timestamp.
@deploy
def __init__(_token: IERC20, _saleStartTimestamp: uint256, _saleEndTimestamp: uint256):
    assert _saleStartTimestamp < _saleEndTimestamp, "Invalid sale timestamps"
    assert _saleStartTimestamp >= block.timestamp, "Invalid start timestamp"
    assert _token != empty(IERC20), "Invalid token address"

    ownable.__init__()
    
    self.saleStartTimestamp = _saleStartTimestamp
    self.saleEndTimestamp = _saleEndTimestamp
    self.token = _token

    log IPresale.SaleStartTimestampIsUpdated(_saleStartTimestamp)
    log IPresale.SaleEndTimestampIsUpdated(_saleEndTimestamp)
    log IPresale.TokenIsUpdated(_token)
    
# @notice Updates sale start timestamp.
# @dev Can be used only by owner.
# @param newSaleStartTimestamp New sale start timestamp.
@external
def update_sale_start_timestamp(newSaleStartTimestamp: uint256):
    ownable._check_owner()
    assert newSaleStartTimestamp < self.saleEndTimestamp, "New start timestamp is higher than end timestamp"
    
    self.saleStartTimestamp = newSaleStartTimestamp
    log IPresale.SaleStartTimestampIsUpdated(newSaleStartTimestamp)

# @notice Deposits tokens for presale and increase liquidity in the contract.
# @dev Can be used only by owner.
# @param amount Amount of tokens to deposit.
@external
def deposit_tokens(amount: uint256):
    ownable._check_owner()
    assert block.timestamp <= self.saleStartTimestamp, "Sale is already started"
    assert amount > 0, "Amount must be greater than 0"
    
    assert extcall self.token.transferFrom(msg.sender, self, amount), "Token transfer failed"

    self.liquidity += amount
    
    log IPresale.TokensDeposited(msg.sender, amount)