//
//  Portfolio.h
//  Stocks
//
//  Created by Shawn Ellis Wallace on 4/6/13.
//  Copyright (c) 2013 Shawn Ellis Wallace. All rights reserved.
//

#import <Foundation/Foundation.h>
@class StockBase;


@interface Portfolio : NSObject
{
    NSMutableArray *stocks;
}

- (void)addStock:(StockBase *) stock;
- (float)value;

@end
