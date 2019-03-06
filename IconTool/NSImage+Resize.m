//
//  NSImage+Resize.m
//  IconTool
//
//  Created by LiChao Jun on 15/9/10.
//  Copyright (c) 2015年 LiChao Jun. All rights reserved.
//

#import "NSImage+Resize.h"

@implementation NSImage (Resize)

- (NSImage*)resize:(NSSize)size
{
    NSRect rect = NSMakeRect(0, 0, size.width, size.height);
    NSImage *resizedImage = [[NSImage alloc] initWithSize:rect.size];
    
    [resizedImage lockFocus];
    [self drawInRect:rect fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];
    [resizedImage unlockFocus];
    
    return resizedImage;
}

@end
