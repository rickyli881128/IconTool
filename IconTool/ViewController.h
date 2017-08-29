//
//  ViewController.h
//  IconTool
//
//  Created by LiChao Jun on 15/9/10.
//  Copyright (c) 2015年 LiChao Jun. All rights reserved.
//

#import <Cocoa/Cocoa.h>

typedef enum
{
    Device_IPhone = 0,
    Device_IPad,
    Device_Android
} Device;

@interface ViewController : NSViewController

@property(nonatomic, strong) NSString *iosPath;
@property(nonatomic, strong) NSString *androidPath;

@end

