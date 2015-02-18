//
//  LinkedinCourse.m
//  CardMe
//
//  Created by Diego Cichello on 2/12/15.
//  Copyright (c) 2015 Mobile Makers. All rights reserved.
//

#import "LinkedinCourse.h"
#import "LinkedinInfo.h"
#import "CoreDataManager.h"


@implementation LinkedinCourse

@dynamic courseId;
@dynamic name;
@dynamic info;

+ (void) appendCoursesWithArray:(NSArray *)array;
{

        for (NSDictionary *dic in array)
        {
            LinkedinCourse *course = [NSEntityDescription insertNewObjectForEntityForName:@"LinkedinCourse" inManagedObjectContext:[CoreDataManager sharedManager].moc];
            course.courseId = dic[@"id"];
            course.name = dic[@"name"];
            [[CoreDataManager sharedManager].linkedinInfo addCoursesObject:course];
        }



}

@end
