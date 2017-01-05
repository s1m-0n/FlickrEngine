//
//  AroundMeController.h
//  FlickerIsh
//
//  Created by Simon Wicha on 29/12/16.
//  Copyright © 2016 nomis development. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LocationManager.h"

@protocol AroundMeControllerDelegate <NSObject>

- (void)displayModalViewController:(UIViewController *)viewController;
- (void)reloadTable;

@end

@interface AroundMeController : NSObject

- (void)retrieveFlickrImagesAroundCurrentLocation;
- (CLLocation *)getCurrentLocation;

@property (assign, nonatomic) id<AroundMeControllerDelegate> delegate;
@property (strong, nonatomic) NSArray *flickrPhotoArray;

@end
