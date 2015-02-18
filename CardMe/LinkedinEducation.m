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


//- (id)initWithCoder:(NSCoder *)aDecoder
//{
//    self = [super init];
//    if (self) {
//        self.degree = [aDecoder decodeObjectForKey:@"degree"];
//        self.endDate = [aDecoder decodeObjectForKey:@"endDate"];
//        self.fieldOfStudy = [aDecoder decodeObjectForKey:@"fieldOfStudy"];
//        self.educationId = [aDecoder decodeObjectForKey:@"educationId"];
//        self.notes = [aDecoder decodeObjectForKey:@"notes"];
//        self.schoolName = [aDecoder decodeObjectForKey:@"schoolName"];
//        self.startDate = [aDecoder decodeObjectForKey:@"startDate"];
//        self.activities = [aDecoder decodeObjectForKey:@"activities"];
//
//    }
//    return self;
//}
//
//
//- (void)encodeWithCoder:(NSCoder *)aCoder
//{
//    [aCoder encodeObject:self.degree forKey:@"degree"];
//    [aCoder encodeObject:self.endDate forKey:@"endDate"];
//    [aCoder encodeObject:self.fieldOfStudy forKey:@"fieldOfStudy"];
//    [aCoder encodeObject:self.educationId forKey:@"educationId"];
//    [aCoder encodeObject:self.notes forKey:@"notes"];
//    [aCoder encodeObject:self.schoolName forKey:@"schoolName"];
//    [aCoder encodeObject:self.startDate forKey:@"startDate"];
//    [aCoder encodeObject:self.activities forKey:@"activities"];
//
//
//    
//}

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

        [components setMonth:(NSInteger)dic[@"endDate"][@"month"]];
        [components setYear:(NSInteger)dic[@"endDate"][@"year"]];

        education.endDate = [calendar dateFromComponents:components];


        [[CoreDataManager sharedManager].linkedinInfo addEducationObject:education];
    }
}

@end
