//
//  CurrentUser.h
//  CardMe
//
//  Created by Diego Cichello on 2/16/15.
//  Copyright (c) 2015 Mobile Makers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "LinkedinInfo.h"

@interface CoreDataManager : NSObject

@property User *currentUser;
@property NSManagedObjectContext *moc;
@property LinkedinInfo *linkedinInfo;

+ (CoreDataManager *)sharedManager;

@end
