//
//  CreateWalkViewController.m
//  DogWalk
//
//  Created by Development on 4/7/14.
//  Copyright (c) 2014 Development. All rights reserved.
//

#import "CreateWalkViewController.h"
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "InvitationsTableViewController.h"

@interface CreateWalkViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UISegmentedControl *walkTypeSelector;
@property (weak, nonatomic) IBOutlet UISlider *walkSizeSlider;
@property (weak, nonatomic) IBOutlet UITextField *timeField;
@property (weak, nonatomic) IBOutlet UISlider *walkLengthSlider;
@property (strong, nonatomic) UIDatePicker *datePicker;
@property (strong, nonatomic) NSArray *invitedPlaypals;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation CreateWalkViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //setting fontsize in selector
    UIFont *font = [UIFont boldSystemFontOfSize:10];
    NSDictionary *titleAttributes = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    [self.walkTypeSelector setTitleTextAttributes:titleAttributes forState:UIControlStateNormal];
    
    //set nav bar color
    [self.navigationController.navigationBar setBackgroundColor:[UIColor blueColor]];
    
    //set date picker to be the input fields first responder
    _datePicker = [[UIDatePicker alloc] init];
    self.timeField.inputView = self.datePicker;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(dismissTimePicker)];
    
    [self.view addGestureRecognizer:tap];
    self.timeField.delegate = self;
    
    self.scrollView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, 450);
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMM dd, YYYY HH:mm"];
    self.timeField.text = [dateFormatter stringFromDate:self.datePicker.date];
    return YES;	
    
}

-(void)dismissTimePicker
{
    [self.timeField resignFirstResponder];
}

- (IBAction)roundGroupSize:(UISlider *)sender {
    [sender setValue:round(sender.value) animated:YES];
}


#pragma mark Invitation Unwind

-(IBAction)retrieveInvitations:(UIStoryboardSegue *)segue
{
    if([segue.sourceViewController isKindOfClass:[InvitationsTableViewController class]]) {
        InvitationsTableViewController *itvc = (InvitationsTableViewController *)segue.sourceViewController;
        
        self.invitedPlaypals = itvc.invitedPlaypals;
        
        [self updateInviteImages];
    }
}

-(void)updateInviteImages
{
    for (int i = 1; i<=[self.invitedPlaypals count]; i++) {
        int width = (self.scrollView.frame.size.width - 62)/4;
        CGRect frame = CGRectMake(width*(i-1)+62, 401 - width/6, width*2/3, width*2/3);
        UIImageView *playpal = [[UIImageView alloc] initWithFrame:frame];
        playpal.image = [UIImage imageNamed:@"Peter_Brian"];
        CALayer *imageLayer = playpal.layer;
        [imageLayer setCornerRadius:25];
        [imageLayer setBorderWidth:2];
        [imageLayer setBorderColor:[[UIColor lightGrayColor] CGColor]];
        [imageLayer setMasksToBounds:YES];
        [self.scrollView addSubview:playpal];
    }
}

@end
