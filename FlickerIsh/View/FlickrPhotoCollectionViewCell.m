//
//  FlickrPhotoCollectionViewCell.m
//  FlickerIsh
//
//  Created by Simon Wicha on 29/12/16.
//  Copyright © 2016 nomis development. All rights reserved.
//

#import "FlickrPhotoCollectionViewCell.h"
#import "FlickrDataSource.h"

@implementation FlickrPhotoCollectionViewCell

- (void)configureFlickrPhotoCell:(FlickrPhoto *) flickrPhoto WithCompletion:(void (^)(BOOL succeeded, UIImage *image))completionBlock {
    self.flickrPhoto = flickrPhoto;
    if (!self.flickrPhoto.thumbnail) {
        [FlickrDataSource downloadFlickrPhotoImage:self.flickrPhoto WithCompletion:^(BOOL succeeded, UIImage * _Nullable image) {
            completionBlock(succeeded, image);
        }];
    } else
        completionBlock(YES, self.flickrPhoto.thumbnail);
   
}

@end
