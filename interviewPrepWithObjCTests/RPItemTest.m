#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "RPItem.h"

@interface RPItemTest : XCTestCase
@property (nonatomic) RPItem *testObject;
@end

@implementation RPItemTest

- (void)setUp {
    [super setUp];
    _testObject = [[RPItem alloc] init];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testFizzBuzzDoesNotGoOutOfBounds {
    NSMutableArray *results = [[NSMutableArray alloc] init];
    results = [self.testObject printFizzBuzzForFirstNumber:1 withLastNumber:100 withArray:results];
    XCTAssertLessThan(results.count, 101);
}

- (void)testFizzBuzzReturnsFizz {
    NSMutableArray *results = [[NSMutableArray alloc] init];
    results = [self.testObject printFizzBuzzForFirstNumber:1 withLastNumber:15 withArray:results];
    XCTAssertEqualObjects(@"Fizz", results[2]);
    XCTAssertEqualObjects(@"Fizz", results[5]);
    XCTAssertEqualObjects(@"Fizz", results[8]);
}

- (void)testFizzBuzzReturnsBuzz {
    NSMutableArray *results = [[NSMutableArray alloc] init];
    results = [self.testObject printFizzBuzzForFirstNumber:1 withLastNumber:15 withArray:results];
    XCTAssertEqualObjects(@"Buzz", results[4]);
    XCTAssertEqualObjects(@"Buzz", results[9]);
    XCTAssertNotEqualObjects(@"Buzz", results[14]);
}

- (void)testFizzBuzzReturnsFizzBuzz {
    NSMutableArray *results = [[NSMutableArray alloc] init];
    results = [self.testObject printFizzBuzzForFirstNumber:1 withLastNumber:30 withArray:results];
    XCTAssertEqualObjects(@"FizzBuzz", results[14]);
    XCTAssertEqualObjects(@"FizzBuzz", results[29]);
}

@end
