//
//  MyProfileViewController.m
//  DogWalk
//
//  Created by Development on 3/14/14.
//  Copyright (c) 2014 Development. All rights reserved.
//

#import "MyProfileViewController.h"
#import "EditProfileViewController.h"

@interface MyProfileViewController ()

@end

@implementation MyProfileViewController

-(void)setManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    if(!_managedObjectContext) {
        _managedObjectContext = managedObjectContext;
    }
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Family"];
    request.predicate = [NSPredicate predicateWithFormat:@"isUserFamily == 1"];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"isUserFamily"
                                                              ascending:YES]];
    Family *userFamily = [[managedObjectContext executeFetchRequest:request
                                                              error:nil] firstObject];
    if(userFamily) {
        self.userFamily = userFamily;
        if ([self.userFamily.dogs anyObject]) {
            [super updateUIData];
        }
    } else {
        self.userFamily = [NSEntityDescription insertNewObjectForEntityForName:@"Family"
                                                        inManagedObjectContext:managedObjectContext];
        self.userFamily.owner = [NSEntityDescription insertNewObjectForEntityForName:@"Owner"
                                                              inManagedObjectContext:managedObjectContext];
        Dog *familyDog = [NSEntityDescription insertNewObjectForEntityForName:@"Dog"
                                                       inManagedObjectContext:managedObjectContext];
        familyDog.family = self.userFamily;
        self.userFamily.isUserFamily = [NSNumber numberWithBool:YES];
    }
}

-(void)awakeFromNib
{
    [[NSNotificationCenter defaultCenter] addObserverForName:DogDataAvailabilityNotfication
                                                      object:nil
                                                       queue:nil
                                                  usingBlock:^(NSNotification *note) {
                                                      self.managedObjectContext = note.userInfo[DogDataAvailabilityContext];
                                                  }];
    [super awakeFromNib];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.destinationViewController isKindOfClass:[EditProfileViewController class]] && [segue.identifier isEqualToString:@"show edit profile"]) {
        EditProfileViewController *epvc = (EditProfileViewController *)segue.destinationViewController;
        epvc.userFamily = self.userFamily;
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
