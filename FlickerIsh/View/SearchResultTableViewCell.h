//
//  SearchResultTableViewCell.h
//  FlickerIsh
//
//  Created by Simon Wicha on 2/1/17.
//  Copyright © 2017 nomis development. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlickrPhoto.h"

@interface SearchResultTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *thumpnailImageView;
@property (weak, nonatomic) IBOutlet UILabel *photoTitleLabel;
@property (strong, nonatomic) FlickrPhoto *flickrPhoto;

- (void)configureFlickrPhotoCell:(FlickrPhoto *) flickrPhoto WithCompletion:(void (^)(BOOL succeeded, UIImage *image))completionBlock;

@end
