//
//  LinkedinEducation.m
//  CardMe
//
//  Created by Diego Cichello on 2/12/15.
//  Copyright (c) 2015 Mobile Makers. All rights reserved.
//

#import "LinkedinEducation.h"
#import "LinkedinInfo.h"
#import "CoreDataManager.h"


@implementation LinkedinEducation

@dynamic degree;
@dynamic endDate;
@dynamic fieldOfStudy;
@dynamic educationId;
@dynamic notes;
@dynamic schoolName;
@dynamic startDate;
@dynamic activities;
@dynamic info;

+ (void) appendEducationWithArray:(NSArray *)array
{

    for (NSDictionary *dic in array)
    {
        LinkedinEducation *education = [NSEntityDescription insertNewObjectForEntityForName:@"LinkedinEducation" inManagedObjectContext:[CoreDataManager sharedManager].moc];
        education.educationId = dic[@"id"];
        education.degree = dic[@"degree"];
        education.fieldOfStudy = dic[@"fieldOfStudy"];
        education.notes = dic[@"notes"];
        education.schoolName = dic[@"schoolName"];

        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *components = [NSDateComponents new];

        NSNumber *startDateYear = dic[@"startDate"][@"year"];

       // [components setMonth:dic[@"startDate"][@"month"]];
        [components setYear:[startDateYear intValue]];

        education.startDate = [calendar dateFromComponents:components];

        components = [NSDateComponents new];

        [components setMonth:dic[@"endDate"][@"month"]];
        [components setYear:dic[@"endDate"][@"year"]];

        education.endDate = [calendar dateFromComponents:components];


        [[CoreDataManager sharedManager].linkedinInfo addEducationObject:education];
    }
}

@end
