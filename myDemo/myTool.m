//
//  myTool.m
//  myDemo
//
//  Created by 公司 on 17/3/15.
//  Copyright © 2017年 PiYa. All rights reserved.
//

#import "myTool.h"

@implementation myTool

- (void)nsmNummyTool
{
    if (_xsSoundID == 0) {
        NSArray * aray = [NSArray arrayWithObjects:@"0.mp3",@"1.mp3",@"2.", nil];
        
        NSURL * url = [[NSBundle mainBundle]URLForResource:@"" withExtension:nil];
        AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &(_xsSoundID));
        AudioServicesPlaySystemSound(self.xsSoundID);
    }
}
@end
