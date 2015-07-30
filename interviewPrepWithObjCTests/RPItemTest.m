#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "RPItem.h"

@interface FizzBuzzItem : RPItem

@end

@implementation FizzBuzzItem

- (NSMutableArray *)printFizzBuzzForFirstNumber:(NSInteger)number LastNumber:(NSInteger)end withArray:(NSMutableArray *)results {
    [super printFizzBuzzForFirstNumber:number withLastNumber:end withArray:results];
    return results;
}

@end

@interface RPItemTest : XCTestCase
@property (nonatomic) FizzBuzzItem *item;
@end

@implementation RPItemTest

- (void)setUp {
    [super setUp];
    _item = [[FizzBuzzItem alloc] init];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testFizzBuzzDoesNotGoOutOfBounds {
    NSMutableArray *results = [[NSMutableArray alloc] init];
    results = [self.item printFizzBuzzForFirstNumber:1 LastNumber:100 withArray:(NSMutableArray *)results];
    XCTAssertLessThan(results.count, 101);
}

- (void)testFizzBuzzReturnsFizz {
    NSMutableArray *results = [[NSMutableArray alloc] init];
    results = [self.item printFizzBuzzForFirstNumber:1 LastNumber:15 withArray:(NSMutableArray *)results];
    XCTAssertEqualObjects(@"Fizz", results[2]);
    XCTAssertEqualObjects(@"Fizz", results[5]);
    XCTAssertEqualObjects(@"Fizz", results[8]);
}

- (void)testFizzBuzzReturnsBuzz {
    NSMutableArray *results = [[NSMutableArray alloc] init];
    results = [self.item printFizzBuzzForFirstNumber:1 LastNumber:15 withArray:(NSMutableArray *)results];
    XCTAssertEqualObjects(@"Buzz", results[4]);
    XCTAssertEqualObjects(@"Buzz", results[9]);
    XCTAssertNotEqualObjects(@"Buzz", results[14]);
}

- (void)testFizzBuzzReturnsFizzBuzz {
    NSMutableArray *results = [[NSMutableArray alloc] init];
    results = [self.item printFizzBuzzForFirstNumber:1 LastNumber:30 withArray:(NSMutableArray *)results];
    XCTAssertEqualObjects(@"FizzBuzz", results[14]);
    XCTAssertEqualObjects(@"FizzBuzz", results[29]);
}

@end
