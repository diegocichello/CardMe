
#import "SessionController.h"
#import "Card.h"
#import "AppDelegate.h"
#import "CardDTO.h"
#import "CardInfo.h"
#import "User.h"
#import "CoreDataManager.h"

@interface SessionController () // Class extension
@property (nonatomic, strong) MCPeerID *peerID;
@property (nonatomic, strong) MCNearbyServiceAdvertiser *serviceAdvertiser;
@property (nonatomic, strong) MCNearbyServiceBrowser *serviceBrowser;
@property NSManagedObjectContext * context;

// Connected peers are stored in the MCSession
// Manually track connecting and disconnected peers
@property (nonatomic, strong) NSMutableOrderedSet *connectingPeersOrderedSet;
@property (nonatomic, strong) NSMutableOrderedSet *disconnectedPeersOrderedSet;

@end

@implementation SessionController

static NSString * const kMCSessionServiceType = @"mcsessionp2p";

#pragma mark - Initializer

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        _peerID = [[MCPeerID alloc] initWithDisplayName:[[UIDevice currentDevice] name]];
        
        _connectingPeersOrderedSet = [[NSMutableOrderedSet alloc] init];
        _disconnectedPeersOrderedSet = [[NSMutableOrderedSet alloc] init];
        
        NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
        
        // Register for notifications
        [defaultCenter addObserver:self
                          selector:@selector(startServices)
                              name:UIApplicationWillEnterForegroundNotification
                            object:nil];
        
        [defaultCenter addObserver:self
                          selector:@selector(stopServices)
                              name:UIApplicationDidEnterBackgroundNotification
                            object:nil];
        
        [self startServices];

        _displayName = self.session.myPeerID.displayName;
        self.context = [AppDelegate appDelegate].managedObjectContext;
    }
    
    return self;
}

#pragma mark - Memory management

- (void)dealloc
{
    // Unregister for notifications on deallocation.
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    // Nil out delegates
    _session.delegate = nil;
    _serviceAdvertiser.delegate = nil;
    _serviceBrowser.delegate = nil;
}

#pragma mark - Override property accessors

- (NSArray *)connectedPeers
{
    return self.session.connectedPeers;
}

- (NSArray *)connectingPeers
{
    return [self.connectingPeersOrderedSet array];
}

- (NSArray *)disconnectedPeers
{
    return [self.disconnectedPeersOrderedSet array];
}

#pragma mark - Private methods

- (void)setupSession
{
    // Create the session that peers will be invited/join into.
    _session = [[MCSession alloc] initWithPeer:self.peerID];
    self.session.delegate = self;
    
    // Create the service advertiser
    _serviceAdvertiser = [[MCNearbyServiceAdvertiser alloc] initWithPeer:self.peerID
                                                           discoveryInfo:nil
                                                             serviceType:kMCSessionServiceType];
    self.serviceAdvertiser.delegate = self;
    
    // Create the service browser
    _serviceBrowser = [[MCNearbyServiceBrowser alloc] initWithPeer:self.peerID
                                                       serviceType:kMCSessionServiceType];
    self.serviceBrowser.delegate = self;
}

- (void)teardownSession
{
    [self.session disconnect];
    [self.connectingPeersOrderedSet removeAllObjects];
    [self.disconnectedPeersOrderedSet removeAllObjects];
}

- (void)startServices
{
    [self setupSession];
    [self.serviceAdvertiser startAdvertisingPeer];
    [self.serviceBrowser startBrowsingForPeers];
}

- (void)stopServices
{
    [self.serviceBrowser stopBrowsingForPeers];
    [self.serviceAdvertiser stopAdvertisingPeer];
    [self teardownSession];
}

- (void)updateDelegate
{    
    [self.delegate sessionDidChangeState];
}

