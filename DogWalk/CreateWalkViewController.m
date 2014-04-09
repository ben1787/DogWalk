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

@interface CreateWalkViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UISegmentedControl *walkTypeSelector;
@property (weak, nonatomic) IBOutlet UISlider *walkSizeSlider;
@property (weak, nonatomic) IBOutlet UITextField *timeField;
@property (weak, nonatomic) IBOutlet UISlider *walkLengthSlider;
@property (strong, nonatomic) UIDatePicker *datePicker;

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

@end
