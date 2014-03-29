//
//  TabBarViewController.m
//  DogWalk
//
//  Created by Development on 3/24/14.
//  Copyright (c) 2014 Development. All rights reserved.
//

#import "TabBarViewController.h"
#import "DogDataAvailability.h"
#import "UICKeyChainStore.h"
#import "LoginViewController.h"

@interface TabBarViewController ()

@end

@implementation TabBarViewController

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    UICKeyChainStore *store = [UICKeyChainStore keyChainStoreWithService:@"DogWalk"];
    NSString *username = [store stringForKey:@"username"];
    NSString *password = [store stringForKey:@"password"];
    if (![LoginViewController validatePassword:password ForUsername:username]) {
        [self performSegueWithIdentifier:@"show login" sender:nil];
    }
}

@end
