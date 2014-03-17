//
//  AppDelegate.m
//  DogWalk
//
//  Created by Development on 3/4/14.
//  Copyright (c) 2014 Development. All rights reserved.
//

#import "AppDelegate.h"
#import "DogDataAvailability.h"

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
