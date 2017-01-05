//
//  NSDateFormatter+Additions.h
//  FlickerIsh
//
//  Created by Simon Wicha on 31/12/16.
//  Copyright © 2016 nomis development. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDateFormatter (Additions)

+ (NSDateFormatter *)sharedFormatter;
+ (NSDateFormatter *)longDateFormatter;

@end
