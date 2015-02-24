//
//  RootViewController.m
//  CardMe
//
//  Created by Diego Cichello on 2/12/15.
//  Copyright (c) 2015 Mobile Makers. All rights reserved.
//

#import "RootViewController.h"
#import "CoreDataManager.h"
#import "AppDelegate.h"
#import "TDBInterface.h"

typedef NS_ENUM(NSInteger, TDBButtonTag) {
    TDBButtonTagGetStarted,
    TDBButtonTagSignUp,
    TDBButtonTagSignIn,
    TDBButtonTagSignInWithFacebook
};

@interface RootViewController () <TDBWalkthroughDelegate>





@end

@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.gettingStartedButton.layer.borderColor = [UIColor whiteColor].CGColor;
    self.gettingStartedButton.layer.borderWidth = 2.0f;
    self.gettingStartedButton.layer.cornerRadius = 10.0f;
    self.gettingStartedButton.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];

    self.gettingStartedButton.clipsToBounds = true;

    [CoreDataManager sharedManager].moc = [AppDelegate appDelegate].managedObjectContext;

    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"User"];

    User *user = [[CoreDataManager sharedManager].moc executeFetchRequest:request error:nil].firstObject;

    if (user)
    {
        [CoreDataManager sharedManager].currentUser = user;
        [self performSegueWithIdentifier:@"goToMain" sender:self];
    }
    else
    {

        [self showTDBSimpleWhite];

        [self performSegueWithIdentifier:@"toExplain" sender:self];
    }

}

#pragma mark - TDBWalkthroughDelegate Methods

- (void)didPressButtonWithTag:(NSInteger)tag
{
    switch (tag) {
        case TDBButtonTagGetStarted:
            NSLog(@"Get Started");
            [[TDBWalkthrough sharedInstance] dismiss];
            break;

        case TDBButtonTagSignUp:
            NSLog(@"Sign Up");
            break;

        case TDBButtonTagSignIn:
            NSLog(@"Sign In");
            break;

        case TDBButtonTagSignInWithFacebook:
            NSLog(@"SignInWithFacebook");
            [[TDBWalkthrough sharedInstance] dismiss];
            break;

        default:
            break;
    }
}

- (void)showTDBSimpleWhite
{
    TDBWalkthrough *walkthrough = [TDBWalkthrough sharedInstance];

    // Setting the text for the different slides of the walkthrough
    walkthrough.descriptions = [NSArray arrayWithObjects:
                                @"Create your own personalized card",
                                @"Import your information from LinkedIn",
                                @"Exchange cards with nearby users",
                                @"Browse your collection of cards",
                                nil];

    // Setting the images for the different slides of the walkthrough
    walkthrough.images = [NSArray arrayWithObjects:
                          [UIImage imageNamed:@"first.png"],
                          [UIImage imageNamed:@"second.png"],
                          [UIImage imageNamed:@"third.png"],
                          [UIImage imageNamed:@"icon.png"], nil];

    walkthrough.delegate = self;

    [walkthrough show];
}


- (IBAction)onGettingStartedButtonTapped:(UIButton *)sender {
}

@end
