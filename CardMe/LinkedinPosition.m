//
//  LinkedinPosition.m
//  CardMe
//
//  Created by Diego Cichello on 2/12/15.
//  Copyright (c) 2015 Mobile Makers. All rights reserved.
//

#import "LinkedinPosition.h"
#import "LinkedinInfo.h"
#import "CoreDataManager.h"


@implementation LinkedinPosition

@dynamic positionId;
@dynamic companyId;
@dynamic companyName;
@dynamic isCurrent;
@dynamic startDate;
@dynamic endDate;
@dynamic summary;
@dynamic title;

+ (void) appendCurrentPositionsWithArray:(NSArray *)array
{
    for (NSDictionary *dic in array)
    {
        LinkedinPosition *position = [NSEntityDescription insertNewObjectForEntityForName:@"LinkedinPosition" inManagedObjectContext:[CoreDataManager sharedManager].moc];
        position.positionId = dic[@"id"];
        position.companyId = dic[@"company"][@"id"];
        position.companyName = dic[@"company"][@"name"];
        position.isCurrent = dic[@"isCurrent"];
        position.summary = dic[@"summary"];
        position.title = dic[@"title"];

        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *components = [NSDateComponents new];

        [components setMonth:(NSInteger)dic[@"startDate"][@"month"]];
        [components setYear:(NSInteger)dic[@"startDate"][@"year"]];

        position.startDate = [calendar dateFromComponents:components];

        components = [NSDateComponents new];

        [components setMonth:(NSInteger)dic[@"endDate"][@"month"]];
        [components setYear:(NSInteger)dic[@"endDate"][@"year"]];




        [[CoreDataManager sharedManager].linkedinInfo addPositionsObject:position];
    }

}



+ (void) appendPastPositionsWithArray:(NSArray *)array
{
    for (NSDictionary *dic in array)
    {
        LinkedinPosition *position = [NSEntityDescription insertNewObjectForEntityForName:@"LinkedinPosition" inManagedObjectContext:[CoreDataManager sharedManager].moc];
        position.positionId = dic[@"id"];
        position.companyId = dic[@"company"][@"id"];
        position.companyName = dic[@"company"][@"name"];
        position.isCurrent = dic[@"isCurrent"];
        position.summary = dic[@"summary"];
        position.title = dic[@"title"];

        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *components = [NSDateComponents new];

        [components setMonth:(NSInteger)dic[@"startDate"][@"month"]];
        [components setYear:(NSInteger)dic[@"startDate"][@"year"]];

        position.startDate = [calendar dateFromComponents:components];

        components = [NSDateComponents new];

        [components setMonth:(NSInteger)dic[@"endDate"][@"month"]];
        [components setYear:(NSInteger)dic[@"endDate"][@"year"]];

        position.endDate = [calendar dateFromComponents:components];



        
        [[CoreDataManager sharedManager].linkedinInfo addPositionsObject:position];
    }
}

@end
