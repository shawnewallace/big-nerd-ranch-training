//
//  RSSItem.m
//  Nerdfeed
//
//  Created by Shawn Ellis Wallace on 4/11/13.
//  Copyright (c) 2013 Shawn Ellis Wallace. All rights reserved.
//

#import "RSSItem.h"

@implementation RSSItem

@synthesize title, link, parentParserDelegate, publicationDate;

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (!self) return self;
    
    [self setTitle:[aDecoder decodeObjectForKey:@"title"]];
    [self setLink:[aDecoder decodeObjectForKey:@"link"]];
    [self setPublicationDate:[aDecoder decodeObjectForKey:@"publicationDate"]];
    
    return self;
}

- (BOOL)isEqual:(id)object
{
    if (![object isKindOfClass:[RSSItem class]]) return NO;
    
    return [[self link] isEqual:[object link]];
    
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:title forKey:@"title"];
    [aCoder encodeObject:link forKey:@"link"];
    [aCoder encodeObject:publicationDate forKey:@"publicationDate"];
}

- (void)readFromJSONDictionary:(NSDictionary *)d
{
    [self setTitle:d[@"title"][@"label"]];
    
    NSArray *links = d[@"link"];
    if ([links count] > 1) {
        NSDictionary *sampleDict = links[1][@"attributes"];
        
        [self setLink:sampleDict[@"href"]];
    }
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    NSLog(@"\t\t%@ found a %@ element", self, elementName);
    
    if ([elementName isEqual:@"title"]) {
        currentString = [[NSMutableString alloc] init];
        [self setTitle:currentString];
    } else if ([elementName isEqual:@"link"]) {
        currentString = [[NSMutableString alloc] init];
        [self setLink:currentString];
    } else if ([elementName isEqualToString:@"pubDate"]) {
        currentString = [[NSMutableString alloc] init];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)str
{
    [currentString appendString:str];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"pubDate"]) {
        static NSDateFormatter *dateFormatter = nil;
        if (!dateFormatter) {
            dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss z"];
        }
        [self setPublicationDate:[dateFormatter dateFromString:currentString]];
    }
    
    currentString = nil;
    
    if([elementName isEqual:@"item"] || [elementName isEqual:@"entry"]) [parser setDelegate:parentParserDelegate];
}

@end
