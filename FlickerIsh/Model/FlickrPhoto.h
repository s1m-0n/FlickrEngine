//
//  FlickrPhoto.h
//  FlickerIsh
//
//  Created by Simon Wicha on 28/12/2016.
//  Copyright © 2016 nomis development. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FlickrPhoto : NSObject

@property (strong, nonatomic, readonly) NSString *photoId;
@property (strong, nonatomic, readonly) NSString *owner;
@property (strong, nonatomic, readonly) NSString *username;
@property (strong, nonatomic, readonly) NSString *secret;
@property (strong, nonatomic, readonly) NSString *server;
@property (strong, nonatomic, readonly) NSString *farm;
@property (strong, nonatomic, readonly) NSString *title;
@property (strong, nonatomic, readonly) NSDate *date;
@property (strong, nonatomic, readonly) NSNumber *isPublic;
@property (strong, nonatomic, readonly) NSNumber *isFriend;
@property (strong, nonatomic, readonly) NSNumber *isFamily;
@property (strong, nonatomic, readonly) NSString *imageURL;
@property (strong, nonatomic, readonly) NSString *thumbnailURL;
@property (strong, nonatomic) UIImage *thumbnail;
@property (strong, nonatomic, readonly) NSNumber *latitude;
@property (strong, nonatomic, readonly) NSNumber *longitude;
@property (strong, nonatomic, readonly) NSArray *tags;

- (id)initWithDictionary:(NSDictionary *)dictionary;
- (void)updateObjectFromInfoEndpointWithDictionary:(NSDictionary *)dictionary;

@end
