//
//  ViewController.m
//  myapp
//
//  Created by Daniel Yang on 5/20/14.
//
//

#import "ViewController.h"
#import "LogInViewController.h"
#import "SignUpViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void) loadView
{
    [super loadView];
    self.view.frame = [UIScreen mainScreen].bounds;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onLogInclicked:(id)sender
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LogInViewController *loginViewController = (LogInViewController *)[mainStoryboard instantiateViewControllerWithIdentifier:@"login"];
    [self presentViewController:loginViewController animated:YES completion:nil];
}

- (IBAction)onSignUpclicked:(id)sender
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SignUpViewController *signupViewController = (SignUpViewController *)[mainStoryboard instantiateViewControllerWithIdentifier:@"signup"];
    [self presentViewController:signupViewController animated:YES completion:nil];
}

@end
