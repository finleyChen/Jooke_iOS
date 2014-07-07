//
//  LogInViewController.m
//  musicapp
//
//  Created by Daniel Yang on 5/19/14.
//
//

#import "LogInViewController.h"

@interface LogInViewController ()

@end

@implementation LogInViewController

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
    // Do any additional setup after loading the view.

}

-(void) viewWillAppear:(BOOL)animated {
    
    UINavigationBar *myNav = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, [UIApplication sharedApplication].statusBarFrame.size.height, [UIApplication sharedApplication].statusBarFrame.size.width, 40)];
    [self.view addSubview:myNav];
    
    [myNav setBackgroundImage:[UIImage new]forBarMetrics:UIBarMetricsDefault];
    myNav.shadowImage = [UIImage new];
    myNav.translucent = YES;
    
    // Initialize the backButton
    UIImage *backButtonImage = [UIImage imageNamed:@"bacl.png"];
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:backButtonImage forState:UIControlStateNormal];
    backButton.frame = CGRectMake(0.0, 0.0, 25, 25);
    
    
    // Initialize the backButtonItem
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    // Set the Target and Action for backButton
    [backButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    
    UINavigationItem *navigItem = [UINavigationItem alloc];

    
    navigItem.leftBarButtonItem = backButtonItem;
    myNav.items = [NSArray arrayWithObjects: navigItem,nil];
    
    /* IF YOU WANT JOOKE TITLE AT TOP
    UILabel *label = [[UILabel alloc] init];
	label.font = [UIFont fontWithName:@"Roboto-Thin" size: 25.0];
	//[label setBackgroundColor:[UIColor clearColor]];
	[label setTextColor:[UIColor colorWithRed:224.0f/255.0f green:82.0f/255.0f blue:81.0f/255.0f alpha:1.0f]];
	[label setText:@"jooke"];
	[label sizeToFit];
	[myNav.topItem setTitleView:label];
     */
}

-(IBAction)back:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onLogInclicked:(id)sender
{
    [self postJson:0];
}

- (IBAction)onFBclicked:(id)sender
{
    
}

- (IBAction)onTWclicked:(id)sender
{
    
}

- (IBAction)onForgotclicked:(id)sender
{
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    if(![self.txtEmail.text isEqualToString:@""] && ![self.txtPassword.text isEqualToString:@""]){
        self.toolbar.hidden = FALSE;
    }
    else {
        self.toolbar.hidden = TRUE;
    }
    return YES;
}

// Close the keyboard if user clicks outside the keyboard.
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if(![self.txtEmail.text isEqualToString:@""] && ![self.txtPassword.text isEqualToString:@""]) {
        self.toolbar.hidden = FALSE;
    }
    else {
        self.toolbar.hidden = TRUE;
    }
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

#pragma mark - private

- (void) postJson:(int)type
{
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d",type], @"login_type", self.txtEmail.text, @"email", @"", @"thirdparty_id", self.txtPassword.text, @"pasword", @"", @"fullname", @"", @"profile_img", nil];
                        
    NSData *jsonData;
    
    if ([NSJSONSerialization isValidJSONObject:dictionary]) {
        
        NSError *error;
        jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:&error];
        
        /*if (error == nil && jsonData != nil) {
            return jsonData;
        } else {
            NSLog(@"Error creating JSON data: %@", error);
            return nil;
        }*/
        
    }
                        
    NSURL *url = [NSURL URLWithString:@"http://jooketest-env.elasticbeanstalk.com/login"];
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
