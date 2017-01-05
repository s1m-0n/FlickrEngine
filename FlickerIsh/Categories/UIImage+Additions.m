//
//  UIImage+Additions.m
//  FlickerIsh
//
//  Created by Simon Wicha on 30/12/2016.
//  Copyright © 2016 nomis development. All rights reserved.
//

#import "UIImage+Additions.h"

@implementation UIImage (Additions)

+ (void)loadFromURL:(NSURL*)url withCompletion:(void (^)(UIImage *image))completion {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^{
        NSData * imageData = [NSData dataWithContentsOfURL:url];
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImage *image = [UIImage imageWithData:imageData];
            completion(image);
        });
    });
}

@end
