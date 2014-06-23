//
//  LogInViewController.h
//  musicapp
//
//  Created by Daniel Yang on 5/19/14.
//
//

#import <UIKit/UIKit.h>

@interface LogInViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;

-(IBAction)onLogInclicked:(id)sender;
-(IBAction)onFBclicked:(id)sender;
-(IBAction)onTWclicked:(id)sender;
-(IBAction)onForgotclicked:(id)sender;

@end
