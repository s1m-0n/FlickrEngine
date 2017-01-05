//
//  FlickrPhoto.m
//  FlickerIsh
//
//  Created by Simon Wicha on 28/12/2016.
//  Copyright © 2016 nomis development. All rights reserved.
//

#import "FlickrPhoto.h"
#import "NSDateFormatter+Additions.h"

@interface FlickrPhoto ()

@property (strong, nonatomic) NSString *photoId;
@property (strong, nonatomic) NSString *owner;
@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *secret;
@property (strong, nonatomic) NSString *server;
@property (strong, nonatomic) NSString *farm;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSDate *date;
@property (strong, nonatomic) NSNumber *isPublic;
@property (strong, nonatomic) NSNumber *isFriend;
@property (strong, nonatomic) NSNumber *isFamily;
@property (strong, nonatomic) NSString *imageURL;
@property (strong, nonatomic) NSString *thumbnailURL;
@property (strong, nonatomic) NSNumber *latitude;
@property (strong, nonatomic) NSNumber *longitude;
@property (strong, nonatomic) NSArray *tags;

@end

@implementation FlickrPhoto

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        _photoId = dictionary[@"id"];
        _owner = dictionary[@"owner"];
        _secret = dictionary[@"secret"];
        _server = dictionary[@"server"];
        _farm = dictionary[@"farm"];
        _title = dictionary[@"title"];
        _isPublic = @([dictionary[@"ispublic"] integerValue]);
        _isFriend = @([dictionary[@"isfriend"] integerValue]);
        _isFamily = @([dictionary[@"isFamily"] integerValue]);
        _imageURL = [NSString stringWithFormat:@"http://farm%@.static.flickr.com/%@/%@_%@.jpg", _farm, _server, _photoId, _secret];
        _thumbnailURL = [NSString stringWithFormat:@"http://farm%@.static.flickr.com/%@/%@_%@_t.jpg", _farm, _server, _photoId, _secret];
    }
    return self;
}

- (void)updateObjectFromInfoEndpointWithDictionary:(NSDictionary *)dictionary {
    _date = [[NSDateFormatter longDateFormatter] dateFromString:dictionary[@"photo"][@"dates"][@"taken"]];
    _username = dictionary[@"photo"][@"owner"][@"username"];
    _latitude = dictionary[@"photo"][@"location"][@"latitude"];
    _longitude = dictionary[@"photo"][@"location"][@"longitude"];
    _tags = dictionary[@"photo"][@"tags"][@"tag"];
}

@end
