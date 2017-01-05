//
//  AroundMeTableViewController.m
//  FlickerIsh
//
//  Created by Simon Wicha on 29/12/16.
//  Copyright © 2016 nomis development. All rights reserved.
//

#import "AroundMeViewController.h"
#import "AroundMeController.h"
#import "FlickrPhoto.h"
#import "FlickrPhotoCollectionViewCell.h"
#import "MapHeaderCollectionReusableView.h"
#import "FlickrPhotoDetailViewController.h"
#import "UIStoryboard+Additions.h"

@interface AroundMeViewController () <AroundMeControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource>

@property (strong, nonatomic) AroundMeController *controller;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIVisualEffectView *loadingIndicatorView;

@end

@implementation AroundMeViewController

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.controller = [AroundMeController new];
    self.controller.delegate = self;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self setupLoadingIndicator];
    [self.controller retrieveFlickrImagesAroundCurrentLocation];
}

- (void)setupLoadingIndicator {
    self.loadingIndicatorView.layer.cornerRadius = 5.f;
    self.loadingIndicatorView.clipsToBounds = YES;
}

#pragma mark - AroundMeControllerDelegate methods

-(void)displayModalViewController:(UIViewController *)viewController {
    [self presentViewController:viewController animated:YES completion:nil];
}

- (void)reloadTable {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"Reload Collection View");
        self.loadingIndicatorView.hidden = YES;
        [self.collectionView reloadData];
    });
}

#pragma mark - CollectionView data source

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FlickrPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FlickrPhotoCollectionViewCellReuseID" forIndexPath:indexPath];
    [cell configureFlickrPhotoCell:self.controller.flickrPhotoArray[indexPath.row] WithCompletion:^(BOOL succeeded, UIImage *image) {
        if (succeeded) {
            dispatch_async(dispatch_get_main_queue(), ^{
                FlickrPhoto *flickrPhoto = self.controller.flickrPhotoArray[indexPath.row];
                flickrPhoto.thumbnail = image;
                cell.photoImageView.image = image;
            });
        }
    }];
    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.controller.flickrPhotoArray.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    FlickrPhotoDetailViewController *flickrDetailVC = [[UIStoryboard getMainStoryboard] instantiateViewControllerWithIdentifier:@"FlickrPhotoDetailViewController"];
    [flickrDetailVC setController:[FlickrPhotoDetailController new] withFlickrPhoto:self.controller.flickrPhotoArray[indexPath.row]];
    [self presentViewController:flickrDetailVC animated:YES completion:nil];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        MapHeaderCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MapHeaderCollectionReusableView" forIndexPath:indexPath];
        [headerView centerToLocalLocation:[self.controller getCurrentLocation]];
        reusableview = headerView;
    }
    return reusableview;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    float cellWidth = (screenWidth- 6 * 1.f) / 4.0;
    CGSize size = CGSizeMake(cellWidth, cellWidth);
    
    return size;
}

@end
