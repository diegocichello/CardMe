//
//  LinkedinPhoneNumber.h
//  CardMe
//
//  Created by Diego Cichello on 2/12/15.
//  Copyright (c) 2015 Mobile Makers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class LinkedinInfo;

@interface LinkedinPhoneNumber : NSManagedObject

@property (nonatomic, retain) NSString * phoneNumber;
@property (nonatomic, retain) NSString * phoneType;
@property (nonatomic, retain) LinkedinInfo *info;

+ (void) appendPhoneNumbersWithArray:(NSArray *)array;


@end
