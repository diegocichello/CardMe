//
//  LinkedinPosition.h
//  CardMe
//
//  Created by Diego Cichello on 2/12/15.
//  Copyright (c) 2015 Mobile Makers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class LinkedinInfo;

@interface LinkedinPosition : NSManagedObject

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSNumber * companyId;
@property (nonatomic, retain) NSString * companyName;
@property (nonatomic, retain) NSNumber * isCurrent;
@property (nonatomic, retain) NSDate * startDate;
@property (nonatomic, retain) NSData * endDate;
@property (nonatomic, retain) NSString * summary;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) LinkedinInfo *info;

@end
