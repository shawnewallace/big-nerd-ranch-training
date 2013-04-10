//
//  BNRImageStore.m
//  Homepwner
//
//  Created by Joe Conway on 10/26/12.
//  Copyright (c) 2012 Big Nerd Ranch. All rights reserved.
//

#import "BNRImageStore.h"

@interface BNRImageStore ()
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
        // Create the singleton
        sharedStore = [[super allocWithZone:NULL] init];
    }
    return sharedStore;
}

- (id)init
{
    self = [super init];
    if (self) {
        _dictionary = [[NSMutableDictionary alloc] init];
        
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc addObserver:self
               selector:@selector(clearCache:)
                   name:UIApplicationDidReceiveMemoryWarningNotification
                 object:nil];
    }

    return self;
}

- (void)clearCache:(NSNotification *)note
{
    NSLog(@"flushed %d images out of the cache", [_dictionary count]);
    [_dictionary removeAllObjects];
}

- (void)setImage:(UIImage *)i forKey:(NSString *)s
{
    //_dictionary[s] = i;
    [_dictionary setObject:i forKey:s];
    
    // Create full path for image
    NSString *imagePath = [self imagePathForKey:s];
    
    // Turn image into JPEG data,
    NSData *d = UIImageJPEGRepresentation(i, 0.5);
    
    // Write it to full path
    [d writeToFile:imagePath atomically:YES];
}

- (UIImage *)imageForKey:(NSString *)s
{
    // If possible, get it fromteh dictionary
    UIImage *result = [_dictionary objectForKey:s];
    
    if (result) return result;
    
    // Create UIImage object from file
    result = [UIImage imageWithContentsOfFile:[self imagePathForKey:s]];
    
    // if we found and image on the filesystem, place it into the cache
    if (result)
        [_dictionary setObject:result forKey:s];
    else
        NSLog(@"Error:  unable to find %@", [self imagePathForKey:s]);
    
    return result;
}

- (void)deleteImageForKey:(NSString *)s
{
    if (!s) return;
    [_dictionary removeObjectForKey:s];
    
    NSString *path = [self imagePathForKey:s];
    [[NSFileManager defaultManager] removeItemAtPath:path
                                               error:nil];
}

// persistence

- (NSString *)imagePathForKey:(NSString *)key
{
    NSArray *documentDirectories =
    NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                        NSUserDomainMask,
                                        YES);
    
    // Get one and only document directory from that list
    NSString *documentDirectory = [documentDirectories objectAtIndex:0];
    
    return [documentDirectory stringByAppendingPathComponent:key];
}

// end persistence

@end