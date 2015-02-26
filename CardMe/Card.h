//
//  Card.h
//  CardMe
//
//  Created by Diego Cichello on 2/17/15.
//  Copyright (c) 2015 Mobile Makers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CardInfo, Group, User;

@interface Card : NSManagedObject

@property (nonatomic, retain) NSNumber * cardId;
@property (nonatomic, retain) NSString * fullName;
@property (nonatomic, retain) NSString * cardType;
@property (nonatomic, retain) NSNumber * colorRed;
@property (nonatomic, retain) NSNumber * colorBlue;
@property (nonatomic, retain) NSNumber * colorGreen;
@property (nonatomic, retain) NSString * fontName;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSNumber * fontSize;
@property (nonatomic, retain) NSNumber * isMainUser;
@property (nonatomic, retain) NSData *image;
@property (nonatomic, retain) Group *group;
@property (nonatomic, retain) CardInfo *info;
@property (nonatomic, retain) User *user;

+ (void) retrieveCardsWithBlock:(void (^)(NSArray * array))complete;
+ (void) retrieveCardsThatContain:(NSString *)string withBlock:(void (^)(NSArray * array))complete;

@end
