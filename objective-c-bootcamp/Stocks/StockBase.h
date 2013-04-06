//
//  StockHolding.h
//  Stocks
//
//  Created by Shawn Ellis Wallace on 4/6/13.
//  Copyright (c) 2013 Shawn Ellis Wallace. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StockBase : NSObject

@property float purchaseSharePrice;
@property float currentSharePrice;
@property int numberOfShares;

- (float)costInDollars;
- (float)valueInDollars;

- (NSString *)description;

@end
