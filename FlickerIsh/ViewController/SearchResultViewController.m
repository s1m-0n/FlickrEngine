//
//  SearchResultViewController.m
//  FlickerIsh
//
//  Created by Simon Wicha on 28/12/16.
//  Copyright © 2016 nomis development. All rights reserved.
//

#import "SearchResultViewController.h"
#import "SearchResultController.h"
#import "SearchResultTableViewCell.h"
#import "FlickrTagCollectionViewCell.h"
#import "FlickrPhotoDetailViewController.h"
#import "UIStoryboard+Additions.h"

@interface SearchResultViewController () <SearchResultControllerDelegate, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, FlickrTagCollectionViewCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) SearchResultController *controller;
@property (weak, nonatomic) IBOutlet UICollectionView *tagCollectionView;
@property (weak, nonatomic) IBOutlet UILabel *tagSearchLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tagSearchHeightConstraint;
@property (weak, nonatomic) IBOutlet UIVisualEffectView *loadingIndicatorView;

@end

@implementation SearchResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.controller = [SearchResultController new];
    self.controller.delegate = self;
    self.searchBar.delegate = self;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 60.f;
    self.tagCollectionView.delegate = self;
    self.tagCollectionView.dataSource = self;
    self.tagSearchLabel.hidden = YES;
    self.tagSearchHeightConstraint.constant = 0.f;
    [self setupLoadingIndicator];
}

- (void)setupLoadingIndicator {
    self.loadingIndicatorView.layer.cornerRadius = 5.f;
    self.loadingIndicatorView.clipsToBounds = YES;
    self.loadingIndicatorView.hidden = YES;
}

#pragma mark - UITableViewDelegate methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SearchResultTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchResultTableViewCellID"];
    [cell configureFlickrPhotoCell:self.controller.flickrPhotoArray[indexPath.row] WithCompletion:^(BOOL succeeded, UIImage *image) {
        if (succeeded) {
            dispatch_async(dispatch_get_main_queue(), ^{
                FlickrPhoto *flickrPhoto = self.controller.flickrPhotoArray[indexPath.row];
                flickrPhoto.thumbnail = image;
                cell.thumpnailImageView.image = image;
            });
        }
    }];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.controller.flickrPhotoArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    FlickrPhotoDetailViewController *flickrDetailVC = [[UIStoryboard getMainStoryboard] instantiateViewControllerWithIdentifier:@"FlickrPhotoDetailViewController"];
    [flickrDetailVC setController:[FlickrPhotoDetailController new] withFlickrPhoto:self.controller.flickrPhotoArray[indexPath.row]];
    [self presentViewController:flickrDetailVC animated:YES completion:nil];
}
#pragma mark - SearchBarDelegate methods

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self.controller searchFlickrBySearchTerm:searchBar.text];
    self.loadingIndicatorView.hidden = NO;
    self.tagSearchHeightConstraint.constant = 0.f;
    [UIView animateWithDuration:0.3f animations:^{
        [self.view layoutIfNeeded];
    }];
    [searchBar resignFirstResponder];
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
    return YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self stopSearching];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

#pragma mark - CollectionView data source

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FlickrTagCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FlickrTagCollectionViewCellID" forIndexPath:indexPath];
    cell.delegate = self;
    [cell.tagButton setTitle:self.controller.availableTagsArray[indexPath.row][@"raw"] forState:UIControlStateNormal];
    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.controller.availableTagsArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CGSize textSize = [(NSString*)[self.controller.availableTagsArray objectAtIndex:indexPath.row][@"raw"] sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.f]}];
    
    return CGSizeMake(textSize.width + 70, 30);
}

#pragma mark - FlickrTagCollectionViewCell delegate

- (void)tagButtonPressedWithTag:(NSString *)tag {
    self.searchBar.text = tag;
    [self.searchBar becomeFirstResponder];
}


#pragma mark - Utils

- (void)stopSearching {
    [self.searchBar resignFirstResponder];
    self.searchBar.text = nil;
    self.searchBar.showsCancelButton = NO;
    [self.tableView reloadData];
}

#pragma mark - SearchResultControllerDelegate methods

- (void)reloadTable {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.loadingIndicatorView.hidden = YES;
        [self.tableView setContentOffset:CGPointZero animated:YES];
        [self.tableView reloadData];
    });
}

- (void)showAvailableTags {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tagCollectionView setContentOffset:CGPointZero animated:NO];
        [self.tagCollectionView reloadData];
        self.tagSearchLabel.hidden = NO;
        self.tagSearchLabel.text = [NSString stringWithFormat:@"%lu Tags found for '%@'", (unsigned long)self.controller.availableTagsArray.count, self.controller.searchTerm];
        self.tagSearchHeightConstraint.constant = 70.f;
        [UIView animateWithDuration:0.3f animations:^{
            [self.view layoutIfNeeded];
        }];
        [self.tagCollectionView.collectionViewLayout invalidateLayout];
    });
}

@end
