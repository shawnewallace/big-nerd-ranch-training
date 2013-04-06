//
//  main.m
//  ProperNameAndDictionaryComparer
//
//  Created by Shawn Ellis Wallace on 4/6/13.
//  Copyright (c) 2013 Shawn Ellis Wallace. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[])
{
    
    @autoreleasepool {
        
        //load names
        NSString *namesRaw = [NSString
                              stringWithContentsOfFile:@"/usr/share/dict/propernames"
                              encoding:NSUTF8StringEncoding error:NULL];
        NSArray *names = [namesRaw componentsSeparatedByString:@"\n"];
        
        //load dictionary
        NSString *dictionaryRaw = [NSString
                                   stringWithContentsOfFile:@"/usr/share/dict/words"
                                                    encoding:NSUTF8StringEncoding
                                                       error:NULL];
        NSArray *words = [dictionaryRaw componentsSeparatedByString:@"\n"];
        
        for (NSString *name in names) {
            if([words containsObject:name]) {
                NSLog(@"The Name '%@' is also a word.", name);
            }
        }
        
    }
    return 0;
}

