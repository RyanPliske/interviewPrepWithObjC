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
    [self compareItems];
    [self checkIfInstanceItemSerialNumbersAreNil];
    [self createTenRandomItems];
//    [self logItemsFromClass];
    
// a way to force an unrecognized selector sent to instance exception at runtime
//    id lastObj = [self.itemsFromClass lastObject];
//    [lastObj count];
    
    [self forceRetainCycle];
    NSString *ryanReversed = [self reverseItemName:@"Ryan"];
    NSLog(@"Ryan reversed %@", ryanReversed);
}

- (void)forceRetainCycle {
    RPItem *backpack = [[RPItem alloc] initWithItemName:@"backpack"];
    RPItem *calculator = [[RPItem alloc] init];
    calculator.containedItem = backpack;
    
    calculator = nil;
    backpack = nil;
}

- (void)createTenRandomItems {
    if (self.itemsFromClass) {
        [self.itemsFromClass removeAllObjects];
    }
    for (int count = 0; count <= 10; count++){
        [self.itemsFromClass addObject:[RPItem randomItem]];
    }
}

- (NSString *)reverseItemName:(NSString *)itemName {
    NSUInteger charactersRemaining = itemName.length;
    NSMutableString *reversedString = [[NSMutableString alloc] init];
    
    while (charactersRemaining > 0) {
        charactersRemaining--;
        [reversedString appendString:[itemName substringWithRange:NSMakeRange(charactersRemaining, 1)]];
    }
    
    return reversedString;
}

- (void)checkIfInstanceItemSerialNumbersAreNil {
    for (RPItem *instanceItem in self.itemsFromInstance) {
        @try {
            NSInteger lengthOfSerialNumber = [self lengthOfSerialNumber:instanceItem.serialNumber];
        } @catch (NSException *nameIsNilException) {
            NSLog(@"%@\n", nameIsNilException.description);
        }
    }
}

- (NSInteger)lengthOfSerialNumber:(NSString *)name {

    if (!name) {
        NSException *ryansNameIsNotFourLettersLong = [NSException exceptionWithName:@"Serial Number Error" reason:@"Serial No. appears to be nil" userInfo:nil];
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

- (void)logItemsFromClass {
    NSLog(@"\n✅Items From Class:");
    for (RPItem *item in self.itemsFromClass) {
        NSLog(@"%@\n", item);
    }
}

- (void)logItemsFromInstance {
    NSLog(@"\n✅Items From Instance: ");
    for (RPItem *item in self.itemsFromInstance) {
        NSLog(@"%@\n", item);
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
