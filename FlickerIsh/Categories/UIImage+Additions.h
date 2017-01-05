//
//  UIImage+Additions.h
//  FlickerIsh
//
//  Created by Simon Wicha on 30/12/2016.
//  Copyright © 2016 nomis development. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Additions)

+ (void)loadFromURL:(NSURL*) url withCompletion:(void (^)(UIImage *image))completion;

@end
