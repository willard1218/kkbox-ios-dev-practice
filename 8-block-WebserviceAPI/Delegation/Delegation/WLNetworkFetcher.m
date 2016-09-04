//
//  WLNetworkFetcher.m
//  Block
//
//  Created by willard on 2016/9/4.
//  Copyright © 2016年 willard. All rights reserved.
//

#import "WLNetworkFetcher.h"
#import <UIKit/UIKit.h>
@implementation WLNetworkFetcher {
  NSURLSessionDataTask *sessionDataTask;
}

- (void)fetchGetResponse {
  [sessionDataTask cancel];
  NSURL *url = [NSURL URLWithString:kGetURL];

  NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];

  request.HTTPMethod = @"get";
  NSURLSession *session = [NSURLSession sharedSession];

  sessionDataTask = [session
      dataTaskWithRequest:request
        completionHandler:^(NSData *_Nullable data,
                            NSURLResponse *_Nullable response,
                            NSError *_Nullable error) {

          NSDictionary *dictionary =
              [NSJSONSerialization JSONObjectWithData:data
                                              options:kNilOptions
                                                error:nil];
          if (_delegate &&
              [_delegate
                  respondsToSelector:@selector(
                                         didFetchGetResponseWithDictionary:
                                                                     error:)]) {
            [_delegate didFetchGetResponseWithDictionary:dictionary
                                                   error:error];
          }
        }];

  [sessionDataTask resume];
}

- (void)postCustomerName:(NSString *)name {
  [sessionDataTask cancel];
  NSURL *url = [NSURL URLWithString:kPostURL];

  NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];

  request.HTTPMethod = @"post";
  request.HTTPBody = [NSKeyedArchiver archivedDataWithRootObject:@{
    @"custname" : name
  }];
  NSURLSession *session = [NSURLSession sharedSession];

  sessionDataTask = [session
      dataTaskWithRequest:request
        completionHandler:^(NSData *_Nullable data,
                            NSURLResponse *_Nullable response,
                            NSError *_Nullable error) {

          NSDictionary *dictionary =
              [NSJSONSerialization JSONObjectWithData:data
                                              options:kNilOptions
                                                error:nil];
          if (_delegate &&
              [_delegate
                  respondsToSelector:@selector(
                                         didPostCustomerNameWithDictionary:
                                                                     error:)]) {
            [_delegate didPostCustomerNameWithDictionary:dictionary
                                                   error:error];
          }
        }];

  [sessionDataTask resume];
}

- (void)fetchImage {
  [sessionDataTask cancel];
  NSURL *url = [NSURL URLWithString:kImageURL];

  NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];

  request.HTTPMethod = @"get";

  NSURLSession *session = [NSURLSession sharedSession];

  sessionDataTask = [session
      dataTaskWithRequest:request
        completionHandler:^(NSData *_Nullable data,
                            NSURLResponse *_Nullable response,
                            NSError *_Nullable error) {

          UIImage *image = [[UIImage alloc] initWithData:data];
          if (_delegate &&
              [_delegate
                  respondsToSelector:@selector(didFetchImageWithUIImage:
                                                                  error:)]) {
            [_delegate didFetchImageWithUIImage:image error:error];
          }
        }];

  [sessionDataTask resume];
}
@end
