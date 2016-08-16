//
//  SneakGameTests.m
//  SneakGameTests
//
//  Created by willard on 2016/8/16.
//  Copyright © 2016年 willard. All rights reserved.
//

#import "WLSnake.h"
#import <XCTest/XCTest.h>

@interface WLSnakeTests : XCTestCase {
    WLSnake *snake;
}
@end

@implementation WLSnakeTests

- (void)setUp {
    [super setUp];

    snake = [[WLSnake alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testMove {
    [self initPoints:@[ @[ @3, @4 ], @[ @4, @4 ], @[ @4, @5 ] ]];

    NSArray<WLPoint *> *previousPoints = [snake.points copy];
    [snake moveByDirection:WLMoveDirectionLeft];
    NSArray<WLPoint *> *currentPoints = [snake.points copy];

    XCTAssertEqual([previousPoints count], [currentPoints count]);

    XCTAssertEqual(currentPoints[0].x, 2);
    XCTAssertEqual(currentPoints[0].y, 4);

    XCTAssertTrue([currentPoints[1] isEqual:previousPoints[0]]);
    XCTAssertTrue([currentPoints[2] isEqual:previousPoints[1]]);
}

- (void)testGrowUp {
    [self initPoints:@[ @[ @3, @4 ], @[ @4, @4 ], @[ @4, @5 ] ]];

    NSArray<WLPoint *> *previousPoints = [snake.points copy];
    [snake growUp];
    NSArray<WLPoint *> *currentPoints = [snake.points copy];

    XCTAssertEqual([previousPoints count] + 1, [currentPoints count]);
    [previousPoints enumerateObjectsUsingBlock:^(WLPoint *_Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
      XCTAssertTrue([obj isEqual:currentPoints[idx]]);
    }];

    WLPoint *tail = [currentPoints lastObject];
    XCTAssertEqual(tail.x, 4);
    XCTAssertEqual(tail.y, 6);
}

- (void)testHeadIsTouchBody {
    [self initPoints:@[ @[ @3, @4 ], @[ @4, @4 ], @[ @4, @5 ] ]];
    XCTAssertFalse([snake headIsTouchBody]);

    [self initPoints:@[ @[ @4, @6 ], @[ @4, @4 ], @[ @4, @5 ] ]];
    XCTAssertFalse([snake headIsTouchBody]);

    [self initPoints:@[ @[ @4, @4 ], @[ @4, @4 ], @[ @4, @5 ] ]];
    XCTAssertTrue([snake headIsTouchBody]);

    [self initPoints:@[ @[ @4, @5 ], @[ @4, @4 ], @[ @4, @5 ] ]];
    XCTAssertTrue([snake headIsTouchBody]);
}

- (void)testHeadIsTouchPoint {
    [self initPoints:@[ @[ @3, @4 ], @[ @4, @4 ], @[ @4, @5 ] ]];
    WLPoint *point = [[WLPoint alloc] initWithX:3 y:4];
    XCTAssertTrue([snake headIsTouchPoint:point]);

    WLPoint *point2 = [[WLPoint alloc] initWithX:4 y:4];
    XCTAssertFalse([snake headIsTouchPoint:point2]);

    WLPoint *point3 = [[WLPoint alloc] initWithX:2 y:4];
    XCTAssertFalse([snake headIsTouchPoint:point3]);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)initPoints:(NSArray<NSArray<NSNumber *> *> *)pointsArray {
    snake.points = [NSMutableArray array];

    for (NSArray<NSNumber *> *pointData in pointsArray) {
        WLPoint *point = [[WLPoint alloc] initWithX:[pointData[0] integerValue] y:[pointData[1] integerValue]];
        [snake.points addObject:point];
    }
}

@end
