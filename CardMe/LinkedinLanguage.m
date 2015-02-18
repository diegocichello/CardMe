//
//  LinkedinLanguage.m
//  CardMe
//
//  Created by Diego Cichello on 2/12/15.
//  Copyright (c) 2015 Mobile Makers. All rights reserved.
//

#import "LinkedinLanguage.h"
#import "LinkedinInfo.h"
#import "CoreDataManager.h"


@implementation LinkedinLanguage

@dynamic languageId;
@dynamic name;
@dynamic info;

+ (void) appendLanguageWithArray:(NSArray *)array
{
    for (NSDictionary *dic in array)
    {
        LinkedinLanguage *language = [NSEntityDescription insertNewObjectForEntityForName:@"LinkedinLanguage" inManagedObjectContext:[CoreDataManager sharedManager].moc];
        language.languageId = dic[@"id"];
        language.name = dic[@"language"][@"name"];
        [[CoreDataManager sharedManager].linkedinInfo addLanguagesObject:language];
    }
}


@end
