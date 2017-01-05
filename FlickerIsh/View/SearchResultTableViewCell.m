//
//  SearchResultTableViewCell.m
//  FlickerIsh
//
//  Created by Simon Wicha on 2/1/17.
//  Copyright © 2017 nomis development. All rights reserved.
//

#import "SearchResultTableViewCell.h"
#import "FlickrDataSource.h"

@implementation SearchResultTableViewCell

- (void)configureFlickrPhotoCell:(FlickrPhoto *) flickrPhoto WithCompletion:(void (^)(BOOL succeeded, UIImage *image))completionBlock {
    self.flickrPhoto = flickrPhoto;
    self.photoTitleLabel.text = flickrPhoto.title;
    if (!self.flickrPhoto.thumbnail) {
        [FlickrDataSource downloadFlickrPhotoImage:self.flickrPhoto WithCompletion:^(BOOL succeeded, UIImage * _Nullable image) {
            completionBlock(succeeded, image);
        }];
    } else
        completionBlock(YES, self.flickrPhoto.thumbnail);
}

@end
