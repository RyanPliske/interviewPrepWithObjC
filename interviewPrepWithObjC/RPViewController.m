//
//  ViewController.m
//  interviewPrepWithObjC
//
//  Created by Ryan Pliske on 7/17/15.
//  Copyright (c) 2015 Ryan Pliske. All rights reserved.
//

#import "RPViewController.h"
#import "RPItem.h"

@interface RPViewController ()

@property(nonatomic) NSMutableArray *itemsFromClass;
@property(nonatomic) NSMutableArray *itemsFromInstance;

@end

@implementation RPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createItemsUsingClassVariables];
    [self createItemsUsingInstanceVariables];
    [self logItems];
    [self compareItems];
    [self checkIfInstanceItemSerialNumbersAreNil];
    [self printFizzBuzzForNumber:1 LastNumber:100];
}

- (void)printFizzBuzzForNumber:(NSInteger)number LastNumber:(NSInteger)end {
    if (number <= end){
        if (number % 3 == 0 && number % 5 ==0){
            NSLog(@"FizzBuzz");
        } else if (number % 5 ==0) {
            NSLog(@"Buzz");
        } else if (number % 3 ==0) {
            NSLog(@"Fizz");
        }
        
        [self printFizzBuzzForNumber:++number LastNumber:end];
    }
}

- (void)checkIfInstanceItemSerialNumbersAreNil {
    for (RPItem *instanceItem in self.itemsFromInstance) {
        @try {
            NSInteger lengthOfSerialNumber = [self lengthOfSerialNumber:instanceItem.serialNumber];
        } @catch (NSException *nameIsNilException) {
            NSLog(@"%@", nameIsNilException.description);
        }
    }
}

- (NSInteger)lengthOfSerialNumber:(NSString *)name {

    if (!name) {
        NSException *ryansNameIsNotFourLettersLong = [NSException exceptionWithName:@"Name Error" reason:@"This appears to be nil" userInfo:nil];
        @throw ryansNameIsNotFourLettersLong;
    }
    
    return name.length;
}

- (void)createItemsUsingClassVariables {
    self.itemsFromClass = [[NSMutableArray alloc]init];
    RPItem *item;
    [self.itemsFromClass addObject:item.itemName = @"One"];
    [self.itemsFromClass addObject:item.itemName = @"Two"];
    [self.itemsFromClass addObject:item.itemName = @"Three"];
    [self.itemsFromClass insertObject:item.itemName = @"Zero" atIndex:0];
}

- (void)createItemsUsingInstanceVariables {
    self.itemsFromInstance = [[NSMutableArray alloc]init];
    [self.itemsFromInstance addObject:[[RPItem alloc] initWithItemName:@"One"]];
    [self.itemsFromInstance addObject:[[RPItem alloc] initWithItemName:@"Two"]];
    [self.itemsFromInstance addObject:[[RPItem alloc] initWithItemName:@"Three"]];
    [self.itemsFromInstance insertObject:[[RPItem alloc] initWithItemName:@"Zero"] atIndex:0];
}

- (void)logItems {
    for (RPItem *item in self.itemsFromClass) {
        NSLog(@"%@", item);
    }
    
    for (RPItem *item in self.itemsFromInstance) {
        NSLog(@"%@", item);
    }
}

- (void)compareItems {
    if ([self.itemsFromClass isEqual:self.itemsFromInstance]) {
        NSLog(@"These Arrays are the same!");
    } else {
        NSLog(@"These Arrays are not of the same type.");
    }
}

@end
