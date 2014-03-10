//
//  ViewController.m
//  DogWalk
//
//  Created by Development on 3/4/14.
//  Copyright (c) 2014 Development. All rights reserved.
//

#import "ProfileViewController.h"
#import "SWRevealViewController.h"
#import "EditProfileViewController.h"
#import "DogDataAvailability.h"

@interface ProfileViewController ()
@property (weak, nonatomic) IBOutlet UILabel *names;
@property (weak, nonatomic) IBOutlet UITextView *aboutUs;
@property (strong, nonatomic) Family *userFamily;
@end

@implementation ProfileViewController

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

-(void)setManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    if(!_managedObjectContext) {
        _managedObjectContext = managedObjectContext;
    }
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Family"];
    request.predicate = nil; //[NSPredicate predicateWithFormat:@"isUserFamily == 1"];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"isUserFamily"
                                                            ascending:YES]];
    Family *userFamily = [[managedObjectContext executeFetchRequest:request
                                                              error:nil] firstObject];
    if(userFamily) {
        self.userFamily = userFamily;
        if ([self.userFamily.dogs anyObject]) {
            [self updateUIData];
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

-(void)updateUIData
{
    Dog *randomDog = [self.userFamily.dogs anyObject];
    self.names.text = [NSString stringWithFormat:@"%@ & %@", self.userFamily.owner.name, randomDog.name];
    self.aboutUs.text = self.userFamily.aboutUs;
    
}

-(void)viewDidLoad
{
    [super viewDidLoad];

    // Change button color
//    _sidebarButton.tintColor = [UIColor colorWithWhite:0.96f alpha:0.2f];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];

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
