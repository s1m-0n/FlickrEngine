//
//  ContainerViewController.m
//  FlickerIsh
//
//  Created by Simon Wicha on 29/12/16.
//  Copyright © 2016 nomis development. All rights reserved.
//

#import "ContainerViewController.h"
#import "SegmentedButton.h"
#import "LocationManager.h"

@interface ContainerViewController ()

@property (weak, nonatomic) IBOutlet SegmentedButton *aroundMeButton;
@property (weak, nonatomic) IBOutlet UIView *aroundMeContainerView;
@property (weak, nonatomic) IBOutlet SegmentedButton *searchPhotosButton;
@property (weak, nonatomic) IBOutlet UIView *searchPhotosContainerView;

@end

@implementation ContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.aroundMeButton activate];
    [self.searchPhotosButton deactivate];
    if (![[LocationManager sharedManager] isLocationServiceEnabled] && ![[LocationManager sharedManager] isCLAuthorizationStatusNotDetermined]) {
        [self presentViewController:[[LocationManager sharedManager] showLocationDisabledAlert] animated:YES completion:nil];
    }
}

- (IBAction)aroundMeButtonPressed:(id)sender {
    [self.aroundMeButton activate];
    [self.searchPhotosButton deactivate];
    self.aroundMeContainerView.alpha = 1.f;
    self.searchPhotosContainerView.alpha = 0.f;
    [self.view bringSubviewToFront:self.aroundMeContainerView];
}

- (IBAction)searchPhotosButtonPressed:(id)sender {
    [self.aroundMeButton deactivate];
    [self.searchPhotosButton activate];
    self.aroundMeContainerView.alpha = 0.f;
    self.searchPhotosContainerView.alpha = 1.f;
    [self.view bringSubviewToFront:self.searchPhotosContainerView];
}

@end
