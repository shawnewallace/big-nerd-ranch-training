//
//  BNRItemStore.m
//  Homepwner
//
//  Created by Shawn Ellis Wallace on 4/8/13.
//  Copyright (c) 2013 Shawn Ellis Wallace. All rights reserved.
//

#import "BNRItemStore.h"
#import "BNRItem.h"

@interface BNRItemStore()
{
    NSMutableArray *_allItems;
}

@end

@implementation BNRItemStore

@synthesize allItems = _allItems;

- (id)init
{
    self = [super init];
    
    if (!self) return self;
    
    _allItems = [[NSMutableArray alloc] init];
    
    return self;
}

- (BNRItem *)createItem
{
    BNRItem *p = [BNRItem randomItem];
    
    [_allItems addObject:p];
    
    return p;
}

+ (BNRItemStore *)sharedStore
{
    static BNRItemStore *sharedStore = nil;
    if (!sharedStore)
        sharedStore = [[super allocWithZone:nil] init];
    
    return sharedStore;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [self sharedStore];
}

@end
