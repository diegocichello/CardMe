//
//  LinkedinEducation.h
//  CardMe
//
//  Created by Diego Cichello on 2/12/15.
//  Copyright (c) 2015 Mobile Makers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class LinkedinInfo;

@interface LinkedinEducation : NSManagedObject

@property (nonatomic, retain) NSString * degree;
@property (nonatomic, retain) NSDate * endDate;
@property (nonatomic, retain) NSString * fieldOfStudy;
@property (nonatomic, retain) NSNumber * educationId;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSString * schoolName;
@property (nonatomic, retain) NSDate * startDate;
@property (nonatomic, retain) NSString * activities;
@property (nonatomic, retain) LinkedinInfo *info;

+ (void) appendEducationWithArray:(NSArray *)array;


@end
