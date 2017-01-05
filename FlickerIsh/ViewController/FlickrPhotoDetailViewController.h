//
//  FlickrPhotoDetailViewController.h
//  FlickerIsh
//
//  Created by Simon Wicha on 30/12/2016.
//  Copyright © 2016 nomis development. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlickrPhotoDetailController.h"
#import "FlickrPhoto.h"

@interface FlickrPhotoDetailViewController : UIViewController

- (void)setController:(FlickrPhotoDetailController *)controller withFlickrPhoto:(FlickrPhoto *)flickrPhoto;

@end
