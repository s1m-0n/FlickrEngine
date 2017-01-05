//
//  DataManager.h
//  FlickerIsh
//
//  Created by Simon Wicha on 24/12/16.
//  Copyright © 2016 nomis development. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataManager : NSObject

+ (id _Nullable)sharedManager;
- (void)GETRequestWithURLString:(NSString * _Nullable)URLString withCompletionHandler:(void (^ _Nullable)(NSDictionary * _Nullable dictionary, NSURLResponse * _Nullable response, NSError * _Nullable error))completion;
- (void)downloadImageWithURL:(NSURL * _Nullable)url WithCompletion:(void (^ _Nullable)(BOOL succeeded, NSData * _Nullable data))completionBlock;

@end
