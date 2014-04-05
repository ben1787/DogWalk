//
//  AppDelegate.m
//  DogWalk
//
//  Created by Development on 3/4/14.
//  Copyright (c) 2014 Development. All rights reserved.
//

#import "AppDelegate.h"
#import "DogDataAvailability.h"
#import "LoginViewController.h"

@interface AppDelegate()
@property (strong, nonatomic) NSManagedObjectContext *dogDataContext;
@end

@implementation AppDelegate


#pragma mark Initialize DogData

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *docDirectory = [[fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject];
    NSString *docName = @"DogWalkDoc";
    NSURL *url = [docDirectory URLByAppendingPathComponent:docName];
    UIManagedDocument *umd = [[UIManagedDocument alloc] initWithFileURL:url];
    if([[NSFileManager defaultManager] fileExistsAtPath:[url path]]) {
        [umd openWithCompletionHandler:^(BOOL success){
            if(success) {
                if (umd.documentState == UIDocumentStateNormal) {
                    self.dogDataContext = umd.managedObjectContext;
                }
            }
        }];
    }
    else {
        [umd saveToURL:url forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success) {
            if(success) {
                if (umd.documentState == UIDocumentStateNormal) {
                    self.dogDataContext = umd.managedObjectContext;
                }
            }
        }];
    }
    
    //retreive the credentials from keychain. If there on to profile, else to login
    /*UICKeyChainStore *store = [UICKeyChainStore keyChainStoreWithService:@"DogWalk"];
    NSString *username = [store stringForKey:@"username"];
    NSString *password = [store stringForKey:@"password"];
    BOOL isLoggedIn = [LoginViewController validatePassword:password ForUsername:username];
    
    NSString *storyboardId = isLoggedIn ? @"Root" : @"Login";
    self.window.rootViewController = [self.window.rootViewController.storyboard instantiateViewControllerWithIdentifier:storyboardId];
   
   */
    return YES;
}

-(void)setDogDataContext:(NSManagedObjectContext *)dogDataContext
{
    if(!_dogDataContext) {
        _dogDataContext = dogDataContext;
    }
    
    [self addFamilies];
    
    NSDictionary *userInfo = self.dogDataContext ? @{DogDataAvailabilityContext : self.dogDataContext} : nil;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:DogDataAvailabilityNotfication
                                                        object:self
                                                      userInfo:userInfo];
}

-(void)addFamilies {
    
    //Check to see if there are any playpal families and add if there are not
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Family"];
    request.predicate = [NSPredicate predicateWithFormat:@"isUserFamily == 0"];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"owner.name"
                                                              ascending:YES]];
    NSArray *playpals = [self.dogDataContext executeFetchRequest:request
                                                              error:nil];
    
    
    NSFetchRequest *userFamilyRequest = [NSFetchRequest fetchRequestWithEntityName:@"Family"];
    userFamilyRequest.predicate = [NSPredicate predicateWithFormat:@"isUserFamily == 1"];
    [userFamilyRequest setFetchLimit:1];
    NSArray *userFamilyArray = [self.dogDataContext executeFetchRequest:userFamilyRequest
                                                           error:nil];
    if([userFamilyArray count] && ![playpals count]) {
        Family *userFamily = [userFamilyArray objectAtIndex:0];
        //Add additional families to the database
        //scooby doo
        Family *mysteryTeam = [NSEntityDescription insertNewObjectForEntityForName:@"Family"
                                                            inManagedObjectContext:self.dogDataContext];
        mysteryTeam.owner = [NSEntityDescription insertNewObjectForEntityForName:@"Owner"
                                                          inManagedObjectContext:self.dogDataContext];
        Dog *scooby = [NSEntityDescription insertNewObjectForEntityForName:@"Dog"
                                                    inManagedObjectContext:self.dogDataContext];
        mysteryTeam.owner.name = @"Shaggy";
        scooby.name = @"Scooby Doo";
        scooby.family = mysteryTeam;
        mysteryTeam.aboutUs = @"We solve mysteries!";
        NSMutableSet *mtPlaypals = [mysteryTeam mutableSetValueForKey:@"playsWith"];
        [mtPlaypals addObject:userFamily];
        
        //snoopy
        Family *peanuts = [NSEntityDescription insertNewObjectForEntityForName:@"Family"
                                                            inManagedObjectContext:self.dogDataContext];
        peanuts.owner = [NSEntityDescription insertNewObjectForEntityForName:@"Owner"
                                                          inManagedObjectContext:self.dogDataContext];
        Dog *snoopy = [NSEntityDescription insertNewObjectForEntityForName:@"Dog"
                                                    inManagedObjectContext:self.dogDataContext];
        peanuts.owner.name = @"Charlie";
        snoopy.name = @"Snoopy";
        snoopy.family = peanuts;
        peanuts.aboutUs = @"We play together.";
        NSMutableSet *pPlaypals = [peanuts mutableSetValueForKey:@"playsWith"];
        [pPlaypals addObject:userFamily];
        
        //clifford
        Family *elizabeth = [NSEntityDescription insertNewObjectForEntityForName:@"Family"
                                                            inManagedObjectContext:self.dogDataContext];
        elizabeth.owner = [NSEntityDescription insertNewObjectForEntityForName:@"Owner"
                                                          inManagedObjectContext:self.dogDataContext];
        Dog *clifford = [NSEntityDescription insertNewObjectForEntityForName:@"Dog"
                                                    inManagedObjectContext:self.dogDataContext];
        elizabeth.owner.name = @"Emily";
        clifford.name = @"Clifford";
        clifford.family = elizabeth;
        elizabeth.aboutUs = @"Clifford is the biggest reddest dog ever!";
        NSMutableSet *ePlaypals = [elizabeth mutableSetValueForKey:@"playsWith"];
        [ePlaypals addObject:userFamily];
    }
}


#pragma mark Standard App Delegation
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
