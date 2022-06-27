//
//  ViewController.m
//  Instagram
//
//  Created by Archita Singh on 6/27/22.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *signupButton;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
- (IBAction)registerUser:(id)sender;
- (IBAction)loginUser:(id)sender;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (IBAction)loginUser:(id)sender {
    NSString *username = self.usernameField.text;
    NSString *password = self.passwordField.text;
        
        [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
            if (error != nil) {
                NSLog(@"User log in failed: %@", error.localizedDescription);
                if ([self.usernameField.text isEqual:@""] || [self.passwordField.text isEqual:@""]) {
                    [self alert];
                }
            } else {
                NSLog(@"User logged in successfully");
                [self performSegueWithIdentifier:@"loginSegue" sender:nil];
            }
        }];
}

- (IBAction)registerUser:(id)sender {
    // initialize a user object
        PFUser *newUser = [PFUser user];
        
        // set user properties
        newUser.username = self.usernameField.text;
        newUser.password = self.passwordField.text;
        
        // call sign up function on the object
        [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
            if (error != nil) {
                NSLog(@"Error: %@", error.localizedDescription);
                if ([self.usernameField.text isEqual:@""] || [self.passwordField.text isEqual:@""]) {
                    [self alert];
                }
            } else {
                NSLog(@"User registered successfully");
                [self performSegueWithIdentifier:@"loginSegue" sender:nil];
            }
        }];
}

- (void) alert {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Empty Fields Alert"
                                message:@"You have submitted one or more empty fields. Please enter at least 1 character for username/password and try again."
                                preferredStyle:(UIAlertControllerStyleAlert)];
   
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                    style:UIAlertActionStyleCancel
                                    handler:^(UIAlertAction * _Nonnull action) {
                                                             
                                    }];
    
    [alert addAction:cancelAction];

    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
                                                     }];
    [alert addAction:okAction];
    
    [self presentViewController:alert animated:YES completion:^{
    }];
}

@end
