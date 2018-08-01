//
//  ViewController.m
//  IconTool
//
//  Created by LiChao Jun on 15/9/10.
//  Copyright (c) 2015年 LiChao Jun. All rights reserved.
//

#import "ViewController.h"
#import "DropImageView.h"
#import "NSImage+Resize.h"
#import "define.h"

@interface ViewController ()

@property(nonatomic, strong) IBOutlet DropImageView *dropImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
    
    // Update the view, if already loaded.
}

- (IBAction)startAction:(id)sender
{
    NSString *filePath = self.dropImageView.filePath;
    
    self.iosPath = [NSString stringWithFormat:@"%@ios", [filePath substringToIndex:[filePath rangeOfString:filePath.lastPathComponent].location]];
    self.androidPath = [NSString stringWithFormat:@"%@android", [filePath substringToIndex:[filePath rangeOfString:filePath.lastPathComponent].location]];
    
    [[NSFileManager defaultManager] createDirectoryAtPath:self.iosPath withIntermediateDirectories:YES attributes:nil error:nil];
    [[NSFileManager defaultManager] createDirectoryAtPath:self.androidPath withIntermediateDirectories:YES attributes:nil error:nil];
    
    //iphone
    [self resizeIconAndSave:filePath outPutPath:self.iosPath size:20 device:Device_IPhone scale:2];
    [self resizeIconAndSave:filePath outPutPath:self.iosPath size:20 device:Device_IPhone scale:3];
    
    [self resizeIconAndSave:filePath outPutPath:self.iosPath size:29 device:Device_IPhone scale:1];
    [self resizeIconAndSave:filePath outPutPath:self.iosPath size:29 device:Device_IPhone scale:2];
    [self resizeIconAndSave:filePath outPutPath:self.iosPath size:29 device:Device_IPhone scale:3];
    
    [self resizeIconAndSave:filePath outPutPath:self.iosPath size:40 device:Device_IPhone scale:2];
    [self resizeIconAndSave:filePath outPutPath:self.iosPath size:40 device:Device_IPhone scale:3];
    
    [self resizeIconAndSave:filePath outPutPath:self.iosPath size:57 device:Device_IPhone scale:1];
    [self resizeIconAndSave:filePath outPutPath:self.iosPath size:57 device:Device_IPhone scale:2];
    
    [self resizeIconAndSave:filePath outPutPath:self.iosPath size:60 device:Device_IPhone scale:2];
    [self resizeIconAndSave:filePath outPutPath:self.iosPath size:60 device:Device_IPhone scale:3];
    
    //ipad
    [self resizeIconAndSave:filePath outPutPath:self.iosPath size:20 device:Device_IPad scale:1];
    [self resizeIconAndSave:filePath outPutPath:self.iosPath size:20 device:Device_IPad scale:2];
    
    [self resizeIconAndSave:filePath outPutPath:self.iosPath size:29 device:Device_IPad scale:1];
    [self resizeIconAndSave:filePath outPutPath:self.iosPath size:29 device:Device_IPad scale:2];
    
    [self resizeIconAndSave:filePath outPutPath:self.iosPath size:40 device:Device_IPad scale:1];
    [self resizeIconAndSave:filePath outPutPath:self.iosPath size:40 device:Device_IPad scale:2];
    
    [self resizeIconAndSave:filePath outPutPath:self.iosPath size:50 device:Device_IPad scale:1];
    [self resizeIconAndSave:filePath outPutPath:self.iosPath size:50 device:Device_IPad scale:2];
    
    [self resizeIconAndSave:filePath outPutPath:self.iosPath size:72 device:Device_IPad scale:1];
    [self resizeIconAndSave:filePath outPutPath:self.iosPath size:72 device:Device_IPad scale:2];
    
    [self resizeIconAndSave:filePath outPutPath:self.iosPath size:76 device:Device_IPad scale:1];
    [self resizeIconAndSave:filePath outPutPath:self.iosPath size:76 device:Device_IPad scale:2];
    
    [self resizeIconAndSave:filePath outPutPath:self.iosPath size:83.5f device:Device_IPad scale:2];
    
    [self resizeIconAndSave:filePath outPutPath:self.iosPath size:1024 device:Device_AppStore scale:1];
    
    //android
    NSString *xhdpiPath = [NSString stringWithFormat:@"%@/drawable-xhdpi", self.androidPath];
    [[NSFileManager defaultManager] createDirectoryAtPath:xhdpiPath withIntermediateDirectories:YES attributes:nil error:nil];
    [self resizeIconAndSave:filePath outPutPath:xhdpiPath size:96 device:Device_Android scale:1];
    
    NSString *hdpiPath = [NSString stringWithFormat:@"%@/drawable-hdpi", self.androidPath];
    [[NSFileManager defaultManager] createDirectoryAtPath:hdpiPath withIntermediateDirectories:YES attributes:nil error:nil];
    [self resizeIconAndSave:filePath outPutPath:hdpiPath size:72 device:Device_Android scale:1];
    
    NSString *ldpiPath = [NSString stringWithFormat:@"%@/drawable-ldpi", self.androidPath];
    [[NSFileManager defaultManager] createDirectoryAtPath:ldpiPath withIntermediateDirectories:YES attributes:nil error:nil];
    [self resizeIconAndSave:filePath outPutPath:ldpiPath size:48 device:Device_Android scale:1];
    
    NSString *mdpiPath = [NSString stringWithFormat:@"%@/drawable-mdpi", self.androidPath];
    [[NSFileManager defaultManager] createDirectoryAtPath:mdpiPath withIntermediateDirectories:YES attributes:nil error:nil];
    [self resizeIconAndSave:filePath outPutPath:mdpiPath size:36 device:Device_Android scale:1];
}

- (void)resizeIconAndSave:(NSString*)filePath
               outPutPath:(NSString*)outPutPath
                     size:(CGFloat)size
                   device:(Device)device
                    scale:(int)scale
{
    CGFloat size_ = size / maxScreenScaleFactor();
    
    NSImage *image = [[[NSImage alloc] initWithContentsOfFile:filePath] resize:NSMakeSize(size_*scale, size_*scale)];
    NSData *imageData = [image TIFFRepresentation];
    
    NSBitmapImageRep *imageRep = [NSBitmapImageRep imageRepWithData:imageData];
    NSData *newImageData = [imageRep representationUsingType:NSPNGFileType properties:[NSDictionary dictionary]];
    
    NSMutableString *fileName = [NSMutableString stringWithString:@"Icon"];
    switch (device) {
        case Device_IPhone: {
            [fileName appendFormat:@"-iphone-%d", (int)size_];
            if (scale > 1) {
                [fileName appendFormat:@"@%dx", scale];
            }
            [fileName appendString:@".png"];
        } break;
            
        case Device_IPad: {
            [fileName appendFormat:@"-ipad-%d", (int)size_];
            if (scale > 1) {
                [fileName appendFormat:@"@%dx", scale];
            }
            [fileName appendString:@".png"];
        } break;
            
        case Device_AppStore: {
            [fileName appendFormat:@"-%d", (int)size_];
            if (scale > 1) {
                [fileName appendFormat:@"@%dx", scale];
            }
            [fileName appendString:@".png"];
        } break;
            
        case Device_Android: {
            fileName = [NSMutableString stringWithString:@"icon.png"];
        } break;
            
        default:
            break;
    }
    
    NSString *newFilePath = [NSString stringWithFormat:@"%@/%@", outPutPath, fileName];
    [newImageData writeToFile:newFilePath atomically:YES];
}

@end





