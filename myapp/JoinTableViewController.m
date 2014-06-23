//
//  EventsTableViewController.m
//  musicapp
//
//  Created by Daniel Yang on 5/20/14.
//
//

#import "JoinTableViewController.h"
#import "UpcomingViewController.h"

@interface JoinTableViewController ()

@end

@implementation JoinTableViewController

/*- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}*/

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
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

/*- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}*/

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Configure the cell...
    static NSString *CellIdentifier = @"Cell";
    /*UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = @"Let's Rock";
    cell.detailTextLabel.text = @"JJMA";
    
    CGRect ellipseRect = CGRectMake(0, 0, 50, 50);
    
    UIGraphicsBeginImageContextWithOptions(ellipseRect.size, NO, 0.0f);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextAddEllipseInRect(ctx, CGRectMake(0, 0, ellipseRect.size.width, ellipseRect.size.height));
    CGContextClip(ctx);
    
    [[UIImage imageNamed:@"rihanna.jpg"] drawInRect:ellipseRect];
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    cell.imageView.image = img;
    return cell;*/
    
    SWTableViewCell *cell = (SWTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
        
    [rightUtilityButtons sw_addUtilityButtonWithColor:[UIColor colorWithRed:0.78f green:0.78f blue:0.8f alpha:1.0] title:@"INFO"];
    [rightUtilityButtons sw_addUtilityButtonWithColor:[UIColor colorWithRed:1.0f green:0.231f blue:0.188 alpha:1.0f] title:@"JOIN"];
    
    cell.rightUtilityButtons = rightUtilityButtons;
    cell.delegate = self;
        /*cell = [[SWTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:CellIdentifier
                                  containingTableView:tableView // For row height and selection
                                   leftUtilityButtons:nil
                                  rightUtilityButtons:rightUtilityButtons];*/
    
    cell.textLabel.text = @"Let's Rock";
    cell.detailTextLabel.text = @"JJMA";
    
    CGRect ellipseRect = CGRectMake(0, 0, 50, 50);
    
    UIGraphicsBeginImageContextWithOptions(ellipseRect.size, NO, 0.0f);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextAddEllipseInRect(ctx, CGRectMake(0, 0, ellipseRect.size.width, ellipseRect.size.height));
    CGContextClip(ctx);
    
    [[UIImage imageNamed:@"rihanna.jpg"] drawInRect:ellipseRect];
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    cell.imageView.image = img;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!tableView.isEditing) {
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

#pragma mark - SWTableViewDelegate

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerLeftUtilityButtonWithIndex:(NSInteger)index {
    NSLog(@"asbc");
}

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index {
    switch (index) {
        case 0:
        {
            NSLog(@"More button was pressed");
            break;
        }
        case 1:
        {
            // Delete button was pressed
            //NSIndexPath *cellIndexPath = [self.tableView indexPathForCell:cell];
            self.eventDict = [[NSMutableDictionary alloc] init];
            [self.eventDict setObject:@"Let's Rock" forKey:@"name"];
            [self.eventDict setObject:@"join" forKey:@"userType"];
            [[NSUserDefaults standardUserDefaults] setObject:self.eventDict forKey:@"Event"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
             UpcomingViewController *upcomingViewController = (UpcomingViewController *)[mainStoryboard instantiateViewControllerWithIdentifier:@"upcomingViewController"];
             [self presentViewController:upcomingViewController animated:YES completion:nil];
        }
        default:
            break;
    }
}

// prevent multiple cells from showing utilty buttons simultaneously
- (BOOL)swipeableTableViewCellShouldHideUtilityButtonsOnSwipe:(SWTableViewCell *)cell {
    return YES;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    //NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
    //NSString *sectionHeader = [self.firstLettersArray objectAtIndex:selectedIndexPath.section];
    //NSMutableArray *artistsForSection = [self.artistsDictionary objectForKey:sectionHeader];
    //ArtistObj *artistObject = [artistsForSection objectAtIndex:selectedIndexPath.row];

    //self.eventViewcontroller = segue.destinationViewController;
    //self.songsTableViewcontroller.artistObject = artistObject;
}

@end
