//
//  ArtistSongsTableViewController.m
//  myapp
//
//  Created by Daniel Yang on 5/22/14.
//
//

#import "ArtistSongsTableViewController.h"
#import "ArtistObj.h"

@interface ArtistSongsTableViewController ()

@end

@implementation ArtistSongsTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = self.artistName;
    
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"playlist"];
    self.playlist = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    //self.playlist = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"playlist"]];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.songsForAritst.count + 1;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if (indexPath.row == 0){
        cell= [tableView dequeueReusableCellWithIdentifier:@"artistCell" forIndexPath:indexPath];
        cell.textLabel.text = self.artistName;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%d SONGS",self.songsForAritst.count];
        
        CGRect ellipseRect = CGRectMake(0, 0, 50, 50);
        
        UIGraphicsBeginImageContextWithOptions(ellipseRect.size, NO, 0.0f);
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        
        CGContextAddEllipseInRect(ctx, CGRectMake(0, 0, ellipseRect.size.width, ellipseRect.size.height));
        CGContextClip(ctx);
        
        [self.artistImg drawInRect:ellipseRect];
        
        UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        cell.imageView.image = img;
    }else{
        MPMediaItem *song = [self.songsForAritst objectAtIndex:(indexPath.row-1)];
        
        cell= [tableView dequeueReusableCellWithIdentifier:@"songsCell" forIndexPath:indexPath];
        cell.textLabel.text = [song valueForProperty:MPMediaItemPropertyTitle];
        NSInteger duration = [[song valueForProperty:MPMediaItemPropertyPlaybackDuration] integerValue];
        int min = duration / 60;
        NSString * sec;
        if(duration % 60 < 10)
            sec = [NSString stringWithFormat:@"0%d",duration % 60];
        else
            sec = [NSString stringWithFormat:@"%d",duration % 60];
        
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%d:%@", min, sec];
        
        //NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:[song valueForProperty:MPMediaItemPropertyTitle], @"title", [song valueForProperty:MPMediaItemPropertyArtist], @"artist", [song valueForProperty:MPMediaItemPropertyPlaybackDuration], @"duration", [song valueForProperty:MPMediaItemPropertyPersistentID], @"id", @"host", @"origin", nil];
        if([self.playlist containsObject:song])
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
    // Configure the cell...
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0)
        return 65.0;
    else
        return 45.0;
}

// Tap on table Row
- (void) tableView: (UITableView *) tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath {
    // Toggle the "Tick" on and off
    if (indexPath.row > 0){
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        MPMediaItem *song = [self.songsForAritst objectAtIndex:(indexPath.row-1)];
        //NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:[song valueForProperty:MPMediaItemPropertyTitle], @"title", [song valueForProperty:MPMediaItemPropertyArtist], @"artist", [song valueForProperty:MPMediaItemPropertyPlaybackDuration], @"duration", [song valueForProperty:MPMediaItemPropertyPersistentID], @"id", @"host", @"origin", nil];
    
        if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
            cell.accessoryType = UITableViewCellAccessoryNone;
            [self.playlist removeObject:song];
        }else if (cell.accessoryType == UITableViewCellAccessoryNone) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            [self.playlist addObject:song];
        }
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.playlist];
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"playlist"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        // This removes the highlighting of the Cell
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
