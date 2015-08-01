//
//  RPItem.m
//  interviewPrepWithObjC
//
//  Created by Ryan Pliske on 7/20/15.
//  Copyright (c) 2015 Ryan Pliske. All rights reserved.
//

#import "RPItem.h"

@implementation RPItem

+ (instancetype)randomItem {
    NSArray *randomArrayOfNames = @[@"Fluffy Kittens", @"Lab Puppies", @"Baby Bunnies"];
    NSArray *randomArrayOfSerialNumbers = @[@"1234", @"3214", @"2623"];
    
    RPItem *randomItem = [[RPItem alloc] initWithItemName:randomArrayOfNames[arc4random() % 3] valueInDollars:arc4random() & 100 serialNumber:randomArrayOfSerialNumbers[arc4random() % 3]];
    return randomItem;
}

- (instancetype)initWithItemName:(NSString *)name valueInDollars:(NSInteger)valueInDollars serialNumber:(NSString *)serialNumber {
    self = [super init];
    if (self) {
        _itemName = name;
        _valueInDollars = valueInDollars;
        _serialNumber = serialNumber;
        _dateCreated = [[NSDate alloc] init];
    }
    return self;
}

- (instancetype)initWithItemName:(NSString *)name {
    return [self initWithItemName:name valueInDollars:nil serialNumber:nil];
}

- (instancetype)init {
    return [self initWithItemName: nil];
}

#pragma mark - Setters

- (void)setItemName:(NSString *)itemName {
    _itemName = itemName;
}

- (void)setSerialNumber:(NSString *)serialNumber {
    _serialNumber = serialNumber;
}

- (void)setValueInDollars:(NSInteger)dollarAmt {
    _valueInDollars = dollarAmt;
}

- (void)setDateCreated:(NSDate *)dateCreated {
    _dateCreated = dateCreated;
}

#pragma mark - Getters

- (NSString *)itemName {
    return _itemName;
}

- (NSString *)serialNumber {
    return _serialNumber;
}

- (NSInteger)valueInDollars {
    return _valueInDollars;
}

- (NSDate *)dateCreated {
    return _dateCreated;
}

- (NSString *)description {
    NSString *descriptionOfItem = [[NSString alloc] initWithFormat:@"\nItem Name: %@,\nItem Serial Number: %@,\nItem Value : %d,\nItem Creation Date: %@\n\n", _itemName, _serialNumber, (int)_valueInDollars, _dateCreated];
    return descriptionOfItem;
}

#pragma mark - Practice Methods

- (NSMutableArray *)printFizzBuzzForFirstNumber:(NSInteger)number withLastNumber:(NSInteger)end withArray:(NSMutableArray *)resultingArray {
    if (number <= end){
        if (number % 3 == 0 && number % 5 == 0){
            [resultingArray addObject:@"FizzBuzz"];
        } else if (number % 5 == 0) {
            [resultingArray addObject:@"Buzz"];
        } else if (number % 3 == 0) {
            [resultingArray addObject:@"Fizz"];
        } else {
            [resultingArray addObject:[NSNull null]];
        }
        resultingArray = [self printFizzBuzzForFirstNumber:++number withLastNumber:end withArray:resultingArray];
    }
    return resultingArray;
}


@end
