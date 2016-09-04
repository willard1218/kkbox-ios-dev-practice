//
//  DelegationTests.m
//  DelegationTests
//
//  Created by willard on 2016/9/4.
//  Copyright © 2016年 willard. All rights reserved.
//

#import "WLNetworkFetcher.h"
#import <XCTest/XCTest.h>

@interface DelegationTests : XCTestCase <WLNetworkFetcherDelegate> {
  WLNetworkFetcher *networkFetcher;
  XCTestExpectation *expectation;
}

@end

@implementation DelegationTests

- (void)setUp {
  [super setUp];
  networkFetcher = [[WLNetworkFetcher alloc] init];
  networkFetcher.delegate = self;
  expectation = [self expectationWithDescription:@"http"];
}

- (void)tearDown {
  networkFetcher = nil;
  [super tearDown];
}

- (void)testGet {
  [networkFetcher fetchGetResponse];
  [self waitForExpectationsWithTimeout:10
                               handler:^(NSError *error) {
                                 XCTAssertNil(error);
                               }];
}

- (void)testPost {
  [networkFetcher postCustomerName:@"willard"];
  [self waitForExpectationsWithTimeout:10
                               handler:^(NSError *error) {
                                 XCTAssertNil(error);
                               }];
}

- (void)testGetImage {
  [networkFetcher fetchImage];
  [self waitForExpectationsWithTimeout:10
                               handler:^(NSError *error) {
                                 XCTAssertNil(error);
                               }];
}

- (void)didFetchGetResponseWithDictionary:(NSDictionary *)dict
                                    error:(NSError *)error {
  XCTAssertNotNil(dict, "data should not be nil");
  XCTAssertNil(error, "error should be nil");
  XCTAssertTrue([dict isKindOfClass:NSDictionary.class]);
  XCTAssertTrue([dict[@"url"] isEqualToString:kGetURL]);
  [expectation fulfill];
}

- (void)didPostCustomerNameWithDictionary:(NSDictionary *)dict
                                    error:(NSError *)error {
  XCTAssertNotNil(dict, "data should not be nil");
  XCTAssertNil(error, "error should be nil");
  XCTAssertTrue([dict isKindOfClass:NSDictionary.class]);
  XCTAssertTrue([dict[@"url"] isEqualToString:kPostURL]);
  [expectation fulfill];
}

- (void)didFetchImageWithUIImage:(UIImage *)image error:(NSError *)error {
  XCTAssertNotNil(image, "image should not be nil");
  XCTAssertNil(error, "error should be nil");
  XCTAssertTrue([image isKindOfClass:UIImage.class]);
  [expectation fulfill];
}
@end
