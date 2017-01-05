//
//  MapHeaderCollectionReusableView.h
//  FlickerIsh
//
//  Created by Simon Wicha on 29/12/16.
//  Copyright © 2016 nomis development. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapHeaderCollectionReusableView : UICollectionReusableView

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
- (void)centerToLocalLocation:(CLLocation *)location;

@end
