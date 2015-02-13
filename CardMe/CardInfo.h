//
//  CardInfo.h
//  CardMe
//
//  Created by Gustavo Couto on 2015-02-13.
//  Copyright (c) 2015 Mobile Makers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Card, LinkedinInfo;

@interface CardInfo : NSManagedObject

@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * contactPhone;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * fullName;
@property (nonatomic, retain) NSString * headline;
@property (nonatomic, retain) NSString * websites;
@property (nonatomic, retain) Card *card;
@property (nonatomic, retain) LinkedinInfo *linkedininfo;

@end
