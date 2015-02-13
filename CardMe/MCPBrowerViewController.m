//
//  MCPBrowerViewController.m
//  CardMe
//
//  Created by Gustavo Couto on 2015-02-12.
//  Copyright (c) 2015 Mobile Makers. All rights reserved.
//

#import "MCPBrowerViewController.h"
#import "SessionController.h"
#import "Card.h"
#import "AppDelegate.h"

@interface MCPBrowerViewController () <SessionControllerDelegate>
@property (nonatomic, strong) SessionController *sessionController;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSManagedObjectContext *moc;
@property Card * testCard;

@end

@implementation MCPBrowerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.moc =  [AppDelegate appDelegate].managedObjectContext;
    self.sessionController = [[SessionController alloc] init];
    Card * testCard = [NSEntityDescription insertNewObjectForEntityForName:@"Card" inManagedObjectContext:self.moc];
    testCard.cardType = @"fuckFace";
    testCard.isMainUser = @(1);
}


#pragma mark - Memory management

- (void)dealloc
{
    // Nil out delegate
    self.sessionController.delegate = nil;
}

#pragma mark - SessionControllerDelegate protocol conformance

- (void)sessionDidChangeState
{
    // Ensure UI updates occur on the main queue.
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

#pragma mark - UITableViewDataSource protocol conformance

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // We have 3 sections in our grouped table view,
    // one for each MCSessionState
    return 3;
}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section
{
    NSInteger rows = 0;

    // Each tableView section represents an MCSessionState
    MCSessionState sessionState = section;

    switch (sessionState)
    {
        case MCSessionStateConnecting:
        {
            rows = self.sessionController.connectingPeers.count;
            break;
        }

        case MCSessionStateConnected:
        {
            rows = self.sessionController.connectedPeers.count;
            break;
        }

        case MCSessionStateNotConnected:
        {
            rows = self.sessionController.disconnectedPeers.count;
            break;
        }
    }

    // Always show at least 1 row for each MCSessionState.
    if (rows < 1)
    {
        rows = 1;
    }

    return rows;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    // Each tableView section represents an MCSessionState
    MCSessionState sessionState = section;

    return [self.sessionController stringForPeerConnectionState:sessionState];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

    cell.textLabel.text = @"None";

    NSArray *peers = nil;

    // Each tableView section represents an MCSessionState
    MCSessionState sessionState = indexPath.section;
    NSInteger peerIndex = indexPath.row;

    switch (sessionState)
    {
        case MCSessionStateConnecting:
        {
            peers = self.sessionController.connectingPeers;
            break;
        }

        case MCSessionStateConnected:
        {
            peers = self.sessionController.connectedPeers;
            break;
        }

        case MCSessionStateNotConnected:
        {
            peers = self.sessionController.disconnectedPeers;
            break;
        }
    }

    if ((peers.count > 0) && (peerIndex < peers.count))
    {
        MCPeerID *peerID = [peers objectAtIndex:peerIndex];

        if (peerID)
        {
            cell.textLabel.text = peerID.displayName;
        }
    }

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSData *myData = [NSKeyedArchiver archivedDataWithRootObject:self.testCard];
    NSLog(@"Archived self.testCard, %@", self.testCard);
    //[self.moc insertObject:<#(NSManagedObject *)#>]
    NSArray * peerArray = [NSArray arrayWithObject:[self.sessionController.connectedPeers objectAtIndex:indexPath.row]];
    NSError *error;
    [self.sessionController.session sendData:myData
                                     toPeers:peerArray
                                    withMode:MCSessionSendDataReliable
                                       error:&error];
     NSLog(@"sent self.testCard, %@", self.testCard);

    if (error) {
        NSLog(@"%@", [error localizedDescription]);
    }
}



@end
