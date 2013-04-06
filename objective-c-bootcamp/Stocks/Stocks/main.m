//
//  main.m
//  Stocks
//
//  Created by Shawn Ellis Wallace on 4/6/13.
//  Copyright (c) 2013 Shawn Ellis Wallace. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StockHolding.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        StockHolding *one = [[StockHolding alloc] init];
        StockHolding *two = [[StockHolding alloc] init];
        StockHolding *three = [[StockHolding alloc] init];
        
        [one setPurchaseSharePrice:2.30];
        [one setNumberOfShares:40];
        [one setCurrentSharePrice:4.5];
        

        [two setPurchaseSharePrice:12.19];
        [two setNumberOfShares:90];
        [two setCurrentSharePrice:10.56];
        
        [three setPurchaseSharePrice:45.10];
        [three setNumberOfShares:210];
        [three setCurrentSharePrice:49.51];
        
        NSArray *stocks = [NSArray arrayWithObjects:one, two, three, nil];
        
        for(StockHolding *stock in stocks){
            NSLog(@"Purchase Price: %f, Current Price: %f, NumShares: %d, Cost: %f, Value: %f",
                  [stock purchaseSharePrice],
                  [stock currentSharePrice],
                  [stock numberOfShares],
                  [stock costInDollars],
                  [stock valueInDollars]);
        }
        
    }
    return 0;
}

