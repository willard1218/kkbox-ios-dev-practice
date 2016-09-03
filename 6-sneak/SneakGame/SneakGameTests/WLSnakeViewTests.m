//
//  WLSnakeViewTests.m
//  SneakGame
//
//  Created by willard on 2016/9/3.
//  Copyright © 2016年 willard. All rights reserved.
//

#import "WLSnakeView.h"
#import <XCTest/XCTest.h>
@interface WLSnakeViewTests : XCTestCase {
    WLSnakeView *snakeView;
}

@end

@implementation WLSnakeViewTests

- (void)setUp {
    [super setUp];
    snakeView = [[WLSnakeView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


- (void)testExample {
    
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
