//
//  EditProfileViewController.h
//  myapp
//
//  Created by Daniel Yang on 5/22/14.
//
//

#import <UIKit/UIKit.h>

@interface EditProfileViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *lblJoinDate;

@end
