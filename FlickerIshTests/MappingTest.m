//
//  MappingTest.m
//  FlickerIsh
//
//  Created by Simon Wicha on 5/01/2017.
//  Copyright © 2017 nomis development. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FlickrDataSource.h"

@interface FlickrDataSource(UnitTests)
+ (NSMutableArray *)processFlickrPhotosResponse:(NSDictionary *)dictionary;
@end

@interface MappingTest : XCTestCase

@end

@implementation MappingTest

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testObjectMapping {
    NSDictionary *flickrResponse = [self loadJsonFileWithName:@"flickrSearchResponse"];
    NSArray<FlickrPhoto*> *processedResponse = [FlickrDataSource processFlickrPhotosResponse:flickrResponse];
    FlickrPhoto *firstElement = [processedResponse firstObject];
    XCTAssertNotNil(firstElement);
    XCTAssertEqualObjects(firstElement.title, @"Day 2 is a wrap, already having a good time here at @mesosphere :)");
    XCTAssertEqualObjects(firstElement.owner, @"64684255@N00");
    XCTAssertEqualObjects(firstElement.photoId, @31736017590);
    XCTAssertEqualObjects(firstElement.secret, @"809844A52f");
    XCTAssertEqualObjects(firstElement.server, @302);
    XCTAssertEqualObjects(firstElement.farm, @1);
    XCTAssertEqualObjects(firstElement.isPublic, @1);
    XCTAssertEqualObjects(firstElement.isFamily, @0);
    XCTAssertEqualObjects(firstElement.isFriend, @0);
    XCTAssertEqualObjects(firstElement.imageURL, @"http://farm1.static.flickr.com/302/31736017590_809844A52f.jpg");
    XCTAssertEqualObjects(firstElement.thumbnailURL, @"http://farm1.static.flickr.com/302/31736017590_809844A52f_t.jpg");
}

- (NSDictionary *)loadJsonFileWithName:(NSString *)fileName {
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    
    NSString *filePath = [bundle pathForResource:fileName ofType:@"json"];
    NSURL *localFileURL = [NSURL fileURLWithPath:filePath];
    NSData *contentOfLocalFile = [NSData dataWithContentsOfURL:localFileURL];
    NSError *error = nil;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:contentOfLocalFile options:kNilOptions error:&error];
    
    return json;
}

@end
