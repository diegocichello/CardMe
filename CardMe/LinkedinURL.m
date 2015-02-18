//
//  LinkedinURL.m
//  CardMe
//
//  Created by Diego Cichello on 2/16/15.
//  Copyright (c) 2015 Mobile Makers. All rights reserved.
//

#import "LinkedinURL.h"
#import "LinkedinInfo.h"
#import "CoreDataManager.h"


@implementation LinkedinURL

@dynamic webId;
@dynamic name;
@dynamic url;
@dynamic info;

+ (void) appendURLWithArray:(NSArray *)array
{
    for (NSDictionary *dic in array)
    {
        LinkedinURL *url = [NSEntityDescription insertNewObjectForEntityForName:@"LinkedinURL" inManagedObjectContext:[CoreDataManager sharedManager].moc];
        url.webId = dic[@"id"];
        url.name = dic[@"name"];
        url.url = dic[@"url"];
        [[CoreDataManager sharedManager].linkedinInfo addUrlsObject:url];
    }



}


@end
