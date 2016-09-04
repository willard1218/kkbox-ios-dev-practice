//
//  BlockTests.m
//  BlockTests
//
//  Created by willard on 2016/9/4.
//  Copyright © 2016年 willard. All rights reserved.
//

#import "WLNetworkFetcher.h"
#import <XCTest/XCTest.h>
@interface BlockTests : XCTestCase {
  WLNetworkFetcher *networkFetcher;
}

@end

@implementation BlockTests

- (void)setUp {
  [super setUp];
  networkFetcher = [[WLNetworkFetcher alloc] init];
}

- (void)tearDown {
  networkFetcher = nil;
  [super tearDown];
}

- (void)testGet {
  XCTestExpectation *expectation = [self expectationWithDescription:@"get"];
  WLResponseBlock responseBlock = ^(NSDictionary *dict, NSError *error) {
    XCTAssertNotNil(dict, "data should not be nil");
    XCTAssertNil(error, "error should be nil");
    XCTAssertTrue([dict isKindOfClass:NSDictionary.class]);
    XCTAssertTrue([dict[@"url"] isEqualToString:kGetURL]);
    [expectation fulfill];
  };

  [networkFetcher fetchGetResponseWithCallback:responseBlock];

  [self waitForExpectationsWithTimeout:10
                               handler:^(NSError *error) {
                                 XCTAssertNil(error);
                               }];
}

- (void)testPost {
  XCTestExpectation *expectation = [self expectationWithDescription:@"post"];
  WLResponseBlock responseBlock = ^(NSDictionary *dict, NSError *error) {
    XCTAssertNotNil(dict, "data should not be nil");
    XCTAssertNil(error, "error should be nil");
    XCTAssertTrue([dict isKindOfClass:NSDictionary.class]);
    XCTAssertTrue([dict[@"url"] isEqualToString:kPostURL]);
    [expectation fulfill];
  };

  [networkFetcher postCustomerName:@"willard" callback:responseBlock];

  [self waitForExpectationsWithTimeout:10
                               handler:^(NSError *error) {
                                 XCTAssertNil(error);
                               }];
}

- (void)testGetImage {
  XCTestExpectation *expectation = [self expectationWithDescription:@"get image"];
  WLResponseImageBlock responseBlock = ^(UIImage *image, NSError *error) {
    XCTAssertNotNil(image, "image should not be nil");
    XCTAssertNil(error, "error should be nil");
    XCTAssertTrue([image isKindOfClass:UIImage.class]);
    [expectation fulfill];
  };

  [networkFetcher fetchImageWithCallback:responseBlock];

  [self waitForExpectationsWithTimeout:10
                               handler:^(NSError *error) {
                                 XCTAssertNil(error);
                               }];
}

@end
