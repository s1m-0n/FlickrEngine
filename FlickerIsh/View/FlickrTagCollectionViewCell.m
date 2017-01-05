//
//  FlickrTagCollectionViewCell.m
//  FlickerIsh
//
//  Created by Simon Wicha on 3/01/2017.
//  Copyright © 2017 nomis development. All rights reserved.
//

#import "FlickrTagCollectionViewCell.h"

@implementation FlickrTagCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self configureUI];
}

- (void)configureUI {
    self.tagButton.layer.cornerRadius = 15.f;
    self.tagButton.backgroundColor = [UIColor blueColor];
    [self.tagButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

- (IBAction)tagButtonPressed:(id)sender {
    [self.delegate tagButtonPressedWithTag:self.tagButton.titleLabel.text];
}

@end
