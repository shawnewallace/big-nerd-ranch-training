//
//  main.m
//  Stocks
//
//  Created by Shawn Ellis Wallace on 4/6/13.
//  Copyright (c) 2013 Shawn Ellis Wallace. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StockBase.h"
#import "ForeignStockHolding.h"
#import "Portfolio.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        StockBase *one            = [[StockBase alloc] init];
        StockBase *two            = [[StockBase alloc] init];
        StockBase *three          = [[StockBase alloc] init];
        
        [one setPurchaseSharePrice:2.30];
        [one setNumberOfShares:40];
        [one setCurrentSharePrice:4.5];

        [two setPurchaseSharePrice:12.19];
        [two setNumberOfShares:90];
        [two setCurrentSharePrice:10.56];
        
        [three setPurchaseSharePrice:45.10];
        [three setNumberOfShares:210];
        [three setCurrentSharePrice:49.51];
        
        Portfolio *portfolio = [[Portfolio alloc] init];
        [portfolio addStock:one];
        [portfolio addStock:two];
        [portfolio addStock:three];
        float value = [portfolio value];
        
        NSLog(@"Portfolio value is %f", value);
    }
    return 0;
}

