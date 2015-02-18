//
//  LinkedinInfo.h
//  CardMe
//
//  Created by Diego Cichello on 2/12/15.
//  Copyright (c) 2015 Mobile Makers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class User;

@interface LinkedinInfo : NSManagedObject

@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSString *headline;
@property (nonatomic, retain) NSString * linkedinId;
@property (nonatomic, retain) NSData * pictureSmall;
@property (nonatomic, retain) User *user;
@property (nonatomic, retain) NSManagedObject *role;
@property (nonatomic, retain) NSSet *skills;
@property (nonatomic, retain) NSSet *urls;
@property (nonatomic, retain) NSSet *education;
@property (nonatomic, retain) NSSet *courses;
@property (nonatomic, retain) NSSet *languages;
@property (nonatomic, retain) NSSet *phoneNumbers;
@property (nonatomic, retain) NSSet *positions;
@end

@interface LinkedinInfo (CoreDataGeneratedAccessors)

- (void)addSkillsObject:(NSManagedObject *)value;
- (void)removeSkillsObject:(NSManagedObject *)value;
- (void)addSkills:(NSSet *)values;
- (void)removeSkills:(NSSet *)values;

- (void)addEducationObject:(NSManagedObject *)value;
- (void)removeEducationObject:(NSManagedObject *)value;
- (void)addEducation:(NSSet *)values;
- (void)removeEducation:(NSSet *)values;

- (void)addCoursesObject:(NSManagedObject *)value;
- (void)removeCoursesObject:(NSManagedObject *)value;
- (void)addCourses:(NSSet *)values;
- (void)removeCourses:(NSSet *)values;

- (void)addPositionsObject:(NSManagedObject *)value;
- (void)removePositionsObject:(NSManagedObject *)value;
- (void)addPositions:(NSSet *)values;
- (void)removePositions:(NSSet *)values;

- (void)addPhoneNumbersObject:(NSManagedObject *)value;
- (void)removePhoneNumbersObject:(NSManagedObject *)value;
- (void)addPhoneNumbers:(NSSet *)values;
- (void)removePhoneNumbers:(NSSet *)values;

- (void)addLanguagesObject:(NSManagedObject *)value;
- (void)removeLanguagesObject:(NSManagedObject *)value;
- (void)addLanguages:(NSSet *)values;
- (void)removeLanguages:(NSSet *)values;

- (void)addUrlsObject:(NSManagedObject *)value;
- (void)removeUrlsObject:(NSManagedObject *)value;
- (void)addUrls:(NSSet *)values;
- (void)removeUrls:(NSSet *)values;

+ (void)saveDictionary:(NSDictionary *)dictionary;


@end
