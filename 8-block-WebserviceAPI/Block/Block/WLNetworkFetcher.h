//
//  WLNetworkFetcher.h
//  Block
//
//  Created by willard on 2016/9/4.
//  Copyright © 2016年 willard. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UIImage;
typedef void (^WLResponseBlock)(NSDictionary *, NSError *);
typedef void (^WLResponseImageBlock)(UIImage *, NSError *);

static const NSString *kGetURL = @"http://httpbin.org/get";
static const NSString *kPostURL = @"http://httpbin.org/post";
static const NSString *kImageURL = @"http://httpbin.org/image/png";


@interface WLNetworkFetcher : NSObject
- (void)fetchGetResponseWithCallback:(WLResponseBlock)callback;

- (void)postCustomerName:(NSString *)name callback:(WLResponseBlock)callback;

- (void)fetchImageWithCallback:(WLResponseImageBlock)callback;
@end
