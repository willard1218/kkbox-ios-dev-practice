//
//  WLNetworkFetcher.h
//  Block
//
//  Created by willard on 2016/9/4.
//  Copyright © 2016年 willard. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UIImage;
@protocol WLNetworkFetcherDelegate <NSObject>
- (void)didFetchGetResponseWithDictionary:(NSDictionary *)dict
                                    error:(NSError *)error;
- (void)didPostCustomerNameWithDictionary:(NSDictionary *)dict
                                    error:(NSError *)error;
- (void)didFetchImageWithUIImage:(UIImage *)image error:(NSError *)error;

@end

static const NSString *kGetURL = @"http://httpbin.org/get";
static const NSString *kPostURL = @"http://httpbin.org/post";
static const NSString *kImageURL = @"http://httpbin.org/image/png";

@interface WLNetworkFetcher : NSObject
@property(nonatomic, weak) id<WLNetworkFetcherDelegate> delegate;
- (void)fetchGetResponse;
- (void)postCustomerName:(NSString *)name;
- (void)fetchImage;
@end
