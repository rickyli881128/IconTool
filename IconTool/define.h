//
//  define.h
//  IconTool
//
//  Created by LiChao Jun on 15/9/11.
//  Copyright (c) 2015年 LiChao Jun. All rights reserved.
//


static CGFloat maxScreenScaleFactor()
{
    CGFloat ret = 0;
    for (NSScreen *screen in [NSScreen screens]) {
        if (ret < screen.backingScaleFactor) {
            ret = screen.backingScaleFactor;
        }
    }
    return ret;
}
