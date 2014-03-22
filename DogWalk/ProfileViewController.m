//
//  ViewController.m
//  DogWalk
//
//  Created by Development on 3/4/14.
//  Copyright (c) 2014 Development. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController ()
@property (weak, nonatomic) IBOutlet UILabel *names;
@property (weak, nonatomic) IBOutlet UITextView *aboutUs;
@property (strong, nonatomic) NSArray *profilePhotos;
@end

@implementation ProfileViewController

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
    [self updateUIData];

}


@end
