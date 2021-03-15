//How hegic is priced
//amount is number of options

function fees(uint256 period, uint256 amount, uint256 strike) public view returns (uint256 total, uint256 settlementFee, uint256 strikeFee, uint256 periodFee) {
        uint256 currentPrice = uint256(priceProvider.latestAnswer());
        settlementFee = getSettlementFee(amount);
        periodFee = getPeriodFee(amount, period, strike, currentPrice);
        strikeFee = getStrikeFee(amount, strike, currentPrice);
        //A: Total is total price to be paid for the contract
        total = periodFee.add(strikeFee);
    }

function getPeriodFee(uint256 amount, uint256 period, uint256 strike, uint256 currentPrice) internal view returns (uint256 fee) {
    //A: Put
        if (optionType == OptionType.Put)
            return amount
                .mul(sqrt(period))
                .mul(impliedVolRate)
                .mul(strike)
                .div(currentPrice)
                .div(PRICE_DECIMALS);
        else

        //A: Call
            return amount
                .mul(sqrt(period))
                .mul(impliedVolRate)
                .mul(currentPrice)
                .div(strike)
                .div(PRICE_DECIMALS);
    }

function getStrikeFee(uint256 amount, uint256 strike, uint256 currentPrice) internal view returns (uint256 fee) {
        if (strike > currentPrice && optionType == OptionType.Put)
            return strike.sub(currentPrice).mul(amount).div(currentPrice);
        if (strike < currentPrice && optionType == OptionType.Call)
            return currentPrice.sub(strike).mul(amount).div(currentPrice);
        return 0;
    }
