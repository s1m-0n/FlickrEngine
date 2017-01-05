//
//  FlickrPhotoDetailController.h
//  FlickerIsh
//
//  Created by Simon Wicha on 30/12/16.
//  Copyright © 2016 nomis development. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FlickrPhoto.h"

@protocol FlickrPhotoDetailControllerDelegate <NSObject>

-(void)updatePhotoDetails;

@end

@interface FlickrPhotoDetailController : NSObject

@property (assign, nonatomic) id<FlickrPhotoDetailControllerDelegate> delegate;
@property (strong, nonatomic) FlickrPhoto *flickrPhoto;

- (void)retrieveMoreDetails;

@end
