pragma solidity 0.6.8;


/**
     * @dev Calculate price of bToken based on Black-Scholes approximation.
     * Formula: 0.4 * ImplVol * sqrt(timeUntilExpiry) * currentPrice / strike
     */
     

function calcPrice(
        uint256 timeUntilExpiry,
        uint256 strike,
        uint256 currentPrice,
        uint256 volatility
    ) public pure returns (uint256) {
        uint256 intrinsic = 0;
        if (currentPrice > strike) {
            intrinsic = currentPrice.sub(strike).mul(1e18).div(currentPrice);
        }

        uint256 timeValue = Math
            .sqrt(timeUntilExpiry)
            .mul(volatility)
            .mul(currentPrice)
            .div(strike);

        return intrinsic.add(timeValue);
    }
    
reference:
https://github.com/sirenmarkets/core/blob/master/contracts/amm/MinterAmm.sol line 917
