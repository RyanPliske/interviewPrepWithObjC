//
//  UIViewController+Tracking.m
//  interviewPrepWithObjC
//
//  Created by Ryan Pliske on 7/18/15.
//  Copyright (c) 2015 Ryan Pliske. All rights reserved.
//

#import <objc/runtime.h>
#import "UIViewController+Tracking.h"

@implementation UIViewController (Tracking)


+ (void)load {
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
    });
    
    
}

@end
