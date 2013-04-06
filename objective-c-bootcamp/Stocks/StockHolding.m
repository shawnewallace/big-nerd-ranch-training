//
//  StockHolding.m
//  Stocks
//
//  Created by Shawn Ellis Wallace on 4/6/13.
//  Copyright (c) 2013 Shawn Ellis Wallace. All rights reserved.
//

#import "StockHolding.h"

@implementation StockHolding

@synthesize purchaseSharePrice, currentSharePrice, numberOfShares;

- (float)costInDollars
{
    return [self purchaseSharePrice] * [self numberOfShares];
}

- (float)valueInDollars
{
    return [self currentSharePrice] * [self numberOfShares];
}

@end
