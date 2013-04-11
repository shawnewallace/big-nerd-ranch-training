//
//  RSSItem.m
//  Nerdfeed
//
//  Created by Shawn Ellis Wallace on 4/11/13.
//  Copyright (c) 2013 Shawn Ellis Wallace. All rights reserved.
//

#import "RSSItem.h"

@implementation RSSItem

@synthesize title, link, parentParserDelegate;

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
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)str
{
    [currentString appendString:str];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    currentString = nil;
    
    if([elementName isEqual:@"item"] || [elementName isEqual:@"entry"]) [parser setDelegate:parentParserDelegate];
}

@end
