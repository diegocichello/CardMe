//
//  User.h
//  CardMe
//
//  Created by Diego Cichello on 2/12/15.
//  Copyright (c) 2015 Mobile Makers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "LinkedinInfo.h"
#import "Card.h"


@interface User : NSManagedObject

@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) LinkedinInfo *info;
@property (nonatomic, retain) Card *card;
@property (nonatomic, retain) NSManagedObjectContext *headline;

@end
