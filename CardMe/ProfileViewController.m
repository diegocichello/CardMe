//
//  ProfileViewController.m
//  CardMe
//
//  Created by Diego Cichello on 2/19/15.
//  Copyright (c) 2015 Mobile Makers. All rights reserved.
//

#import "ProfileViewController.h"
#import "LinkedinPageViewController.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "CardInfo.h"
#import "LinkedinInfo.h"

@interface ProfileViewController () <UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *profilePicture;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *headlineLabel;

@end


@implementation ProfileViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    self.profilePicture.image = [UIImage imageWithData:self.card.info.linkedininfo.pictureSmall];
    self.nameLabel.text = self.card.info.linkedininfo.firstName;
    self.headlineLabel.text = self.card.info.linkedininfo.headline;
}

- (IBAction)addInContactsButton:(id)sender
{
    ABRecordRef person = ABPersonCreate();

    ABRecordSetValue(person, kABPersonFirstNameProperty, (__bridge CFStringRef) self.card.info.linkedininfo.firstName, nil);
    ABRecordSetValue(person, kABPersonLastNameProperty, (__bridge CFStringRef) self.card.info.linkedininfo.lastName, nil);




        ABMutableMultiValueRef phoneNumberMultiValue = ABMultiValueCreateMutable(kABMultiStringPropertyType);

        ABMultiValueAddValueAndLabel(phoneNumberMultiValue, (__bridge CFStringRef) self.card.info.contactPhone, kABPersonPhoneMainLabel, NULL);
    ABRecordSetValue(person, kABPersonPhoneProperty, phoneNumberMultiValue, nil);

    ABMutableMultiValueRef emailMultiValue = ABMultiValueCreateMutable(kABMultiStringPropertyType);

    ABMultiValueAddValueAndLabel(emailMultiValue, (__bridge CFStringRef) self.card.info.email, kABPersonPhoneMainLabel, NULL);


    CFRelease(emailMultiValue);
    ABRecordSetValue(person, kABPersonEmailProperty, emailMultiValue, nil);




    ABMutableMultiValueRef urlMultiValue =
    ABMultiValueCreateMutable(kABStringPropertyType);
    ABMultiValueAddValueAndLabel(urlMultiValue, (__bridge CFTypeRef)(self.card.info.website),
                                 kABPersonHomePageLabel, NULL);
    ABRecordSetValue(person, kABPersonURLProperty, urlMultiValue, nil);
    CFRelease(urlMultiValue);

   // ABRecordSetValue(person, kABPersonImageFormatOriginalSize, CFBridgingRetain(), nil);
    //ABPersonSetImageData(person, (__bridge CFDataRef)UIImageJPEGRepresentation([UIImage imageNamed:@"diego"], 1), nil);



        CFRelease(phoneNumberMultiValue);


    ABUnknownPersonViewController *controller = [[ABUnknownPersonViewController alloc] init];

    controller.displayedPerson = person;
    controller.allowsAddingToAddressBook = YES;

    // current view must have a navigation controller

    [self.navigationController pushViewController:controller animated:YES];
    
    CFRelease(person);


}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    LinkedinPageViewController *linkedinVC = segue.destinationViewController;

    linkedinVC.linkedinAddress = self.card.info.linkedininfo.linkedinURL;
}

@end
