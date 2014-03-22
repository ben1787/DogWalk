//
//  MyProfileViewController.m
//  DogWalk
//
//  Created by Development on 3/14/14.
//  Copyright (c) 2014 Development. All rights reserved.
//

#import "MyProfileViewController.h"
#import "EditProfileViewController.h"
#import "SidebarViewController.h"

@interface MyProfileViewController ()

@end

@implementation MyProfileViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    SidebarViewController *sbvc = (SidebarViewController *)self.revealViewController.rearViewController;
    sbvc.dogDataContext = self.dogDataContext;
}

-(void)setDogDataContext:(NSManagedObjectContext *)dogDataContext
{
    if(!_dogDataContext) {
        _dogDataContext = dogDataContext;
    }
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Family"];
    request.predicate = [NSPredicate predicateWithFormat:@"isUserFamily == 1"];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"isUserFamily"
                                                              ascending:YES]];
    Family *userFamily = [[dogDataContext executeFetchRequest:request
                                                              error:nil] firstObject];
    if(userFamily) {
        self.userFamily = userFamily;
        if ([self.userFamily.dogs anyObject]) {
            [super updateUIData];
        }
    } else {
        self.userFamily = [NSEntityDescription insertNewObjectForEntityForName:@"Family"
                                                        inManagedObjectContext:dogDataContext];
        self.userFamily.owner = [NSEntityDescription insertNewObjectForEntityForName:@"Owner"
                                                              inManagedObjectContext:dogDataContext];
        Dog *familyDog = [NSEntityDescription insertNewObjectForEntityForName:@"Dog"
                                                       inManagedObjectContext:dogDataContext];
        familyDog.family = self.userFamily;
        self.userFamily.isUserFamily = [NSNumber numberWithBool:YES];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.destinationViewController isKindOfClass:[EditProfileViewController class]] && [segue.identifier isEqualToString:@"show edit profile"]) {
        EditProfileViewController *epvc = (EditProfileViewController *)segue.destinationViewController;
        epvc.userFamily = self.userFamily;
    }
    else if ([segue.destinationViewController isKindOfClass:[SidebarViewController class]]) {
        SidebarViewController *sbvc = (SidebarViewController *)segue.destinationViewController;
        sbvc.dogDataContext = self.dogDataContext;
    }
}

-(IBAction)editedProfile:(UIStoryboardSegue *)segue
{
    if([segue.sourceViewController isKindOfClass:[EditProfileViewController class]]) {
        EditProfileViewController *epvc = (EditProfileViewController *)segue.sourceViewController;
        
        self.userFamily.owner.name = epvc.ownerName.text;
        Dog *familyDog = [self.userFamily.dogs anyObject];
        familyDog.name = epvc.dogName.text;
        self.userFamily.aboutUs = epvc.aboutUs.text;
        
        [self updateUIData];
    }
}

@end
