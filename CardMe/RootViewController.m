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

@interface RootViewController ()





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

}
- (IBAction)onGettingStartedButtonTapped:(UIButton *)sender {
}

@end
