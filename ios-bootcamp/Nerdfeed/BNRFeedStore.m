//
//  BNRFeedStore.m
//  Nerdfeed
//
//  Created by Shawn Ellis Wallace on 4/11/13.
//  Copyright (c) 2013 Shawn Ellis Wallace. All rights reserved.
//

#import "BNRFeedStore.h"
#import "RSSChannel.h"
#import "BNRConnection.h"

@implementation BNRFeedStore

+ (BNRFeedStore *)sharedStore
{
    static BNRFeedStore *feedStore = nil;
    if(!feedStore)
        feedStore = [[BNRFeedStore alloc] init];
    
    return feedStore;
}

- (void)fetchTopSongs:(int)count withCompletion:(void (^)(RSSChannel *, NSError *))block
{
    NSString *requestString = [NSString stringWithFormat:@"http://itunes.apple.com/us/rss/topsongs/limit=%d/json", count];
    
    NSURL *url = [NSURL URLWithString:requestString];
    
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    RSSChannel *channel = [[RSSChannel alloc] init];
    
    BNRConnection *connection = [[BNRConnection alloc] initWithRequest:req];
    [connection setCompletionBlock:block];
    [connection setJsonRootObject:channel];
    
    [connection start];
}

- (void)fetchRSSFeedWithCompletion:(void (^)(RSSChannel *, NSError *))block
{
    NSURL *url = [NSURL URLWithString:@"http://forums.bignerdranch.com/"
                  @"smartfeed.php?limit=1_DAY&sort_by=standard"
                  @"&feed_type=RSS2.0&feed_style=COMPACT"];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    
    RSSChannel *channel = [[RSSChannel alloc] init];
    BNRConnection *connection = [[BNRConnection alloc] initWithRequest:req];
    
    [connection setCompletionBlock:block];
    [connection setXmlRootObject:channel];
    [connection start];
}

- (void)fetchRSSClassFeedWithCompletion:(void (^)(RSSChannel *, NSError *))block
{
    NSURL *url = [NSURL URLWithString:@"http://www.bignerdranch.com/json/schedule"];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    
    RSSChannel *channel = [[RSSChannel alloc] init];
    BNRConnection *connection = [[BNRConnection alloc] initWithRequest:req];
    
    [connection setCompletionBlock:block];
    [connection setJsonRootObject:channel];
    [connection start];
}

@end
