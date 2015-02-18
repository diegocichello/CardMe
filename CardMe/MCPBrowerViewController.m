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
#import "CardDTO.h"
#import "CardInfo.h"
#import "CoreDataManager.h"


@interface MCPBrowerViewController () <SessionControllerDelegate>
@property (nonatomic, strong) SessionController *sessionController;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property NSManagedObjectContext *moc;

@property NSManagedObjectContext * context;


//temporary

@property Card * testCard;
@property NSMutableArray * cardArray;

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

    self.sessionController.delegate = self;
    self.context = [AppDelegate appDelegate].managedObjectContext;
    [self loadCards];
    if ( self.cardArray.count == 0)
    {
        Card * testCard = [NSEntityDescription insertNewObjectForEntityForName:@"Card" inManagedObjectContext:self.context];
        testCard.isMainUser = @(1);
        testCard.cardType = @"Business";

        CardInfo *cardInfo = [NSEntityDescription insertNewObjectForEntityForName:@"CardInfo" inManagedObjectContext:self.context];

        cardInfo.email = @"gustavocoutoeom@gmail.com";
        cardInfo.address = @"shady lane";
        cardInfo.contactPhone = @"twotwoonethree";
        cardInfo.fullName = @"Gustavo Couto";
        cardInfo.headline = @"Major retard";

        [testCard setInfo:cardInfo];
        [self save];
        [self loadCards];
    }

}

#pragma mark - Helper methods
- (void)loadCards
{
    self.cardArray = [NSMutableArray new];
    NSFetchRequest * request = [NSFetchRequest fetchRequestWithEntityName:[Card description]];
    self.cardArray =  [[self.context executeFetchRequest:request error:nil] mutableCopy];
    self.testCard = self.cardArray.firstObject;
    
}

-(void)save
{
    NSError *error = nil;
    if (![self.context save:&error]) {
        NSLog(@"failed to save core data %@ %@", error, [error localizedDescription]);
        return;
    }
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section
{
    NSInteger rows = 0;

    rows = self.sessionController.connectedPeers.count;

    // Always show at least 1 row for each MCSessionState.
    if (rows < 1)
    {
        rows = 1;
    }

    return rows;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{

    return @"Connected";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

    cell.textLabel.text = @"None";

    if ( self.sessionController.connectedPeers.count > 0)
    {
        MCPeerID * peerid = self.sessionController.connectedPeers[indexPath.row];
        cell.textLabel.text = peerid.displayName;
    }


    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{


    NSLog(@"Archived self.testCard, %@", self.testCard);

    //CardDTO * testDTO = [[CardDTO alloc] initWithManagedObject:self.testCard];
    CoreDataManager *currentUser = [CoreDataManager sharedManager];
    User *user = currentUser.currentUser;
    CardDTO * testDTO = [[CardDTO alloc] initWithManagedObject:user.card];
    testDTO.shouldSendCard = true;
    NSData *myData = [NSKeyedArchiver archivedDataWithRootObject:testDTO];
    NSLog(@"Archived testDTO, %@", testDTO);

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
