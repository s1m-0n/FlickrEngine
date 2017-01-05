//
//  LocationManager.m
//  FlickerIsh
//
//  Created by Simon Wicha on 23/12/16.
//  Copyright © 2016 nomis development. All rights reserved.
//

#import "LocationManager.h"
#import "Constants.h"

@interface LocationManager () <CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *currentLocation;

@end

@implementation LocationManager

+ (id)sharedManager {
    static LocationManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
        sharedManager.locationManager = [CLLocationManager new];
        sharedManager.locationManager.delegate = sharedManager;
        if ([sharedManager.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [sharedManager.locationManager requestWhenInUseAuthorization];
        }
        [sharedManager.locationManager startUpdatingLocation];
    });
    return sharedManager;
}

- (BOOL)isLocationServiceEnabled {
    if ([CLLocationManager locationServicesEnabled]) {
        switch ([CLLocationManager authorizationStatus]) {
            case kCLAuthorizationStatusNotDetermined:
                return NO;
                break;
            case kCLAuthorizationStatusAuthorizedAlways:
                return YES;
                break;
            case kCLAuthorizationStatusAuthorizedWhenInUse:
                return YES;
                break;
            case kCLAuthorizationStatusDenied:
                return NO;
                break;
            default:
                return NO;
                break;
        }
    } else {
        return NO;
    }
}

- (BOOL)isCLAuthorizationStatusNotDetermined {
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
        return YES;
    } else return NO;
}

- (BOOL)isCLAuthorizationStatusDenied {
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
        return YES;
    } else return NO;
}

- (MKCoordinateRegion)getRegionWithLocation:(CLLocation *)passedLocation normalDistance:(BOOL) distance {
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    span.latitudeDelta =  (distance) ? 0.3 : 0.012;
    span.longitudeDelta = (distance) ? 0.3 : 0.012;;
    CLLocationCoordinate2D location;
    location.latitude = passedLocation.coordinate.latitude;
    location.longitude = passedLocation.coordinate.longitude;
    region.span = span;
    region.center = location;
    return region;
}

- (UIAlertController *) showLocationDisabledAlert {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Location Service Disabled" message:@"Please allow location service for this App in order to use it! Please navigate to your Settings and allow Location Services for this App." preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:nil]];
    return alertController;
}

#pragma mark - CLLocationManager delegate methods

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    if (!self.currentLocation) {
        self.currentLocation = [locations lastObject];
        [[NSNotificationCenter defaultCenter] postNotificationName:kCurrentLocationNotification object:@{@"currentLocation" : [locations lastObject]}];
    }
    self.currentLocation = [locations lastObject];
}


@end
