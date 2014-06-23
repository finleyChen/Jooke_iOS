//
//  EditProfileViewController.m
//  myapp
//
//  Created by Daniel Yang on 5/22/14.
//
//

#import "EditProfileViewController.h"

@interface EditProfileViewController ()

@end

@implementation EditProfileViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.tabBarController.tabBar.hidden = TRUE;
    self.navigationItem.leftBarButtonItem.title = @"";
    
    self.title = @"DANIEL YANG";
    self.txtName.text = @"Daniel Yang";
    
    CGRect ellipseRect = CGRectMake(0, 0, 50, 50);
    
    UIGraphicsBeginImageContextWithOptions(ellipseRect.size, NO, 0.0f);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextAddEllipseInRect(ctx, CGRectMake(0, 0, ellipseRect.size.width, ellipseRect.size.height));
    CGContextClip(ctx);
    
    NSString *imageName = [NSString stringWithFormat:@"%@.png",[[self.txtName.text substringToIndex:1] lowercaseString]];
    [[UIImage imageNamed:imageName] drawInRect:ellipseRect];
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.profileImage.image = img;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapped:)];
    singleTap.numberOfTapsRequired = 1;
    singleTap.numberOfTouchesRequired = 1;
    [self.profileImage addGestureRecognizer:singleTap];
    [self.profileImage setUserInteractionEnabled:YES];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)imageTapped:(UIGestureRecognizer *)gestureRecognizer {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.allowsEditing = YES;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

#pragma mark - imagepickercontroller delegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // Code here to work with media
    UIImage *proImg = [info objectForKey:UIImagePickerControllerOriginalImage];
    CGRect ellipseRect = CGRectMake(0, 0, 50, 50);
    
    UIGraphicsBeginImageContextWithOptions(ellipseRect.size, NO, 0.0f);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextAddEllipseInRect(ctx, CGRectMake(0, 0, ellipseRect.size.width, ellipseRect.size.height));
    CGContextClip(ctx);
    
    [proImg drawInRect:ellipseRect];
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.profileImage.image = img;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
