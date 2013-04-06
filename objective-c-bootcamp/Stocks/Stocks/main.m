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

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        StockBase *one         = [[StockBase alloc] init];
        StockBase *two         = [[StockBase alloc] init];
        StockBase *three       = [[StockBase alloc] init];
        ForeignStockHolding *four = [[ForeignStockHolding alloc] init];
        
        [one setPurchaseSharePrice:2.30];
        [one setNumberOfShares:40];
        [one setCurrentSharePrice:4.5];

        [two setPurchaseSharePrice:12.19];
        [two setNumberOfShares:90];
        [two setCurrentSharePrice:10.56];
        
        [three setPurchaseSharePrice:45.10];
        [three setNumberOfShares:210];
        [three setCurrentSharePrice:49.51];
        
        [four setPurchaseSharePrice:45.10];
        [four setNumberOfShares:210];
        [four setCurrentSharePrice:49.51];
        [four setConversionRate:1.9];
        
        NSArray *stocks = [NSArray arrayWithObjects:one, two, three, four, nil];
        
        for(id stock in stocks){
            NSLog(@"%@", stock);
        }
        
    }
    return 0;
}

