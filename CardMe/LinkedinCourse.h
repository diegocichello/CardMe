//
//  LinkedinCourse.h
//  CardMe
//
//  Created by Diego Cichello on 2/12/15.
//  Copyright (c) 2015 Mobile Makers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class LinkedinInfo;

@interface LinkedinCourse : NSManagedObject

@property (nonatomic, retain) NSNumber * courseId;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) LinkedinInfo *info;

@end
