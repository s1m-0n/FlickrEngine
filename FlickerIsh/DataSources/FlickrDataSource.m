//
//  FlickrDataSource.m
//  FlickerIsh
//
//  Created by Simon Wicha on 24/12/16.
//  Copyright © 2016 nomis development. All rights reserved.
//

#import "FlickrDataSource.h"
#import "Constants.h"
#import "DataManager.h"

@implementation FlickrDataSource

+ (void)retrieveFlickrPhotosWithSearchTerm:(NSString *)searchTerm withCompletionHandler:(void (^)(NSArray * _Nullable array, NSError * _Nullable error))completion {
    [[DataManager sharedManager] GETRequestWithURLString:[self URLForSearchString:searchTerm] withCompletionHandler:^(NSDictionary * _Nullable dictionary, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            completion([self processFlickrPhotosResponse:dictionary], nil);
        } else
            completion(nil, error);
    }];
}

+ (NSString *)URLForSearchString:(NSString *)searchString {
    NSString *search = [searchString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    return [NSString stringWithFormat:@"%@/?method=flickr.photos.search&api_key=%@&tags=%@&per_page=25&format=json&nojsoncallback=1", flickrBaseURL, flickrAPIKey, search];
}

#pragma mark - flickr.photos.getInfo

+ (void)retrieveInfosForFlickrPhoto:(FlickrPhoto *)flickrPhoto withCompletionHandler:(void (^)(FlickrPhoto * _Nullable flickrPhoto, NSError * _Nullable error))completion {
    [[DataManager sharedManager] GETRequestWithURLString:[self URLForGetFlickrPhotoInfo:flickrPhoto.photoId] withCompletionHandler:^(NSDictionary * _Nullable dictionary, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        completion([self processInfosForFlickrPhoto:flickrPhoto withResponse:dictionary], error);
    }];
}

+ (NSString *)URLForGetFlickrPhotoInfo:(NSString *)photoId {
    return [NSString stringWithFormat:@"%@/?method=flickr.photos.getInfo&api_key=%@&photo_id=%@&format=json&nojsoncallback=1", flickrBaseURL, flickrAPIKey, photoId];
}

+ (FlickrPhoto *)processInfosForFlickrPhoto:(FlickrPhoto *)flickrPhoto withResponse:(NSDictionary *)dictionary {
    [flickrPhoto updateObjectFromInfoEndpointWithDictionary:dictionary];
    return flickrPhoto;
}

#pragma mark - flickr.photos.getExif

+ (void)retrieveExifForFlickrPhoto:(FlickrPhoto *)flickrPhoto withCompletionHandler:(void (^)(NSDictionary * _Nullable dictionary, NSError * _Nullable error))completion {
    [[DataManager sharedManager] GETRequestWithURLString:[self URLForGetExifFlickrPhotoInfo:flickrPhoto.photoId] withCompletionHandler:^(NSDictionary * _Nullable dictionary, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        completion(dictionary, error);
    }];
}

+ (NSString *)URLForGetExifFlickrPhotoInfo:(NSString *)photoId {
    return [NSString stringWithFormat:@"%@/?method=flickr.photos.getExif&api_key=%@&photo_id=%@&format=json&nojsoncallback=1", flickrBaseURL, flickrAPIKey, photoId];
}

#pragma mark - Retrieve FlickrPhotos with Location

+ (void)retrieveFlickrPhotosWithLat:(double)lat andLon:(double)lon withCompletionHandler:(void (^)(NSArray * _Nullable array, NSError * _Nullable error))completion {
    [[DataManager sharedManager] GETRequestWithURLString:[self URLForLocationSearchWithLat:[NSString stringWithFormat:@"%f", lat] andLon:[NSString stringWithFormat:@"%f", lon]] withCompletionHandler:^(NSDictionary * _Nullable dictionary, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            completion([self processFlickrPhotosResponse:dictionary], nil);
        } else
            completion(nil, error);
    }];
}

+ (NSString *)URLForLocationSearchWithLat:(NSString *)lat andLon:(NSString *)lon{
    return [NSString stringWithFormat:@"%@/?method=flickr.photos.search&api_key=%@&lat=%@&lon=%@&format=json&nojsoncallback=1", flickrBaseURL, flickrAPIKey, lat, lon];
}

+ (NSMutableArray *)processFlickrPhotosResponse:(NSDictionary *)dictionary {
    NSMutableArray *processedArray = [NSMutableArray new];
    NSArray *photoArray = dictionary[@"photos"][@"photo"];
    for (NSDictionary *dict in photoArray) {
        FlickrPhoto *flickrPhoto = [[FlickrPhoto alloc] initWithDictionary:dict];
        [processedArray addObject:flickrPhoto];
    }
    return processedArray;
}

#pragma mark - Download Image

+ (void)downloadFlickrPhotoImage:(FlickrPhoto *) flickrPhoto WithCompletion:(void (^)(BOOL succeeded, UIImage *image))completionBlock {
    [[DataManager sharedManager] downloadImageWithURL:[NSURL URLWithString:flickrPhoto.thumbnailURL] WithCompletion:^(BOOL succeeded, NSData *data) {
        if (succeeded) {
            completionBlock(YES, [UIImage imageWithData:data]);
        } else
            completionBlock(NO, nil);
    }];
}

@end
