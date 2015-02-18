//
//  LinkedinSkill.m
//  CardMe
//
//  Created by Diego Cichello on 2/12/15.
//  Copyright (c) 2015 Mobile Makers. All rights reserved.
//

#import "LinkedinSkill.h"
#import "LinkedinInfo.h"
#import "CoreDataManager.h"


@implementation LinkedinSkill

@dynamic skillId;
@dynamic name;
@dynamic info;

+ (void) appendSkillWithArray:(NSArray *)array
{

    for (NSDictionary *dic in array)
    {
        LinkedinSkill *skill = [NSEntityDescription insertNewObjectForEntityForName:@"LinkedinSkill" inManagedObjectContext:[CoreDataManager sharedManager].moc];
        skill.skillId = dic[@"id"];
        skill.name = dic[@"name"];
        [[CoreDataManager sharedManager].linkedinInfo addSkillsObject:skill];
    }
}


@end
