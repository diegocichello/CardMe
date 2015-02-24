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
@property (weak, nonatomic) IBOutlet UIImageView *cardImage;
@property (weak, nonatomic) IBOutlet UITextView *notesTextView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topViewLC;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topViewRC;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *notesLC;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *notesRC;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewLC;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewRC;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contactsLC;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contactsRC;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *linkedinProfileLC;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *linkedinProfileRC;

@end


@implementation ProfileViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    self.profilePicture.image = [UIImage imageWithData:self.card.info.linkedininfo.pictureSmall];
    self.cardImage.image = [UIImage imageWithData:self.card.image];
    self.notesTextView.text = self.card.notes;
    self.nameLabel.text = self.card.info.linkedininfo.firstName;
    self.headlineLabel.text = self.card.info.linkedininfo.headline;

    self.navigationController.navigationBarHidden = false;
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:true];

    self.topViewLC.constant += self.view.bounds.size.width;

    self.topViewRC.constant += self.view.bounds.size.width;

    self.cardImage.alpha = 0.0;

    self.notesLC.constant += self.view.bounds.size.width;
    self.notesRC.constant -= self.view.bounds.size.width;

    self.textViewLC.constant += self.view.bounds.size.width;
    self.textViewRC.constant += self.view.bounds.size.width;

    self.contactsLC.constant += self.view.bounds.size.width;
    self.contactsRC.constant -= self.view.bounds.size.width;

    self.linkedinProfileLC.constant += self.view.bounds.size.width;
    self.linkedinProfileRC.constant -= self.view.bounds.size.width;




}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:true];

    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.topViewLC.constant -= self.view.bounds.size.width;
        self.topViewRC.constant -= self.view.bounds.size.width;
        [self.view layoutIfNeeded];
    } completion:nil];

    [UIView animateWithDuration:0.3 delay:0.1 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.notesLC.constant -= self.view.bounds.size.width;
        self.notesRC.constant += self.view.bounds.size.width;
        [self.view layoutIfNeeded];
    } completion:nil];

    [UIView animateWithDuration:0.3 delay:0.15 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.textViewLC.constant -= self.view.bounds.size.width;
        self.textViewRC.constant -= self.view.bounds.size.width;
        [self.view layoutIfNeeded];
    } completion:nil];

    [UIView animateWithDuration:0.3 delay:0.2 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.contactsLC.constant -= self.view.bounds.size.width;
        self.contactsRC.constant += self.view.bounds.size.width;
        [self.view layoutIfNeeded];
    } completion:nil];

    [UIView animateWithDuration:0.3 delay:0.25 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.linkedinProfileLC.constant -= self.view.bounds.size.width;
        self.linkedinProfileRC.constant += self.view.bounds.size.width;
        [self.view layoutIfNeeded];
    } completion:nil];

    [UIView transitionWithView:self.cardImage duration:0.5 options:UIViewAnimationOptionCurveEaseOut | UIViewAnimationTransitionCurlDown animations:^{
        self.cardImage.alpha = 1.0;
    } completion:^(BOOL finished) {

    }];

    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.6];
    [UIView setAnimationDelay:0.1];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self.cardImage cache:YES];

    [UIView commitAnimations];
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


    ABPersonSetImageData(person, (__bridge CFDataRef)self.card.info.linkedininfo.pictureSmall, nil);

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
