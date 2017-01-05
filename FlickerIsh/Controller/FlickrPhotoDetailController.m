//
//  FlickrPhotoDetailController.m
//  FlickerIsh
//
//  Created by Simon Wicha on 30/12/16.
//  Copyright © 2016 nomis development. All rights reserved.
//

#import "FlickrPhotoDetailController.h"
#import "FlickrDataSource.h"

@implementation FlickrPhotoDetailController

- (instancetype)init {
    self = [super init];
    if (self) {}
    return self;
}

- (void)retrieveMoreDetails {
    [FlickrDataSource retrieveInfosForFlickrPhoto:self.flickrPhoto withCompletionHandler:^(FlickrPhoto * _Nullable flickrPhoto, NSError * _Nullable error) {
        self.flickrPhoto = flickrPhoto;
        [self.delegate updatePhotoDetails];
    }];
    [FlickrDataSource retrieveExifForFlickrPhoto:self.flickrPhoto withCompletionHandler:^(NSDictionary * _Nullable dictionary, NSError * _Nullable error) {
        
    }];
}

@end
