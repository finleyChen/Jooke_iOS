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

-(void) viewWillAppear:(BOOL)animated {
    
    UINavigationBar *myNav = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, [UIApplication sharedApplication].statusBarFrame.size.height, [UIApplication sharedApplication].statusBarFrame.size.width, 60)];
    [self.view addSubview:myNav];
    
    [myNav setBackgroundImage:[UIImage new]forBarMetrics:UIBarMetricsDefault];
    myNav.shadowImage = [UIImage new];
    myNav.translucent = YES;

    
    UINavigationItem *navigItem = [UINavigationItem alloc];
    
    UILabel *label = [[UILabel alloc] init];
	label.font = [UIFont fontWithName:@"Roboto-Thin" size: 40.0];
	//[label setBackgroundColor:[UIColor clearColor]];
	[label setTextColor:[UIColor colorWithRed:224.0f/255.0f green:82.0f/255.0f blue:81.0f/255.0f alpha:1.0f]];
	[label setText:@"jooke"];
	[label sizeToFit];
    navigItem.titleView = label;
    myNav.items = [NSArray arrayWithObjects: navigItem,nil];
	//[myNav.topItem setTitleView:label];
    

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
