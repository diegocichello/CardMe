//
//  CardDTO.h
//  CardMe
//
//  Created by Gustavo Couto on 2015-02-13.
//  Copyright (c) 2015 Mobile Makers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"


@interface CardDTO : NSObject <NSCoding>

@property NSArray *fonts;
@property NSArray *colors;
@property NSString *email;
@property NSString *fullName;
@property NSString *phoneNumber;
@property NSString *headline;
@property NSString *address;
@property NSArray *jobs;
@property NSArray *skills;
@property NSArray *education;

- (instancetype)initWithManagedObject: (Card *)card;
- (void)encodeWithCoder:(NSCoder *)aCoder;
- (id)initWithCoder:(NSCoder *)aDecoder;

@end
