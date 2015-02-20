//
//  LinkedinPageViewController.m
//  CardMe
//
//  Created by Diego Cichello on 2/19/15.
//  Copyright (c) 2015 Mobile Makers. All rights reserved.
//

#import "LinkedinPageViewController.h"

@interface LinkedinPageViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation LinkedinPageViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.linkedinAddress]]];
}


@end
