//
//  RSSChannel.m
//  Nerdfeed
//
//  Created by Shawn Ellis Wallace on 4/11/13.
//  Copyright (c) 2013 Shawn Ellis Wallace. All rights reserved.
//

#import "RSSChannel.h"
#import "RSSItem.h"

@implementation RSSChannel

@synthesize items, title, infoString, parentParserDelegate;

- (id)init
{
    self = [super init];
    if (!self) return self;
    
    // Create the container for the RSSItems this channel has
    
    items = [[NSMutableArray alloc] init];
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (!self) return self;
    
    items = [aDecoder decodeObjectForKey:@"items"];
    [self setInfoString:[aDecoder decodeObjectForKey:@"infoString"]];
    [self setTitle:[aDecoder decodeObjectForKey:@"title"]];
    
    return self;
}

- (id)copyWithZone:(NSZone *)zone
{
    RSSChannel *c = [[[self class] alloc] init];
    
    [c setTitle:[self title]];
    [c setInfoString:[self infoString]];
    c->items = [items mutableCopy];
    
    return c;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:items forKey:@"items"];
    [aCoder encodeObject:title forKey:@"title"];
    [aCoder encodeObject:infoString forKey:@"infoString"];
}

- (void)readFromJSONDictionary:(NSDictionary *)d
{
    NSDictionary *feed = d[@"feed"];
    [self setTitle:feed[@"title"]];
    NSArray *entries = feed[@"entry"];
    for (NSDictionary *entry in entries) {
        RSSItem *i = [[RSSItem alloc] init];
        [i readFromJSONDictionary:entry];
        
        [items addObject:i];
    }
}

- (void)addItemsFromChannel:(RSSChannel *)otherChannel
{
    for (RSSItem *i in [otherChannel items]) {
        if (![[self items] containsObject:i]) [[self items] addObject:i];
    }
    
    [[self items] sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [[obj2 publicationDate] compare:[obj1 publicationDate]];
    }];
    
}


- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
    attributes:(NSDictionary *)attributeDict
{
    NSLog(@"%@ found a %@ element", self, elementName);
    
    if ([elementName isEqual:@"title"]) {
        currentString = [[NSMutableString alloc] init];
        [self setTitle:currentString];
    } else if ([elementName isEqual:@"description"]) {
        currentString = [[NSMutableString alloc] init];
        [self setInfoString:currentString];
    } else if ([elementName isEqual:@"item"] || [elementName isEqual:@"entry"]){
        RSSItem *entry = [[RSSItem alloc] init];
        [entry setParentParserDelegate:self];
        [parser setDelegate:entry];
        [items addObject:entry];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)str
{
    [currentString appendString:str];
}

- (void)parser:(NSXMLParser *) parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    currentString = nil;
    
    // if the element that ended was the channel, give up control to
    // who gave us control in the first place
    if ([elementName isEqual:@"channel"]) {
        [parser setDelegate:parentParserDelegate];
        [self trimItemTitles];
    }
}

- (void)trimItemTitles
{
    NSRegularExpression *reg = [[NSRegularExpression alloc] initWithPattern:@".* :: (.*) :: .*"
                                                                    options:0
                                                                      error:nil];
    for(RSSItem *i in items) {
        NSString *itemTitle = [i title];
        
        NSArray *matches = [reg matchesInString:itemTitle
                                        options:0
                                          range:NSMakeRange(0, [itemTitle length])];
        
        if ([matches count] > 0) {
            NSTextCheckingResult *result = matches[0];
            NSRange r = [result range];
            NSLog(@"Match at {%d, %d} for %@!", r.location, r.length, itemTitle);
            
            if([result numberOfRanges] == 2){
                NSRange r = [result rangeAtIndex:1];
                [i setTitle:[itemTitle substringWithRange:r]];
            }
        }
    }
}

@end