- (NSString *)stringForPeerConnectionState:(MCSessionState)state
{
    switch (state) {
        case MCSessionStateConnected:
            return @"Connected";
            
        case MCSessionStateConnecting:
            return @"Connecting";
            
        case MCSessionStateNotConnected:
            return @"Not Connected";
    }
}

#pragma mark - MCSessionDelegate protocol conformance

- (void)session:(MCSession *)session peer:(MCPeerID *)peerID didChangeState:(MCSessionState)state
{
    NSLog(@"Peer [%@] changed state to %@", peerID.displayName, [self stringForPeerConnectionState:state]);
    
    switch (state)
    {
        case MCSessionStateConnecting:
        {
            [self.connectingPeersOrderedSet addObject:peerID];
            [self.disconnectedPeersOrderedSet removeObject:peerID];
            break;
        }
            
        case MCSessionStateConnected:
        {
            [self.connectingPeersOrderedSet removeObject:peerID];
            [self.disconnectedPeersOrderedSet removeObject:peerID];
            break;
        }
            
        case MCSessionStateNotConnected:
        {
            [self.connectingPeersOrderedSet removeObject:peerID];
            [self.disconnectedPeersOrderedSet addObject:peerID];
            break;
        }
    }
    
    [self updateDelegate];
}

- (void)session:(MCSession *)session didReceiveData:(NSData *)data fromPeer:(MCPeerID *)peerID
{


    
    CardDTO * myCardDTO = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    //Card * card = [NSEntityDescription insertNewObjectForEntityForName:@"Card" inManagedObjectContext:self.context];


    [self.delegate receiveCard:myCardDTO];
/*
    NSDictionary * testDict = [NSKeyedUnarchiver unarchiveObjectWithData:myCardDTO.information];
    // CREATE NEW USER

    [LinkedinInfo saveDictionary:testDict];


    card.fontName = myCardDTO.fonts[0];
    card.fontSize = myCardDTO.fonts[1];
    card.colorRed = myCardDTO.colors[0];
    card.colorGreen = myCardDTO.colors[1];
    card.colorBlue = myCardDTO.colors[2];
    card.image = myCardDTO.cardImage;

    CardInfo *cardInfo = [NSEntityDescription insertNewObjectForEntityForName:@"CardInfo" inManagedObjectContext:self.context];

    cardInfo.email = myCardDTO.email;
    cardInfo.address = myCardDTO.address;
    cardInfo.contactPhone = myCardDTO.phoneNumber;
    cardInfo.fullName = myCardDTO.fullName;
    cardInfo.headline = myCardDTO.headline;



    [card setInfo:cardInfo];
    [cardInfo setLinkedininfo:[CoreDataManager sharedManager].linkedinInfo];
    //[self save];

    [self.context insertObject:card];*/
    NSLog(@"didReceiveData %@, %@,from %@", myCardDTO.email, myCardDTO.fullName, peerID.displayName);

    //Send mine to other user
    if (myCardDTO.shouldSendCard == YES)
    {
        NSLog(@"Sending card back");
        CoreDataManager *currentUser = [CoreDataManager sharedManager];
        User *user = currentUser.currentUser;
        CardDTO * testDTO = [[CardDTO alloc] initWithManagedObject:user.card];
        testDTO.shouldSendCard = NO;
        NSData *myData = [NSKeyedArchiver archivedDataWithRootObject:testDTO];
        NSLog(@"Archived testDTO, %@", testDTO);
        NSArray * peerArray = [[NSArray alloc] initWithObjects:peerID, nil];
        NSError *error;
        [self.session sendData:myData
                                toPeers:peerArray
                                withMode:MCSessionSendDataReliable
                                error:&error];

        if (error) {
            NSLog(@"%@", [error localizedDescription]);
        }
    }
}

- (void)session:(MCSession *)session didStartReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID withProgress:(NSProgress *)progress
{
    NSLog(@"didStartReceivingResourceWithName [%@] from %@ with progress [%@]", resourceName, peerID.displayName, progress);
}

