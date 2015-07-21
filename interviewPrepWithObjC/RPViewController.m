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
    
    NSString *ryansName = nil;
    if (ryansName.length == 4 ) {
        NSLog(@"Ryan's name is four letters long");
    }
    
    [self createItemsUsingClassVariables];
    [self createItemsUsingInstanceVariables];
    [self logItems];
    [self compareItems];
    
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
