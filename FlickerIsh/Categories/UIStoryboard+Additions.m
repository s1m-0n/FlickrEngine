//
//  UIStoryboard+Additions.m
//  FlickerIsh
//
//  Created by Simon Wicha on 30/12/16.
//  Copyright © 2016 nomis development. All rights reserved.
//

#import "UIStoryboard+Additions.h"

@implementation UIStoryboard (Additions)

+ (UIStoryboard *)getMainStoryboard {
    return [UIStoryboard storyboardWithName:@"Main" bundle:nil];
}

@end