- (void)session:(MCSession *)session didFinishReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID atURL:(NSURL *)localURL withError:(NSError *)error
{
    NSLog(@"didFinishReceivingResourceWithName [%@] from %@", resourceName, peerID.displayName);
    
    // If error is not nil something went wrong
    if (error)
    {
        NSLog(@"Error [%@] receiving resource from %@ ", [error localizedDescription], peerID.displayName);
    }
    else
    {
        // No error so this is a completed transfer.  The resources is located in a temporary location and should be copied to a permenant location immediately.
        // Write to documents directory
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *copyPath = [NSString stringWithFormat:@"%@/%@", [paths firstObject], resourceName];
        if (![[NSFileManager defaultManager] copyItemAtPath:[localURL path] toPath:copyPath error:nil])
        {
            NSLog(@"Error copying resource to documents directory");
        }
        else
        {
            // Get a URL for the path we just copied the resource to
            NSURL *url = [NSURL fileURLWithPath:copyPath];
            NSLog(@"url = %@", url);
        }
    }
}

// Streaming API not utilized in this sample code
- (void)session:(MCSession *)session didReceiveStream:(NSInputStream *)stream withName:(NSString *)streamName fromPeer:(MCPeerID *)peerID
{
    NSLog(@"didReceiveStream %@ from %@", streamName, peerID.displayName);
}

#pragma mark - MCNearbyServiceBrowserDelegate protocol conformance

// Found a nearby advertising peer
- (void)browser:(MCNearbyServiceBrowser *)browser foundPeer:(MCPeerID *)peerID withDiscoveryInfo:(NSDictionary *)info
{
    NSString *remotePeerName = peerID.displayName;
    
    NSLog(@"Browser found %@", remotePeerName);
    
    MCPeerID *myPeerID = self.session.myPeerID;
    
    BOOL shouldInvite = ([myPeerID.displayName compare:remotePeerName] == NSOrderedDescending);
    
    if (shouldInvite)
    {
        NSLog(@"Inviting %@", remotePeerName);
        [browser invitePeer:peerID toSession:self.session withContext:nil timeout:30.0];
    }
    else
    {
        NSLog(@"Not inviting %@", remotePeerName);
    }
    
    [self updateDelegate];
}

- (void)browser:(MCNearbyServiceBrowser *)browser lostPeer:(MCPeerID *)peerID
{
    NSLog(@"lostPeer %@", peerID.displayName);
    
    [self.connectingPeersOrderedSet removeObject:peerID];
    [self.disconnectedPeersOrderedSet addObject:peerID];
    
    [self updateDelegate];
}

- (void)browser:(MCNearbyServiceBrowser *)browser didNotStartBrowsingForPeers:(NSError *)error
{
    NSLog(@"didNotStartBrowsingForPeers: %@", error);
}

#pragma mark - MCNearbyServiceAdvertiserDelegate protocol conformance

- (void)advertiser:(MCNearbyServiceAdvertiser *)advertiser didReceiveInvitationFromPeer:(MCPeerID *)peerID withContext:(NSData *)context invitationHandler:(void(^)(BOOL accept, MCSession *session))invitationHandler
{
    NSLog(@"didReceiveInvitationFromPeer %@", peerID.displayName);
    
    invitationHandler(YES, self.session);
    
    [self.connectingPeersOrderedSet addObject:peerID];
    [self.disconnectedPeersOrderedSet removeObject:peerID];
    
    [self updateDelegate];
}

- (void)advertiser:(MCNearbyServiceAdvertiser *)advertiser didNotStartAdvertisingPeer:(NSError *)error
{
    NSLog(@"didNotStartAdvertisingForPeers: %@", error);
}

#pragma mark - Helper methods

-(void)save
{
    NSError *error = nil;
    if (![self.context save:&error]) {
        NSLog(@"failed to save core data %@ %@", error, [error localizedDescription]);
        return;
    }
}

@end
