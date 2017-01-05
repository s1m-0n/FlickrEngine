//
//  MapHeaderCollectionReusableView.m
//  FlickerIsh
//
//  Created by Simon Wicha on 29/12/16.
//  Copyright © 2016 nomis development. All rights reserved.
//

#import "MapHeaderCollectionReusableView.h"
#import "LocationManager.h"

@implementation MapHeaderCollectionReusableView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.mapView.layer.cornerRadius = 5.f;
    self.mapView.showsUserLocation = YES;
}

- (void)centerToLocalLocation:(CLLocation *)location {
    if (location) {
        [self.mapView setRegion:[[LocationManager sharedManager] getRegionWithLocation:location normalDistance:NO] animated:YES];
    }
}

@end
