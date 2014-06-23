//
//  SignUpViewController.h
//  musicapp
//
//  Created by Daniel Yang on 5/19/14.
//
//

#import <UIKit/UIKit.h>

@interface SignUpViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;

-(IBAction)onSignUpclicked:(id)sender;
-(IBAction)onFBclicked:(id)sender;
-(IBAction)onTWclicked:(id)sender;
-(IBAction)onAddPictureclicked:(id)sender;

@end
