//
//  WLNetworkFetcher.m
//  Block
//
//  Created by willard on 2016/9/4.
//  Copyright © 2016年 willard. All rights reserved.
//

#import "WLNetworkFetcher.h"
#import <UIKit/UIKit.h>
@implementation WLNetworkFetcher
- (void)fetchGetResponseWithCallback:(WLResponseBlock)callback {
  NSURL *url = [NSURL URLWithString:kGetURL];

  NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];

  request.HTTPMethod = @"get";
  NSURLSession *session = [NSURLSession sharedSession];

  NSURLSessionDataTask *sessionDataTask =
      [session dataTaskWithRequest:request
                 completionHandler:^(NSData *_Nullable data,
                                     NSURLResponse *_Nullable response,
                                     NSError *_Nullable error) {

                   NSDictionary *dictionary =
                       [NSJSONSerialization JSONObjectWithData:data
                                                       options:kNilOptions
                                                         error:nil];
                   if (callback) {
                     callback(dictionary, error);
                   }

                 }];

  [sessionDataTask resume];
}

- (void)postCustomerName:(NSString *)name callback:(WLResponseBlock)callback {
  NSURL *url = [NSURL URLWithString:kPostURL];

  NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];

  request.HTTPMethod = @"post";
  request.HTTPBody = [NSKeyedArchiver archivedDataWithRootObject:@{
    @"custname" : name
  }];
  NSURLSession *session = [NSURLSession sharedSession];

  NSURLSessionDataTask *sessionDataTask =
      [session dataTaskWithRequest:request
                 completionHandler:^(NSData *_Nullable data,
                                     NSURLResponse *_Nullable response,
                                     NSError *_Nullable error) {

                   NSDictionary *dictionary =
                       [NSJSONSerialization JSONObjectWithData:data
                                                       options:kNilOptions
                                                         error:nil];
                   if (callback) {
                     callback(dictionary, error);
                   }

                 }];

  [sessionDataTask resume];
}

- (void)fetchImageWithCallback:(WLResponseImageBlock)callback {
  NSURL *url = [NSURL URLWithString:kImageURL];

  NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];

  request.HTTPMethod = @"get";

  NSURLSession *session = [NSURLSession sharedSession];

  NSURLSessionDataTask *sessionDataTask =
      [session dataTaskWithRequest:request
                 completionHandler:^(NSData *_Nullable data,
                                     NSURLResponse *_Nullable response,
                                     NSError *_Nullable error) {

                   UIImage *image = [[UIImage alloc] initWithData:data];
                   if (image) {
                     callback(image, error);
                   }

                 }];

  [sessionDataTask resume];
}
@end
