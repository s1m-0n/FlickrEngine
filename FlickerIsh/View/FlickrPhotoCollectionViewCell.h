//
//  FlickrPhotoCollectionViewCell.h
//  FlickerIsh
//
//  Created by Simon Wicha on 29/12/16.
//  Copyright © 2016 nomis development. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlickrPhoto.h"

@interface FlickrPhotoCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (strong, nonatomic) FlickrPhoto *flickrPhoto;

- (void)configureFlickrPhotoCell:(FlickrPhoto *) flickrPhoto WithCompletion:(void (^)(BOOL succeeded, UIImage *image))completionBlock;

@end
