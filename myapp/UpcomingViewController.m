//
//  UpcomingViewController.m
//  myapp
//
//  Created by Daniel Yang on 5/24/14.
//
//

#import "UpcomingViewController.h"
#import "SongObj.h"

@interface UpcomingViewController ()

@end

@implementation UpcomingViewController

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
    self.eventInfo = [[NSUserDefaults standardUserDefaults] objectForKey:@"Event"];
    self.lblTitle.text = [self.eventInfo objectForKey:@"name"];
    self.userType = [self.eventInfo objectForKey:@"userType"];
    
    if ([self.userType isEqualToString:@"host"]){
        NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"playlist"];
        NSMutableArray *playlist = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        if(playlist.count == 0) return;
        NSURL *url = [[playlist objectAtIndex:0] valueForProperty:MPMediaItemPropertyAssetURL];
        
        self.lblPArtist.text = [[playlist objectAtIndex:0] valueForProperty:MPMediaItemPropertyArtist];
        self.lblPSongName.text = [[playlist objectAtIndex:0] valueForProperty:MPMediaItemPropertyTitle];
        UIImage *artworkImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[[self.lblPArtist.text substringToIndex:1] lowercaseString]]];
        MPMediaItemArtwork *artwork = [[playlist objectAtIndex:0] valueForProperty: MPMediaItemPropertyArtwork];
        if (artwork) {
            //artworkImage = [artwork imageWithSize: CGSizeMake (50, 50)];
        }
        self.imagePlaying.image = artworkImage;
        
        /*int duration = [[[playlist objectAtIndex:0] valueForProperty:MPMediaItemPropertyPlaybackDuration] intValue];
        for (int i=duration; i>=0; i--){
            int min = i / 60;
            NSString * sec;
            if((i % 60) < 10)
                sec = [NSString stringWithFormat:@"0%d",i%60];
            else
                sec = [NSString stringWithFormat:@"%d",i%60];
            self.lblPTime.text = [NSString stringWithFormat:@"%d:%@",min,sec];
            sleep(1);
        }*/
        /*int min = song11.duration / 60;
        NSString * sec;
        if((song11.duration % 60) < 10)
            sec = [NSString stringWithFormat:@"0%d",song11.duration%60];
        else
            sec = [NSString stringWithFormat:@"%d",song11.duration%60];
        self.lblPTime.text = [NSString stringWithFormat:@"%d:%@",min,sec];*/
        
        // Play the item using AVPlayer
        self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        [self.player play];
    }
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onSettingsclicked:(UIButton *)sender
{
/*    NSString *exitStr;
    NSArray *menuItems;
    
    if ([[self.eventInfo objectForKey:@"userType"] isEqualToString:@"host"])
        exitStr = @"END EVENT";
    else
        exitStr = @"EXIT EVENT";
    
    if (([[self.eventInfo objectForKey:@"addSong"] integerValue] == 0) && ([exitStr isEqualToString:@"EXIT EVENT"])){
        menuItems = @[
          [KxMenuItem menuItem:@"PLAYLIST"
                     image:nil
                    target:self
                    action:@selector(pushMenuItem:)],
      
          [KxMenuItem menuItem:@"VIEW PEOPLE"
                     image:nil
                    target:self
                    action:@selector(pushMenuItem:)],
      
          [KxMenuItem menuItem:exitStr
                     image:nil
                    target:self
                    action:@selector(pushMenuItem:)]
        ];
    }else{
        menuItems = @[
          [KxMenuItem menuItem:@"PLAYLIST"
                                     image:nil
                                    target:self
                                    action:@selector(pushMenuItem:)],
          
          [KxMenuItem menuItem:@"ADD SONG"
                         image:nil
                        target:self
                        action:@selector(pushMenuItem:)],
          
          [KxMenuItem menuItem:@"VIEW PEOPLE"
                         image:nil
                        target:self
                        action:@selector(pushMenuItem:)],
          
          [KxMenuItem menuItem:exitStr
                         image:nil
                        target:self
                        action:@selector(pushMenuItem:)]
        ];
    }
    [KxMenu showMenuInView:self.view
                  fromRect:CGRectMake(sender.frame.origin.x, sender.frame.origin.y-35, 30, 50)
                 menuItems:menuItems];*/
}

#pragma mark - private
/*
- (void) pushMenuItem:(KxMenuItem *)sender
{
    if ([sender.title isEqualToString:@"PLAYLIST"])
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
*/

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    SongObj *songObject = [self.songsDictionary objectForKey:[NSString stringWithFormat:@"%d",indexPath.row + 1]];
    
    cell.textLabel.text = songObject.artist;
    cell.detailTextLabel.numberOfLines = 2;
    int min = songObject.duration / 60;
    NSString * sec;
    if((songObject.duration % 60) < 10)
        sec = [NSString stringWithFormat:@"0%d",songObject.duration%60];
    else
        sec = [NSString stringWithFormat:@"%d",songObject.duration%60];
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@\r%d:%@",songObject.name, min,sec];
    UILabel *lblSelector = [[cell.contentView subviews] objectAtIndex:2];
    lblSelector.text = songObject.selector;
    UILabel *lblNum = [[cell.contentView subviews] objectAtIndex:3];
    lblNum.text = [NSString stringWithFormat:@"%d",indexPath.row+1];
    
    CGRect ellipseRect = CGRectMake(0, 0, 40, 40);
    
    UIGraphicsBeginImageContextWithOptions(ellipseRect.size, NO, 0.0f);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextAddEllipseInRect(ctx, CGRectMake(0, 0, ellipseRect.size.width, ellipseRect.size.height));
    CGContextClip(ctx);
    
    [[UIImage imageNamed:songObject.artist] drawInRect:ellipseRect];
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    cell.imageView.image = img;
    // Configure the cell...
    
    return cell;
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
