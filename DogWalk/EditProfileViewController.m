//
//  EditProfileViewController.m
//  DogWalk
//
//  Created by Development on 3/5/14.
//  Copyright (c) 2014 Development. All rights reserved.
//

#import "EditProfileViewController.h"

@interface EditProfileViewController () <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation EditProfileViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    
    // prevents the scroll view from swallowing up the touch event of child buttons
    tapGesture.cancelsTouchesInView = NO;
    
    [self.scrollView addGestureRecognizer:tapGesture];
    
    // setup the input fields with the current values
    self.aboutUs.text = self.userFamily.aboutUs;
    self.ownerName.text = self.userFamily.owner.name;
    self.dogName.text = ((Dog *)[self.userFamily.dogs anyObject]).name;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self registerForKeyboardNotifications];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [self deregisterFromKeyboardNotifications];
    
    [super viewWillDisappear:animated];
}

# pragma mark keyboard notifications
#define PUSHUP_HEIGHT 25

-(void)hideKeyboard
{
    [self.aboutUs resignFirstResponder];
    [self.scrollView setContentOffset:CGPointMake(0.0, 0.0) animated:YES];
}

-(void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
}

-(void)deregisterFromKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardDidShowNotification
                                                  object:nil];
}

-(void)keyboardWillShow:(NSNotification *)notification
{
    CGRect bkgndRect = self.aboutUs.superview.frame;
    bkgndRect.size.height += PUSHUP_HEIGHT;
    [self.aboutUs.superview setFrame:bkgndRect];
    [self.scrollView setContentOffset:CGPointMake(0.0, PUSHUP_HEIGHT) animated:YES];
}

- (IBAction)saveEdits {
}

- (IBAction)cancel {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)addPhoto {
}

@end
