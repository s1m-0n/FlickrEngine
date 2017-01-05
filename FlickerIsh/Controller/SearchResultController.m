//
//  SearchResultController.m
//  FlickerIsh
//
//  Created by Simon Wicha on 28/12/16.
//  Copyright © 2016 nomis development. All rights reserved.
//

#import "SearchResultController.h"
#import "FlickrDataSource.h"

@interface SearchResultController ()

@property (strong, nonatomic) NSMutableDictionary *tagsDictionary;
@property (strong, nonatomic) NSMutableArray *flickrPhotosWithInfoArray;

@end

@implementation SearchResultController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.tagsDictionary = [NSMutableDictionary new];
    }
    return self;
}

- (void)searchFlickrBySearchTerm:(NSString *)searchTerm {
    self.searchTerm = searchTerm;
    [FlickrDataSource retrieveFlickrPhotosWithSearchTerm:searchTerm withCompletionHandler:^(NSArray * _Nullable array, NSError * _Nullable error) {
        self.flickrPhotoArray = array;
        [self.delegate reloadTable];
        self.flickrPhotosWithInfoArray = [NSMutableArray new];
        [self.flickrPhotoArray enumerateObjectsUsingBlock:^(FlickrPhoto *photo, NSUInteger idx, BOOL * _Nonnull stop) {
            [FlickrDataSource retrieveInfosForFlickrPhoto:photo withCompletionHandler:^(FlickrPhoto * _Nullable flickrPhoto, NSError * _Nullable error) {
                [self.flickrPhotosWithInfoArray addObject:flickrPhoto];
                if (self.flickrPhotosWithInfoArray.count == self.flickrPhotoArray.count) {
                    [self processTags];
                }
            }];
        }];
    }];
}

- (void)processTags {
    self.availableTagsArray = [NSMutableArray new];
    for (FlickrPhoto * flickrPhoto in self.flickrPhotosWithInfoArray) {
        for (NSDictionary *dict in flickrPhoto.tags) {
            if (![self.availableTagsArray containsObject:dict]) {
                [self.availableTagsArray addObject:dict];
            }
        }
    }
    [self.delegate showAvailableTags];
}

@end
