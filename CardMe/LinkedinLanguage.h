//
//  LinkedinLanguage.h
//  CardMe
//
//  Created by Diego Cichello on 2/12/15.
//  Copyright (c) 2015 Mobile Makers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class LinkedinInfo;

@interface LinkedinLanguage : NSManagedObject

@property (nonatomic, retain) NSNumber * languageId;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) LinkedinInfo *info;

+ (void) appendLanguageWithArray:(NSArray *)array;


@end
