//
//  AroundMeController.m
//  FlickerIsh
//
//  Created by Simon Wicha on 29/12/16.
//  Copyright © 2016 nomis development. All rights reserved.
//

#import "AroundMeController.h"
#import "FlickrDataSource.h"
#import "Constants.h"

@implementation AroundMeController

- (instancetype)init {
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(retrieveFlickrImagesAroundCurrentLocation) name:kCurrentLocationNotification object:nil];
    }
    return self;
}

- (void)retrieveFlickrImagesAroundCurrentLocation {
    if ([[LocationManager sharedManager] isLocationServiceEnabled] && [[LocationManager sharedManager] currentLocation]) {
        CLLocation *currentLocation = [[LocationManager sharedManager] currentLocation];
        [FlickrDataSource retrieveFlickrPhotosWithLat:currentLocation.coordinate.latitude andLon:currentLocation.coordinate.longitude withCompletionHandler:^(NSArray * _Nullable array, NSError * _Nullable error) {
            if (!error) {
                self.flickrPhotoArray = array;
                [self.delegate reloadTable];
            }
        }];
    } else {
        if (![[LocationManager sharedManager] isCLAuthorizationStatusNotDetermined]) {
             [self.delegate displayModalViewController:[[LocationManager sharedManager] showLocationDisabledAlert]];
        }
    }
}

- (CLLocation *)getCurrentLocation {
    return ([[LocationManager sharedManager] currentLocation]) ? [[LocationManager sharedManager] currentLocation] : nil;
}

@end
