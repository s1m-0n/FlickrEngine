//
//  FlickrTagCollectionViewCell.h
//  FlickerIsh
//
//  Created by Simon Wicha on 3/01/2017.
//  Copyright © 2017 nomis development. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FlickrTagCollectionViewCellDelegate <NSObject>

- (void)tagButtonPressedWithTag:(NSString *)tag;

@end

@interface FlickrTagCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIButton *tagButton;
@property (assign, nonatomic) id<FlickrTagCollectionViewCellDelegate> delegate;

@end
