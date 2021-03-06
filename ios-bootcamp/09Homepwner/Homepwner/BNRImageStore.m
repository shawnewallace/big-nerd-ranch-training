//
//  BNRImageStore.m
//  Homepwner
//
//  Created by Shawn Ellis Wallace on 4/9/13.
//  Copyright (c) 2013 Big Nerd Ranch. All rights reserved.
//

#import "BNRImageStore.h"

@interface BNRImageStore()
{
    NSMutableDictionary *_dictionary;
}

@end

@implementation BNRImageStore

+ (id)allocWithZone:(NSZone *)zone
{
    return [self sharedStore];
}

+ (BNRImageStore *)sharedStore
{
    static BNRImageStore *sharedStore = nil;
    
    if (!sharedStore) {
        sharedStore = [[super allocWithZone:NULL] init];
    }
    
    return sharedStore;
}

- (id)init
{
    self = [super init];
    if (!self) return self;
    
    _dictionary = [[NSMutableDictionary alloc] init];
    
    return self;
}

- (void)setImage:(UIImage *)i forKey:(NSString *)s
{
    [_dictionary setObject:i forKey:s];
}

- (UIImage *)imageForKey:(NSString *)s
{
    return [_dictionary objectForKey:s];
}

- (void)deleteImageForKey:(NSString *)s
{
    if (!s) return;
    [_dictionary removeObjectForKey:s];
}

@end
