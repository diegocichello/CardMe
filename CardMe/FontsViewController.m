//
//  FontsViewController.m
//  CardMe
//
//  Created by Diego Cichello on 2/24/15.
//  Copyright (c) 2015 Mobile Makers. All rights reserved.
//

#import "FontsViewController.h"

@interface FontsViewController () <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property NSMutableArray *fontsArray;

@end

@implementation FontsViewController


- (void)viewDidLoad
{
    [super viewDidLoad];

    self.fontsArray = [NSMutableArray arrayWithObjects:@"Arial",@"Avenir",@"Courier New",@"Damascus", @"Didot", @"Gill Sans", @"Futura",@"Helvetica", @"Kailasa",@"Marion",@"Optima",@"Papyrus",@"Symbol",@"Thornburi",@"Verdana", nil];
    [self.tableView reloadData];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return self.fontsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];

    NSString *font = [self.fontsArray objectAtIndex:indexPath.row];
    cell.textLabel.text = self.fullName;
    cell.textLabel.font = [UIFont fontWithName:font size:18];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.myCardVC.font = [UIFont fontWithName:self.fontsArray[indexPath.row] size:12];
    [self dismissViewControllerAnimated:true completion:nil];
}

@end
