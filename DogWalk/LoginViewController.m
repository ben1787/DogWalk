//
//  LoginViewController.m
//  DogWalk
//
//  Created by Development on 3/19/14.
//  Copyright (c) 2014 Development. All rights reserved.
//

#import "LoginViewController.h"
#import "TabBarViewController.h"

@interface LoginViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;

@end

@implementation LoginViewController

#define INVALID_CREDENTIALS @"Invalid Credentials"
#define INVALID_CREDENTIALS_TEXT @"Incorrect username and/or password"
#define EMPTY_STRING @""
#define OK @"OK"
#define USERNAME @"username"
#define PASSWORD @"password"

-(void)setUsername:(UITextField *)username {
    _username = username;
    username.delegate = self;
}

-(void)setPassword:(UITextField *)password {
    _password = password;
    password.delegate = self;
}
- (IBAction)attemptLogin:(UIButton *)sender {
    BOOL validPassword = [[self class] validatePassword:self.password.text ForUsername:self.username.text];
    if(validPassword) {
        UICKeyChainStore *store = [UICKeyChainStore keyChainStoreWithService:@"DogWalk"];
        [store setString:self.username.text forKey:@"username"];
        [store setString:self.password.text forKey:@"password"];
        [store synchronize];
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:INVALID_CREDENTIALS message:INVALID_CREDENTIALS_TEXT delegate:nil cancelButtonTitle:OK otherButtonTitles:nil, nil];
        [alert show];
        self.password.text = EMPTY_STRING;
        
        [self.username resignFirstResponder];
        [self.password resignFirstResponder];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

+(BOOL)validatePassword:(NSString *)password ForUsername:(NSString *)username {
    //should ask the server to validate the password
    if ([username isEqualToString:@"Peter"] && [password isEqualToString:@"Brian"]) {
        return TRUE;
    }
    
    return FALSE;
}

@end
