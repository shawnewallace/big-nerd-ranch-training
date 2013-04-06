//
//  ForeignStockHolding.m
//  Stocks
//
//  Created by Shawn Ellis Wallace on 4/6/13.
//  Copyright (c) 2013 Shawn Ellis Wallace. All rights reserved.
//

#import "ForeignStockHolding.h"

@implementation ForeignStockHolding

@synthesize conversionRate;

- (float)costInDollars
{
    return [super costInDollars] * [self conversionRate];
}

- (float)valueInDollars
{
    return [super valueInDollars] * [self conversionRate];
}

- (NSString *)description {
    return [NSString stringWithFormat: @"\n\tPurchase Price: %f\n\tCurrent Price: %f\n\tNumShares: %d\n\tCost: %f\n\tValue: %f (conversion rate: %f)",
            [self purchaseSharePrice],
            [self currentSharePrice],
            [self numberOfShares],
            [self costInDollars],
            [self valueInDollars],
            [self conversionRate]];
}


@end
