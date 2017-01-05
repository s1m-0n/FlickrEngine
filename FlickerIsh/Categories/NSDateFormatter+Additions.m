//
//  NSDateFormatter+Additions.m
//  FlickerIsh
//
//  Created by Simon Wicha on 31/12/16.
//  Copyright © 2016 nomis development. All rights reserved.
//

#import "NSDateFormatter+Additions.h"

@implementation NSDateFormatter (Additions)

+ (NSDateFormatter *)sharedFormatter {
    static NSDateFormatter *sharedFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedFormatter = [[self alloc] init];
    });
    return sharedFormatter;
}

+ (NSDateFormatter *)longDateFormatter {
    static NSDateFormatter *sharedFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedFormatter = [[self alloc] init];
        [sharedFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    });
    return sharedFormatter;
}

@end
