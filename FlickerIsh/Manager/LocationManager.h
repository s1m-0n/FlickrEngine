//
//  LocationManager.h
//  FlickerIsh
//
//  Created by Simon Wicha on 23/12/16.
//  Copyright © 2016 nomis development. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface LocationManager : NSObject

@property (strong, nonatomic, readonly) CLLocation *currentLocation;

+ (id)sharedManager;
- (BOOL)isLocationServiceEnabled;
- (MKCoordinateRegion)getRegionWithLocation:(CLLocation *)passedLocation normalDistance:(BOOL) distance;
- (UIAlertController *) showLocationDisabledAlert;

- (BOOL)isCLAuthorizationStatusNotDetermined;
- (BOOL)isCLAuthorizationStatusDenied;

@end
