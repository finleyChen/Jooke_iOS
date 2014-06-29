//
//  SignUpViewController.m
//  musicapp
//
//  Created by Daniel Yang on 5/19/14.
//
//

#import "SignUpViewController.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController

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
    
    //NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Quicksand-Light" size:18], NSFontAttributeName, [UIColor whiteColor], NSForegroundColorAttributeName, nil];
    //[[UINavigationBar appearance] setTitleTextAttributes:attributes];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onSignUpclicked:(id)sender
{
    [self postJson:0];
}

- (IBAction)onFBclicked:(id)sender
{
    
}

- (IBAction)onTWclicked:(id)sender
{
    
}

- (IBAction)onAddPictureclicked:(id)sender
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.allowsEditing = YES;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    if(![self.txtName.text isEqualToString:@""] && ![self.txtEmail.text isEqualToString:@""] && ![self.txtPassword.text isEqualToString:@""])
    {
        self.toolbar.hidden = FALSE;
    }
    else {
        self.toolbar.hidden = TRUE;
    }
    return YES;
}

// Close the keyboard if user clicks outside the keyboard.
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if(![self.txtName.text isEqualToString:@""] && ![self.txtEmail.text isEqualToString:@""] && ![self.txtPassword.text isEqualToString:@""])
    {
        self.toolbar.hidden = FALSE;
    }
    else {
        self.toolbar.hidden = TRUE;
    }
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

#pragma mark - imagepickercontroller delegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // Code here to work with media
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - private

- (void) postJson:(int)type
{
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d",type], @"signup_type", self.txtEmail.text, @"email", @"", @"thirdparty_id", self.txtPassword.text, @"pasword", self.txtName.text, @"fullname", @"", @"profile_img", nil];
    
    NSData *jsonData;
    
    if ([NSJSONSerialization isValidJSONObject:dictionary]) {
        
        NSError *error;
        jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:&error];
        NSLog(@"data string: %@", [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]);
        
        /*if (error == nil && jsonData != nil) {
         return jsonData;
         } else {
         NSLog(@"Error creating JSON data: %@", error);
         return nil;
         }*/
        
    }
    
    NSURL *url = [NSURL URLWithString:@"http://jookee-env.elasticbeanstalk.com/signup"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%d", [jsonData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody: jsonData];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
        NSLog(@"D1: responseCode: %d", responseCode);
        if (!connectionError && responseCode == 200) {
            if (data)
                NSLog(@"data string: %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
            else
                NSLog(@"data is nil");
            
            NSError *parseError = nil;
            NSDictionary *allInDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&parseError];
            
            if ([allInDic[@"success"] integerValue] == 0) {
                UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                UITabBarController *tabViewController = (UITabBarController *)[mainStoryboard instantiateViewControllerWithIdentifier:@"hostjoincontroller"];
                [self presentViewController:tabViewController animated:YES completion:nil];
            }
        }
        else
        {
            NSLog(@"connectionError=%@", connectionError);
            NSLog(@"responseCode=%d", responseCode);
        }
    }];
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
