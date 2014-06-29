//
//  HostViewController.m
//  musicapp
//
//  Created by Daniel Yang on 5/20/14.
//
//

#import "HostViewController.h"
#import "KxMenu.h"
#import "PlaylistViewController.h"
#import "EditProfileViewController.h"
#import "LogInViewController.h"
#import "UpcomingViewController.h"

@interface HostViewController ()

@end

@implementation HostViewController

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
    
    UILabel *label = [[UILabel alloc] init];
	label.font = [UIFont fontWithName:@"Roboto-Thin" size: 25.0];
	//[label setBackgroundColor:[UIColor clearColor]];
	[label setTextColor:[UIColor colorWithRed:224.0f/255.0f green:82.0f/255.0f blue:81.0f/255.0f alpha:1.0f]];
	[label setText:@"jooke"];
	[label sizeToFit];
	[self.navigationController.navigationBar.topItem setTitleView:label];
    
    // Initialize the UIButton
    UIImage *buttonImage = [UIImage imageNamed:@"settings.png"];
    UIButton *aButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [aButton setImage:buttonImage forState:UIControlStateNormal];
    aButton.frame = CGRectMake(0.0, 0.0, 25, 25);
    
    // Initialize the UIBarButtonItem
    UIBarButtonItem *aBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:aButton];
    // Set the Target and Action for aButton
    [aButton addTarget:self action:@selector(onSettingsclicked:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = aBarButtonItem;
    
    
    // Initialize the UIButton
    UIImage *backButtonImage = [UIImage imageNamed:@"bacl.png"];
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:backButtonImage forState:UIControlStateNormal];
    backButton.frame = CGRectMake(0.0, 0.0, 25, 25);
    

    // Initialize the backButtonItem
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    // Set the Target and Action for aButton
    [backButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = backButtonItem;
    
    
    self.eventDict = [[NSMutableDictionary alloc] init];
    //create playlist and save to userdefaults
    NSMutableArray *playlist = [[NSMutableArray alloc] init];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:playlist];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"playlist"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(IBAction)back:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onCreatePlaylistclicked:(id)sender
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    PlaylistViewController *playlistViewController = (PlaylistViewController *)[mainStoryboard instantiateViewControllerWithIdentifier:@"playlistController"];
    playlistViewController.hidesBottomBarWhenPushed = TRUE;
    [self.navigationController pushViewController:playlistViewController animated:YES];
}

- (IBAction)onSettingsclicked:(UIButton *)sender
{
    NSArray *menuItems =
    @[
      
      [KxMenuItem menuItem:@"EDIT PROFILE"
                     image:nil
                    target:self
                    action:@selector(pushMenuItem:)],
      
      [KxMenuItem menuItem:@"LOG OUT"
                     image:nil
                    target:self
                    action:@selector(pushMenuItem:)]
      ];
    [KxMenu showMenuInView:self.view
                  fromRect:CGRectMake(sender.frame.origin.x, sender.frame.origin.y-60, 30, 50)
                 menuItems:menuItems];
}

-(IBAction)onCreateEventclicked:(id)sender
{
    if ([self.txtEventName.text length] == 0)
    {
        [[[UIAlertView alloc] initWithTitle:@"Forgot Something" message:@"You need to input event name." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        return;
    }
    [self.eventDict setObject:self.txtEventName.text forKey:@"name"];
    [self.eventDict setObject:@"host" forKey:@"userType"];

    [[NSUserDefaults standardUserDefaults] setObject:self.eventDict forKey:@"Event"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UpcomingViewController *upcomingViewController = (UpcomingViewController *)[mainStoryboard instantiateViewControllerWithIdentifier:@"upcomingViewController"];
    [self presentViewController:upcomingViewController animated:YES completion:nil];
}

-(IBAction)onAddclicked:(id)sender
{
    if([[self.eventDict objectForKey:@"addSong"] isEqualToString:@"1"]){
        [self.btnAdd setBackgroundImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
        [self.eventDict setObject:@"0" forKey:@"addSong"];
    }else{
        [self.btnAdd setBackgroundImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
        [self.eventDict setObject:@"1" forKey:@"addSong"];
    }
}

-(IBAction)onVoteclicked:(id)sender
{
    if([[self.eventDict objectForKey:@"voteSong"] isEqualToString:@"1"]){
        [self.btnVote setBackgroundImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
        [self.eventDict setObject:@"0" forKey:@"voteSong"];
    }else{
        [self.btnVote setBackgroundImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
        [self.eventDict setObject:@"1" forKey:@"voteSong"];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

// Close the keyboard if user clicks outside the keyboard.
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

#pragma mark - private

- (void) pushMenuItem:(KxMenuItem *)sender
{
    if ([sender.title isEqualToString:@"EDIT PROFILE"])
    {
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        EditProfileViewController *editprofileViewController = (EditProfileViewController *)[mainStoryboard instantiateViewControllerWithIdentifier:@"profileController"];
        editprofileViewController.hidesBottomBarWhenPushed = TRUE;
        [self.navigationController pushViewController:editprofileViewController animated:YES];
    }
    else
    {
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        LogInViewController *loginViewController = (LogInViewController *)[mainStoryboard instantiateViewControllerWithIdentifier:@"login"];
        [self presentViewController:loginViewController animated:YES completion:nil];

    }
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
