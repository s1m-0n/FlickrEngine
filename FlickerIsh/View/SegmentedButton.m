//
//  SegmentedButton.m
//  FlickerIsh
//
//  Created by Simon Wicha on 29/12/16.
//  Copyright © 2016 nomis development. All rights reserved.
//

#import "SegmentedButton.h"

@implementation SegmentedButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self setup];
    }
    
    return self;
}

- (void)setup {
    self.layer.cornerRadius = 15.f;
    self.clipsToBounds = YES;
    self.layer.borderWidth = 0.f;
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

- (void)activate {
    self.backgroundColor = [UIColor blueColor];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

- (void)deactivate {
    self.backgroundColor = [UIColor whiteColor];
    [self setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
}

@end
