//
//  BNRDrawView.m
//  TouchTracker
//
//  Created by Shawn Ellis Wallace on 4/10/13.
//  Copyright (c) 2013 Shawn Ellis Wallace. All rights reserved.
//

#import "BNRDrawView.h"
#import "BNRLine.h"

@interface BNRDrawView()
{
    UIPanGestureRecognizer *_moveRecognizer;
    NSMutableDictionary *_linesInProgress;
    NSMutableArray *_finishedLines;
}

@property (nonatomic, weak) BNRLine *selectedLine;

-(BNRLine *)lineAtPoint:(CGPoint)p;

@end

@implementation BNRDrawView

- (id)initWithFrame:(CGRect)r
{
    self = [super initWithFrame:r];
    
    if (!self) return self;
    
    _linesInProgress = [[NSMutableDictionary alloc] init];
    _finishedLines = [[NSMutableArray alloc] init];
    [self setBackgroundColor:[UIColor grayColor]];
    [self setMultipleTouchEnabled:YES];
    
    UITapGestureRecognizer *doubleTapRecognizer = [[UITapGestureRecognizer alloc]
                                                   initWithTarget:self
                                                   action:@selector(doubleTap:)];
    [doubleTapRecognizer setNumberOfTapsRequired:2];
    [doubleTapRecognizer setDelaysTouchesBegan:YES];
    [self addGestureRecognizer:doubleTapRecognizer];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]
                                             initWithTarget:self
                                             action:@selector(tap:)];
    [tapRecognizer setDelaysTouchesBegan:YES];
    [tapRecognizer requireGestureRecognizerToFail:doubleTapRecognizer];
    [self addGestureRecognizer:tapRecognizer];
    
    UILongPressGestureRecognizer *pressRecognizer = [[UILongPressGestureRecognizer alloc]
                                                     initWithTarget:self
                                                     action:@selector(longPress:)];
    [self addGestureRecognizer:pressRecognizer];
    
    _moveRecognizer = [[UIPanGestureRecognizer alloc]
                       initWithTarget:self
                       action:@selector(moveLine:)];
    [_moveRecognizer setDelegate:self];
    [_moveRecognizer setCancelsTouchesInView:NO];
    [self addGestureRecognizer:_moveRecognizer];
    
    return self;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
    shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if (gestureRecognizer == _moveRecognizer) return YES;
    
    return NO;
}

- (void)moveLine:(UIPanGestureRecognizer *)gr
{
    // If we haven't selected a line, we don't do anything here
    if (![self selectedLine]) return;
    
    if([[UIMenuController sharedMenuController] isMenuVisible]) return;
    
    // When the pan recognizer changes its position
    if ([gr state] == UIGestureRecognizerStateChanged) {
        // How far has the pan moved?
        CGPoint translation = [gr translationInView:self];
        
        // Add the translation to the current being and end points of the line
        CGPoint begin = [[self selectedLine] begin];
        CGPoint end = [[self selectedLine] end];
        begin.x += translation.x;
        begin.y += translation.y;
        end.x += translation.x;
        end.y += translation.y;
        
        // Set the new beginning and end points of the line
        [[self selectedLine] setBegin:begin];
        [[self selectedLine] setEnd:end];
        
        // Redraw the screen
        [self setNeedsDisplay];
        
        [gr setTranslation:CGPointZero inView:self];
    }
}

- (void)longPress:(UIGestureRecognizer *)gr
{
    NSLog(@"Recognized Long Press");
    if ([gr state] == UIGestureRecognizerStateBegan) {
        CGPoint point = [gr locationInView:self];
        [self setSelectedLine:[self lineAtPoint:point]];
        
        if ([self selectedLine]) {
            [_linesInProgress removeAllObjects];
        }
    } else if ([gr state] == UIGestureRecognizerStateEnded) {
        [self setSelectedLine:nil];
    }
        
    [self setNeedsDisplay];
}

