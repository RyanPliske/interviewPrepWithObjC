//
//  RPItem.m
//  interviewPrepWithObjC
//
//  Created by Ryan Pliske on 7/20/15.
//  Copyright (c) 2015 Ryan Pliske. All rights reserved.
//

#import "RPItem.h"

@implementation RPItem

- (instancetype)initWithItemName:(NSString *)name {
    self = [super init];
    _itemName = name;
    return self;
}

- (NSMutableArray *)printFizzBuzzForFirstNumber:(NSInteger)number withLastNumber:(NSInteger)end withArray:(NSMutableArray *)resultingArray {
    if (number <= end){
        if (number % 3 == 0 && number % 5 == 0){
            [resultingArray addObject:@"FizzBuzz"];
        } else if (number % 5 == 0) {
            [resultingArray addObject:@"Buzz"];
        } else if (number % 3 == 0) {
            [resultingArray addObject:@"Fizz"];
        } else {
           [resultingArray addObject:@"None"];
        }
        resultingArray = [self printFizzBuzzForFirstNumber:++number withLastNumber:end withArray:resultingArray];
    }
    return resultingArray;
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


@end
