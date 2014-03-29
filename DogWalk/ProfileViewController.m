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

    [self updateUIData];

}


@end
