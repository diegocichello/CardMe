//
//  LinkedinInfo.m
//  CardMe
//
//  Created by Diego Cichello on 2/12/15.
//  Copyright (c) 2015 Mobile Makers. All rights reserved.
//

#import "LinkedinInfo.h"
#import "LinkedinEducation.h"
#import "LinkedinLanguage.h"
#import "LinkedinCourse.h"
#import "LinkedinPosition.h"
#import "LinkedinSkill.h"
#import "LinkedinURL.h"
#import "LinkedinPhoneNumber.h"
#import "CoreDataManager.h"
#import "User.h"
#import <UIKit/UIKit.h>



@implementation LinkedinInfo

@dynamic email;
@dynamic firstName;
@dynamic lastName;
@dynamic pictureSmall;
@dynamic linkedinId;
@dynamic user;
@dynamic skills;
@dynamic education;
@dynamic linkedinURL;
@dynamic courses;
@dynamic languages;
@dynamic phoneNumbers;
@dynamic positions;
@dynamic headline;
@dynamic urls;


+ (void)saveDictionary:(NSDictionary *)dictionary
{
    NSManagedObjectContext *moc = [CoreDataManager sharedManager].moc;

    LinkedinInfo *linkedinInfo = [NSEntityDescription insertNewObjectForEntityForName:@"LinkedinInfo"inManagedObjectContext:moc];

    [CoreDataManager sharedManager].linkedinInfo = linkedinInfo;

    linkedinInfo.email = dictionary[@"emailAddress"];
    linkedinInfo.firstName = dictionary[@"firstName"];
    linkedinInfo.lastName = dictionary[@"lastName"];
    linkedinInfo.headline = dictionary[@"headline"];
    linkedinInfo.linkedinId = dictionary[@"id"];
    linkedinInfo.linkedinURL = dictionary[@"publicProfileUrl"];
    NSArray *array = dictionary[@"pictureUrls"][@"values"];
    linkedinInfo.pictureSmall = [NSData dataWithContentsOfURL:[NSURL URLWithString:array.firstObject]];


    [LinkedinCourse appendCoursesWithArray:dictionary[@"courses"][@"values"]];

    [LinkedinEducation appendEducationWithArray:dictionary[@"educations"][@"values"]];

    [LinkedinSkill appendSkillWithArray:dictionary[@"skills"][@"values"]];

    [LinkedinPosition appendCurrentPositionsWithArray:dictionary[@"threeCurrentPositions"][@"values"]];
    [LinkedinPosition appendPastPositionsWithArray:dictionary[@"threePastPositions"][@"values"]];
    [LinkedinPhoneNumber appendPhoneNumbersWithArray:dictionary[@"phoneNumbers"][@"values"]];
    [LinkedinLanguage appendLanguageWithArray:dictionary[@"phoneNumbers"][@"values"]];
    [LinkedinURL appendURLWithArray:dictionary[@"memberUrlResources"][@"values"]];

    if(![CoreDataManager sharedManager].currentUser)
    {

        User *user = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:moc];
        user.email = dictionary[@"emailAddress"];
        user.username = dictionary[@"emailAddress"];
        user.information = [NSKeyedArchiver archivedDataWithRootObject:dictionary];
                //user.information = dictionary;
        user.info = linkedinInfo;


        [CoreDataManager sharedManager].currentUser = user;
    }

    [[CoreDataManager sharedManager].moc save:nil];
}



@end
