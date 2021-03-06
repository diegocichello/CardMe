//
//  ViewController.m
//  linkedintest
//
//  Created by Diego Cichello on 2/9/15.
//  Copyright (c) 2015 Mobile Makers. All rights reserved.
//

#import "ExplainViewController.h"

#import "LIALinkedInHttpClient.h"
#import "LIALinkedInApplication.h"
#import "MainViewController.h"
#import "AFHTTPRequestOperation.h"
#import <Parse/Parse.h>

@interface ExplainViewController ()

@property(nonatomic) LIALinkedInHttpClient *client;
@property (weak, nonatomic) IBOutlet UIButton *connectButton;

@end

@implementation ExplainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.connectButton.layer.borderWidth = 2.0f;
    self.connectButton.layer.borderColor = [UIColor whiteColor].CGColor;
    self.connectButton.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];

    NSArray *grantedAccess = @[ @"r_fullprofile",@"r_contactinfo",@"r_emailaddress",@"r_network"];

    //load the the secret data from an uncommitted LIALinkedInClientExampleCredentials.h file
    NSString *clientId = @"75oo5lyj3615yg" ; //the client secret you get from the registered LinkedIn application
    NSString *clientSecret = @"ELorq0E0t5nV4exL"; //the client secret you get from the registered LinkedIn application
    NSString *state = @"DCEEFWF45453sdffef424"; //A long unique string value of your choice that is hard to guess. Used to prevent CSRF
    LIALinkedInApplication *application = [LIALinkedInApplication applicationWithRedirectURL:@"https://www.mobilemakers.co" clientId:clientId clientSecret:clientSecret state:state grantedAccess:grantedAccess];
    self.client = [LIALinkedInHttpClient clientForApplication:application];


}
- (IBAction)didPressLoginButton:(id)sender
{
    NSLog(@"did press login");

    
    [self.client getAuthorizationCode:^(NSString *code) {
        [self.client getAccessToken:code success:^(NSDictionary *accessTokenData) {
            NSString *accessToken = [accessTokenData objectForKey:@"access_token"];
            [self.client GET:[NSString stringWithFormat:@"https://api.linkedin.com/v1/people/~:(first-name,last-name,phone-numbers,email_address,certifications,educations,courses,three-current-positions,three-past-positions,num-recommenders,honors-awards,languages,picture-url,skills)?oauth2_access_token=%@&format=json", accessToken] parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary *result) {
                NSLog(@"current user %@", result);
                MainViewController *mvc = [self.storyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
                [self.navigationController pushViewController:mvc animated:true];
            }            failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"failed to fetch current user %@", error);
            }];
        }                   failure:^(NSError *error) {
            NSLog(@"Quering accessToken failed %@", error);
        }];
    }                          cancel:^{
        NSLog(@"Authorization was cancelled by user");
    }                         failure:^(NSError *error) {
        NSLog(@"Authorization failed %@", error);
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
