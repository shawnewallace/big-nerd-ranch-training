//
//  BNRItemStore.h
//  Homepwner
//
//  Created by Joe Conway on 10/25/12.
//  Copyright (c) 2012 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BNRItem;


@interface BNRItemStore : NSObject
+ (BNRItemStore *)sharedStore;

@property (nonatomic, strong, readonly) NSArray *allItems;

- (void)removeItem:(BNRItem *)p;
- (BNRItem *)createItem;


- (void)moveItemAtIndex:(int)from
                toIndex:(int)to;

- (BOOL)saveChanges;

@end
