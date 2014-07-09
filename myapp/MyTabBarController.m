//
//  MyTabBarController.m
//  myapp
//
//  Created by Daniel Yang on 5/20/14.
//
//

#import "MyTabBarController.h"

@interface MyTabBarController ()

@end

@implementation MyTabBarController

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
    
    //set the tab bar title appearance for normal state
    [[UITabBarItem appearance]
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:224.0f/255.0f green:182.0f/255.0f blue:181.0f/255.0f alpha:1.0f], NSFontAttributeName:[UIFont fontWithName:@"GillSans-Light" size: 18.0]}
     forState:UIControlStateNormal];
    
    //set the tab bar title appearance for selected state
    [[UITabBarItem appearance]
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:224.0f/255.0f green:82.0f/255.0f blue:81.0f/255.0f alpha:1.0f], NSFontAttributeName:[UIFont fontWithName:@"GillSans-Bold" size: 28.0]}
     forState:UIControlStateSelected];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
