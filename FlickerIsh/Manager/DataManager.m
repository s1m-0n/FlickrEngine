//
//  DataManager.m
//  FlickerIsh
//
//  Created by Simon Wicha on 24/12/16.
//  Copyright © 2016 nomis development. All rights reserved.
//

#import "DataManager.h"
#import <UIKit/UIKit.h>
#import "FlickrPhoto.h"

@implementation DataManager

+ (id)sharedManager {
    static DataManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [self new];
    });
    return sharedManager;
}

- (void)GETRequestWithURLString:(NSString *)URLString withCompletionHandler:(void (^)(NSDictionary * _Nullable dictionary, NSURLResponse * _Nullable response, NSError * _Nullable error))completion {
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString: URLString]];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[UIDevice currentDevice].name forHTTPHeaderField:@"device"];
    [request setTimeoutInterval:15];
    
    NSURLSession *session;
    session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSURLSessionDataTask * sessionDataTask = [session dataTaskWithRequest: request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", error);
            completion(nil, response, error);
        } else {
            NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            completion(dataDictionary, response, error);
        }
    }];
    [sessionDataTask resume];
}

- (void)downloadImageWithURL:(NSURL *)url WithCompletion:(void (^)(BOOL succeeded, NSData *data))completionBlock {
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:url
            completionHandler:^(NSData *data,
                                NSURLResponse *response,
                                NSError *error) {
                if (!error) {
                    completionBlock(YES, data);
                } else
                    completionBlock(NO, nil);
                
            }] resume];
}



@end
