//
//  DropImageView.m
//  IconTool
//
//  Created by LiChao Jun on 15/9/10.
//  Copyright (c) 2015年 LiChao Jun. All rights reserved.
//

#import "DropImageView.h"

@interface DropImageView () <NSDraggingDestination>

@end

@implementation DropImageView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self registerForDraggedTypes:[NSArray arrayWithObjects:NSFilenamesPboardType, nil]];
    }
    return self;
}

- (void)updateImage:(NSString*)filePath
{
    self.filePath = filePath;
    
    NSImage *image = [[NSImage alloc] initWithContentsOfFile:filePath];
    self.image = [image copy];
}

- (void)drawRect:(NSRect)rect
{
    [super drawRect:rect];
    
    if (!self.image) {
        [[NSColor colorWithCalibratedWhite:0.5f alpha:1] set];
        NSRectFill([self bounds]);
    }
}

#pragma mark - *NSDraggingDestination
- (NSDragOperation)draggingEntered:(id<NSDraggingInfo>)sender
{
    NSPasteboard *pboard = [sender draggingPasteboard];
    if ([[pboard types] containsObject:NSFilenamesPboardType]) {
        return NSDragOperationCopy;
    }
    
    return NSDragOperationNone;
}

- (BOOL)performDragOperation:(id < NSDraggingInfo >)sender
{
    NSArray *draggedFilenames = [[sender draggingPasteboard] propertyListForType:NSFilenamesPboardType];
    
    NSString *filePath = [draggedFilenames objectAtIndex:0];
    if ([[filePath pathExtension] isEqual:@"png"]
        || [[filePath pathExtension] isEqual:@"jpg"]) {
        [self updateImage:filePath];
        return YES;
    }
    
    return NO;
}

@end














