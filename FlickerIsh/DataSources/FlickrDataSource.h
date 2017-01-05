//
//  FlickrDataSource.h
//  FlickerIsh
//
//  Created by Simon Wicha on 24/12/16.
//  Copyright © 2016 nomis development. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FlickrPhoto.h"

@interface FlickrDataSource : NSObject

+ (void)retrieveFlickrPhotosWithSearchTerm:(NSString * _Nonnull)searchTerm withCompletionHandler:(void (^ _Nonnull)(NSArray * _Nullable array, NSError * _Nullable error))completion;

+ (void)retrieveInfosForFlickrPhoto:(FlickrPhoto * _Nonnull)flickrPhoto withCompletionHandler:(void (^ _Nullable)(FlickrPhoto * _Nullable flickrPhoto, NSError * _Nullable error))completion;

+ (void)retrieveExifForFlickrPhoto:(FlickrPhoto * _Nonnull)flickrPhoto withCompletionHandler:(void (^ _Nonnull)(NSDictionary * _Nullable dictionary, NSError * _Nullable error))completion;

+ (void)retrieveFlickrPhotosWithLat:(double)lat andLon:(double)lon withCompletionHandler:(void (^ _Nonnull)(NSArray * _Nullable array, NSError * _Nullable error))completion;

+ (void)downloadFlickrPhotoImage:(FlickrPhoto * _Nonnull) flickrPhoto WithCompletion:(void (^ _Nonnull)(BOOL succeeded, UIImage * _Nullable image))completionBlock;

@end