- (void)tap:(UIGestureRecognizer *)gr
{
    NSLog(@"Recognized tap");
    
    CGPoint point = [gr locationInView:self];
    [self setSelectedLine:[self lineAtPoint:point]];
    
    
    if ([self selectedLine]) {
        // Make ourselves the target of menu item action changes
        [self becomeFirstResponder];
        
        // Grab the menu controller
        UIMenuController *menu = [UIMenuController sharedMenuController];
        
        // Create a new "Delete" menu item
        UIMenuItem *deleteItem = [[UIMenuItem alloc] initWithTitle:@"Delete"
                                                            action:@selector(deleteLine:)];
        [menu setMenuItems:@[deleteItem]];
        
        // Tell the menu where it should come from and show it
        [menu setTargetRect:CGRectMake(point.x, point.y, 2, 2) inView:self];
        [menu setMenuVisible:YES animated:YES];
    } else {
        [[UIMenuController sharedMenuController] setMenuVisible:NO animated:YES];
    }

    
    [self setNeedsDisplay];
}

- (void)doubleTap:(UIGestureRecognizer *)gr
{
    NSLog(@"Recognized Double Tag");
    
    [_linesInProgress removeAllObjects];
    [_finishedLines removeAllObjects];
    
    [self setNeedsDisplay];
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (void)deleteLine:(id)sender
{
    // Remove the selected line from teh list of _finishedLines
    [_finishedLines removeObject:[self selectedLine]];
    
    // Redraw everything
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    // Create a block that will configure and draw a BNRLine
    void(^strokeLine)(BNRLine *) = ^(BNRLine *line) {
        //NSLog(@"Line is Drawn:  %@", line);
        UIBezierPath *bp = [UIBezierPath bezierPath];
        [bp moveToPoint:[line begin]];
        [bp addLineToPoint:[line end]];
        [bp setLineWidth:10];
        [bp setLineCapStyle:kCGLineCapRound];
        
        [bp stroke];
    };
    
    // Draw finished lines in black
    [[UIColor blackColor] set];
    for (BNRLine *line in _finishedLines) {
        strokeLine(line);
    }

    [[UIColor redColor] set];
    for(NSValue *key in _linesInProgress) {
        strokeLine([_linesInProgress objectForKey:key]);
    }
    
    if([self selectedLine]) {
        [[UIColor greenColor] set];
        strokeLine([self selectedLine]);
    }
}

- (BNRLine *)lineAtPoint:(CGPoint)p
{
    // Fine a line close to p
    for (BNRLine *l in _finishedLines) {
        CGPoint start = [l begin];
        CGPoint end = [l end];
        
        // Check a few points on the line
        for(float t = 0.0; t <= 1.0; t += 0.05) {
            float x = start.x + t * (end.x - start.x);
            float y = start.y + t * (end.y - start.y);
            
            // If the tapped point is within 20 points, let's return this line
            if (hypot(x - p.x, y - p.y) < 20.0) {
                return l;
            }
        }
    }
    
    // If nothing is close enough to the tapped point, then we didn't select a line
    return nil;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // Let's put in a log statement to see the order of events
    //NSLog(@"%@", NSStringFromSelector(_cmd));
    
    for(UITouch *t in touches) {
        CGPoint location = [t locationInView:self];
        BNRLine *line = [[BNRLine alloc] init];
        [line setBegin:location];
        [line setEnd:location];
        
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        [_linesInProgress setObject:line
                             forKey:key];
    }
    
    [self setNeedsDisplay];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    // Let's put in a log statement to see the order of events
    //NSLog(@"%@", NSStringFromSelector(_cmd));
    
    for(UITouch *t in touches) {
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        BNRLine *line = [_linesInProgress objectForKey:key];
        [line setEnd:[t locationInView:self]];
    }
    
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    // Let's put in a log statement to see the order of events
    //NSLog(@"%@", NSStringFromSelector(_cmd));
    
    for(UITouch *t in touches) {
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        BNRLine *line = [_linesInProgress objectForKey:key];
        [_finishedLines addObject:line];
        [_linesInProgress removeObjectForKey:key];
    }
    
    [self setNeedsDisplay];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    // Let's put in a log statement to see the order of events
    //NSLog(@"%@", NSStringFromSelector(_cmd));
    
    for(UITouch *t in touches) {
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        [_linesInProgress removeObjectForKey:key];
    }
    
    [self setNeedsDisplay];

}

@end
