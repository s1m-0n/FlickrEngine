//
//  FlickrPhotoDetailViewController.m
//  FlickerIsh
//
//  Created by Simon Wicha on 30/12/2016.
//  Copyright © 2016 nomis development. All rights reserved.
//

#import "FlickrPhotoDetailViewController.h"
#import <MapKit/MapKit.h>
#import "UIImage+Additions.h"
#import "NSDateFormatter+Additions.h"
#import "LocationManager.h"

@interface FlickrPhotoDetailViewController () <FlickrPhotoDetailControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *photoTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *photoDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *photoUsernameLabel;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *imageLoadingIndicator;
@property (weak, nonatomic) IBOutlet UIVisualEffectView *noGeoDataEffectView;

@property (weak, nonatomic) IBOutlet UIVisualEffectView *detailsContainerEffectView;
@property (weak, nonatomic) IBOutlet UIView *backgroundView;


@property (strong, nonatomic) FlickrPhotoDetailController *controller;


@end

@implementation FlickrPhotoDetailViewController {
    BOOL imageFullScreen;
    CGRect originalImageFrameSize;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

- (void)setController:(FlickrPhotoDetailController *)controller withFlickrPhoto:(FlickrPhoto *)flickrPhoto {
    self.controller = controller;
    self.controller.flickrPhoto = flickrPhoto;
    self.controller.delegate = self;
}

- (void)setupView {
    self.backgroundImageView.image = self.controller.flickrPhoto.thumbnail;
    [self.controller retrieveMoreDetails];
    [UIImage loadFromURL:[NSURL URLWithString:self.controller.flickrPhoto.imageURL] withCompletion:^(UIImage *image) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.imageLoadingIndicator stopAnimating];
            self.backgroundImageView.image = image;
            self.imageView.image = image;
        });
    }];
    self.photoTitleLabel.text = (self.controller.flickrPhoto.title && self.controller.flickrPhoto.title.length != 0) ? self.controller.flickrPhoto.title : @"No Title";
    self.photoUsernameLabel.text = @"";
    self.photoDateLabel.text = @"";
    self.noGeoDataEffectView.layer.cornerRadius =  5.f;
    self.noGeoDataEffectView.clipsToBounds = YES;
    self.noGeoDataEffectView.hidden = YES;
    self.mapView.layer.cornerRadius = 5.f;
    self.mapView.showsUserLocation = YES;
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    imageFullScreen = YES;
    [self tappedPhotoImageView:nil];
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
}

# pragma mark - FlickrPhotoDetailControllerDelegate methods

- (void)updatePhotoDetails {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSDateFormatter *formatter = [NSDateFormatter sharedFormatter];
        [formatter setDateStyle:NSDateFormatterShortStyle];
        self.photoDateLabel.text = [formatter stringFromDate:self.controller.flickrPhoto.date];
        self.photoUsernameLabel.text = self.controller.flickrPhoto.username;
        if (self.controller.flickrPhoto.latitude && self.controller.flickrPhoto.longitude) {
            MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
            CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([self.controller.flickrPhoto.latitude doubleValue], [self.controller.flickrPhoto.longitude doubleValue]);
            annotation.coordinate = coordinate;
            annotation.title = self.photoTitleLabel.text;
            CLLocation *coordinateForRegion = [[CLLocation alloc] initWithLatitude:[self.controller.flickrPhoto.latitude doubleValue] longitude:[self.controller.flickrPhoto.longitude doubleValue]];
            self.mapView.showsUserLocation = YES;
            [self.mapView setRegion:[[LocationManager sharedManager] getRegionWithLocation:coordinateForRegion normalDistance:YES] animated:YES];
            [self.mapView addAnnotation:annotation];
        } else {
            self.noGeoDataEffectView.hidden = NO;
            self.mapView.userInteractionEnabled = NO;
        }
    });
}

- (IBAction)tappedPhotoImageView:(id)sender {
    if (!imageFullScreen) {
        [UIView animateWithDuration:0.3f delay:0 options:0 animations:^{
            originalImageFrameSize = self.imageView.frame;
            [self.imageView setFrame:[[UIScreen mainScreen] bounds]];
            self.detailsContainerEffectView.alpha = 0.f;
            self.mapView.alpha = 0.f;
            self.backgroundView.alpha = 0.f;
            self.noGeoDataEffectView.alpha = 0.f;
        }completion:^(BOOL finished){
            imageFullScreen = YES;
        }];
        return;
    } else {
        [UIView animateWithDuration:0.3f delay:0 options:0 animations:^{
            [self.imageView setFrame:originalImageFrameSize];
            self.detailsContainerEffectView.alpha = 1.f;
            self.mapView.alpha = 1.f;
            self.backgroundView.alpha = 1.f;
            self.noGeoDataEffectView.alpha = 1.f;
        }completion:^(BOOL finished){
            imageFullScreen = NO;
        }];
        return;
    }
}

# pragma mark - IBAction methods

- (IBAction)closeButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
