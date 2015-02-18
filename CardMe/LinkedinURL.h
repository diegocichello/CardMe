//
//  LinkedinURL.h
//  CardMe
//
//  Created by Diego Cichello on 2/16/15.
//  Copyright (c) 2015 Mobile Makers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class LinkedinInfo;

@interface LinkedinURL : NSManagedObject

@property (nonatomic, retain) NSNumber * webId;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) LinkedinInfo *info;

+ (void) appendURLWithArray:(NSArray *)array;

@end
