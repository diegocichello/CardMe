//
//  CurrentUser.m
//  CardMe
//
//  Created by Diego Cichello on 2/16/15.
//  Copyright (c) 2015 Mobile Makers. All rights reserved.
//

#import "CoreDataManager.h"

@implementation CoreDataManager

static CoreDataManager *currentUser = nil;



+ (CoreDataManager *)sharedManager
{
    if (!currentUser) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            currentUser = [[CoreDataManager alloc] init];
        });

    }

    return currentUser;
}



@end
