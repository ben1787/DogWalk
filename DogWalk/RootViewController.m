//
//  RootViewController.m
//  DogWalk
//
//  Created by Development on 3/19/14.
//  Copyright (c) 2014 Development. All rights reserved.
//

#import "RootViewController.h"
#import "UICKeyChainStore.h"
#import "LoginViewController.h"
#import "MyProfileViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

-(void)awakeFromNib
{
    [[NSNotificationCenter defaultCenter] addObserverForName:DogDataAvailabilityNotfication
                                                      object:nil
                                                       queue:nil
                                                  usingBlock:^(NSNotification *note) {
                                                      self.dogDataContext = note.userInfo[DogDataAvailabilityContext];
                                                  }];
    [super awakeFromNib];
}

-(void)setDogDataContext:(NSManagedObjectContext *)dogDataContext
{
    // set managed object context
    _dogDataContext = dogDataContext;
    

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.destinationViewController isKindOfClass:[LoginViewController class]]) {
        LoginViewController *lvc = (LoginViewController *)segue.destinationViewController;
        lvc.dogDataContext = self.dogDataContext;
    }
    else if ([segue.destinationViewController isKindOfClass:[MyProfileViewController class]]) {
        MyProfileViewController *mpvc = (MyProfileViewController *)segue.destinationViewController;
        mpvc.dogDataContext = self.dogDataContext;
    }
}



@end
