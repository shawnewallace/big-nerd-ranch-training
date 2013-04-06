//
//  Portfolio.m
//  Stocks
//
//  Created by Shawn Ellis Wallace on 4/6/13.
//  Copyright (c) 2013 Shawn Ellis Wallace. All rights reserved.
//

#import "Portfolio.h"
#import "StockBase.h"

@implementation Portfolio


- (void)addStock:(StockBase *) stock
{
    if(!stocks) {
        stocks = [[NSMutableArray alloc]init];
    }
    [stocks addObject:stock];
}

- (float)value
{
    float sum = 0.0;
    
    for(StockBase *stock in stocks) {
        sum += [stock valueInDollars];
    }
    
    return sum;
}


@end
