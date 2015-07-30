//
//  RPItem.h
//  interviewPrepWithObjC
//
//  Created by Ryan Pliske on 7/20/15.
//  Copyright (c) 2015 Ryan Pliske. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RPItem : NSObject
{
    NSString *_itemName;
    NSString *_serialNumber;
    NSInteger _valueInDollars;
    NSDate *_dateCreated;
}

- (NSMutableArray *)printFizzBuzzForFirstNumber:(NSInteger)number withLastNumber:(NSInteger)end withArray:(NSMutableArray *)resultingArray;

- (instancetype)initWithItemName:(NSString *)name;

- (void)setItemName:(NSString *)itemName;
- (NSString *)itemName;

- (void)setSerialNumber:(NSString *)serialNumber;
- (NSString *)serialNumber;

- (void)setValueInDollars:(NSInteger)dollarAmt;
- (NSInteger)valueInDollars;

- (void)setDateCreated:(NSDate *)dateCreated;
- (NSDate *)dateCreated;

@end
