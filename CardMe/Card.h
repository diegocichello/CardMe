//
//  Card.h
//  CardMe
//
//  Created by Gustavo Couto on 2015-02-13.
//  Copyright (c) 2015 Mobile Makers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CardInfo, Group, User;

@interface Card : NSManagedObject

@property (nonatomic, retain) NSNumber * cardId;
@property (nonatomic, retain) NSString * cardType;
@property (nonatomic, retain) NSData * color1;
@property (nonatomic, retain) NSData * color2;
@property (nonatomic, retain) NSData * color3;
@property (nonatomic, retain) NSData * color4;
@property (nonatomic, retain) NSData * color5;
@property (nonatomic, retain) NSData * font1;
@property (nonatomic, retain) NSData * font2;
@property (nonatomic, retain) NSData * font3;
@property (nonatomic, retain) NSData * font4;
@property (nonatomic, retain) NSData * font5;
@property (nonatomic, retain) NSNumber * isMainUser;
@property (nonatomic, retain) Group *group;
@property (nonatomic, retain) CardInfo *info;
@property (nonatomic, retain) User *user;

@end
