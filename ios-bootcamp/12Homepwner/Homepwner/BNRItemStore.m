//
//  BNRItemStore.m
//  Homepwner
//
//  Created by Joe Conway on 10/25/12.
//  Copyright (c) 2012 Big Nerd Ranch. All rights reserved.
//

#import "BNRItemStore.h"
#import "BNRItem.h"
#import "BNRImageStore.h"

@interface BNRItemStore ()
{
    NSMutableArray *_allItems;
}
@end

@implementation BNRItemStore

@synthesize allItems = _allItems;

- (NSString *)itemArchivePath
{
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                                       NSUserDomainMask,
                                                                       YES);
    
    // Get one and only document directory from that list
    NSString *documentDirectory = [documentDirectories objectAtIndex:0];
    
    return [documentDirectory stringByAppendingPathComponent:@"items.archive"];
}

- (id)init
{
    self = [super init];
    if (!self) return self;
    
//    _allItems = [[NSMutableArray alloc] init];
    NSString *path = [self itemArchivePath];
    _allItems = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    
    // If the array hadn't been saved previously, create a new empty one
    if (!_allItems)
        _allItems = [[NSMutableArray alloc] init];
    

    return self;
}

+ (BNRItemStore *)sharedStore
{
    static BNRItemStore *sharedStore = nil;
    if (!sharedStore)
        sharedStore = [[super allocWithZone:nil] init];
    return sharedStore;
}


- (void)removeItem:(BNRItem *)p
{
    NSString *key = [p imageKey];
    [[BNRImageStore sharedStore] deleteImageForKey:key];
    
    [_allItems removeObjectIdenticalTo:p];
}

- (void)moveItemAtIndex:(int)from
                toIndex:(int)to
{
    if (from == to) {
        return;
    }
    // Get pointer to object being moved so we can re-insert it
    BNRItem *p = _allItems[from];

    // Remove p from array
    [_allItems removeObjectAtIndex:from];

    // Insert p in array at new location
    [_allItems insertObject:p atIndex:to];
}

- (BNRItem *)createItem
{
    //BNRItem *p = [BNRItem randomItem];
    BNRItem *p = [[BNRItem alloc]init];

    [_allItems addObject:p];

    return p;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [self sharedStore];
}

// Persistence

- (BOOL)saveChanges
{
    // return success of failure
    NSString *path = [self itemArchivePath];
    
    return [NSKeyedArchiver archiveRootObject:_allItems toFile:path];
}

// end persistence

@end
