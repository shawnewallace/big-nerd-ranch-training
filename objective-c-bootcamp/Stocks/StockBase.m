//
//  StockHolding.m
//  Stocks
//
//  Created by Shawn Ellis Wallace on 4/6/13.
//  Copyright (c) 2013 Shawn Ellis Wallace. All rights reserved.
//

#import "StockBase.h"

@implementation StockBase

@synthesize purchaseSharePrice, currentSharePrice, numberOfShares;

- (float)costInDollars
{
    return [self purchaseSharePrice] * [self numberOfShares];
}

- (float)valueInDollars
{
    return [self currentSharePrice] * [self numberOfShares];
}

- (NSString *)description {
    return [NSString stringWithFormat: @"\n\tPurchase Price: %f\n\tCurrent Price: %f\n\tNumShares: %d\n\tCost: %f\n\tValue: %f",
            [self purchaseSharePrice],
            [self currentSharePrice],
            [self numberOfShares],
            [self costInDollars],
            [self valueInDollars]];
}

@end
