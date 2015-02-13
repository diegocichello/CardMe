//
//  Card.h
//  CardMe
//
//  Created by Diego Cichello on 2/12/15.
//  Copyright (c) 2015 Mobile Makers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class User;

@interface Card : NSManagedObject <NSCoding>

@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSData * color1;
@property (nonatomic, retain) NSData * color2;
@property (nonatomic, retain) NSData * color3;
@property (nonatomic, retain) NSData * color4;
@property (nonatomic, retain) NSData * color5;
@property (nonatomic, retain) NSNumber *cardId;
@property (nonatomic, retain) NSData * font1;
@property (nonatomic, retain) NSData * font2;
@property (nonatomic, retain) NSData * font3;
@property (nonatomic, retain) NSData * font4;
@property (nonatomic, retain) NSData * font5;
@property (nonatomic, retain) NSNumber * isMainUser;
@property (nonatomic, retain) User *user;
@property (nonatomic, retain) NSManagedObject *group;

@end
