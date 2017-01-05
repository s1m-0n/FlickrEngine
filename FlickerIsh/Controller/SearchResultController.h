//
//  SearchResultController.h
//  FlickerIsh
//
//  Created by Simon Wicha on 28/12/16.
//  Copyright © 2016 nomis development. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SearchResultControllerDelegate <NSObject>

- (void)reloadTable;
- (void)showAvailableTags;

@end

@interface SearchResultController : NSObject

@property (assign, nonatomic) id<SearchResultControllerDelegate> delegate;
@property (strong, nonatomic) NSArray *flickrPhotoArray;
@property (strong, nonatomic) NSMutableArray *availableTagsArray;
@property (strong, nonatomic) NSString *searchTerm;

- (void)searchFlickrBySearchTerm:(NSString *)searchTerm;

@end
