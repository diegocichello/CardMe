//
//  LinkedinPhoneNumber.m
//  CardMe
//
//  Created by Diego Cichello on 2/12/15.
//  Copyright (c) 2015 Mobile Makers. All rights reserved.
//

#import "LinkedinPhoneNumber.h"
#import "LinkedinInfo.h"
#import "CoreDataManager.h"


@implementation LinkedinPhoneNumber

@dynamic phoneNumber;
@dynamic phoneType;
@dynamic info;

+ (void) appendPhoneNumbersWithArray:(NSArray *)array
{
    for (NSDictionary *dic in array)
    {
        LinkedinPhoneNumber *phoneNumber = [NSEntityDescription insertNewObjectForEntityForName:@"LinkedinPhoneNumber" inManagedObjectContext:[CoreDataManager sharedManager].moc];
        phoneNumber.phoneNumber = dic[@"phoneNumber"];
        phoneNumber.phoneType = dic[@"phoneType"];

        [[CoreDataManager sharedManager].linkedinInfo addPhoneNumbersObject:phoneNumber];
    }


}

@end
