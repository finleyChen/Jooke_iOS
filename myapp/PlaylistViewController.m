//
//  PlaylistViewController.m
//  myapp
//
//  Created by Daniel Yang on 5/20/14.
//
//

#import "PlaylistViewController.h"
#import "ArtistSongsTableViewController.h"

@interface PlaylistViewController ()

@end

@implementation PlaylistViewController

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
    self.title = @"PLAYLIST";
    
    MPMediaQuery *everything = [[MPMediaQuery alloc] init];
    NSArray *itemsFromGenericQuery = [everything items];
    self.artistsDictionary = [NSMutableDictionary dictionary];
    self.artistsArray = [NSMutableArray array];
    
    for(int i=0; i<itemsFromGenericQuery.count; i++){
        
        MPMediaItem *song = [itemsFromGenericQuery objectAtIndex:i];
        NSString *artistName = [song valueForProperty:MPMediaItemPropertyArtist];
        
        // Eric added to fix forKey is nil exception
        if (!artistName)
            artistName = @"Unknown Artist";
        
        // Add the song to the array of songs for that artist.
        NSMutableArray *songsForArtist = [self.artistsDictionary objectForKey:artistName];
        if(!songsForArtist)
            songsForArtist = [NSMutableArray array];
        [songsForArtist addObject:song];
        [self.artistsDictionary setObject:songsForArtist forKey:artistName];
        
        // Add the artist if needed.
        if(![self.artistsArray containsObject:artistName]) {
            [self.artistsArray addObject:artistName];
            [self.artistsArray sortUsingSelector:@selector(compare:)];
        }
        
    }
    
    // Keep track of the first letters of artists for section organization.
    self.firstLetterDict = [NSMutableDictionary dictionary];
    for (int i=0; i<self.artistsArray.count; i++){
        NSString *artistNameFirstLetter = [[self.artistsArray objectAtIndex:i] substringToIndex:1];
        
        // If we havent seen this first letter yet.
        if([self.firstLetterDict objectForKey:artistNameFirstLetter] == nil) {
            NSMutableArray* artistsWithLetter = [NSMutableArray array];
            [artistsWithLetter addObject:[self.artistsArray objectAtIndex:i]];
            self.firstLetterDict[artistNameFirstLetter] = artistsWithLetter;
        }
        
        // Else, add the artist to the array of artists with this first letter.
        else {
            NSMutableArray* artistsWithLetter = [self.firstLetterDict objectForKey:artistNameFirstLetter];
            [artistsWithLetter addObject:[self.artistsArray objectAtIndex:i]];
            [artistsWithLetter sortUsingSelector:@selector(compare:)];
            [self.firstLetterDict setObject:artistsWithLetter forKey:artistNameFirstLetter];
        }
    }
    
    self.firstLetterArray = [[self.firstLetterDict allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];

    // Do any additional setup after loading the view.
    // Initialize the backButton
    UIImage *backButtonImage = [UIImage imageNamed:@"bacl.png"];
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:backButtonImage forState:UIControlStateNormal];
    backButton.frame = CGRectMake(0.0, 0.0, 25, 25);
    
    
    // Initialize the backButtonItem
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    // Set the Target and Action for backButton
    [backButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = backButtonItem;
}

-(IBAction)back:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"playlist"];
    NSMutableArray *playlist = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    self.lblSelected.text = [NSString stringWithFormat:@"SELECTED %d", playlist.count];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onDoneclicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections. We are sorting by first letter.
    return self.firstLetterArray.count;
    //return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section,
    // which is the number of artists with this first letter.
    //return self.artistsArray.count;
    NSString *firstLetterSection = [self.firstLetterArray objectAtIndex:section];
    NSArray *sectionArtists = [self.firstLetterDict objectForKey:firstLetterSection];
    return [sectionArtists count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"cell refresh (%@)", indexPath);
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Get the artist name.
    NSString *firstLetterSection = [self.firstLetterArray objectAtIndex:indexPath.section];
    NSArray *sectionArtists = [self.firstLetterDict objectForKey:firstLetterSection];
    NSString *artistName = [sectionArtists objectAtIndex:indexPath.row];
    
    NSMutableArray *songsForArtist = [self.artistsDictionary objectForKey:artistName];
    //ArtistObj *artistObject = [artistsForLetter objectAtIndex:indexPath.row];
    //NSString *artistName = [self.artistsArray objectAtIndex:indexPath.section];
    
    cell.textLabel.text = artistName;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d SONGS",songsForArtist.count];
    
    CGRect ellipseRect = CGRectMake(0, 0, 50, 50);
    
    UIGraphicsBeginImageContextWithOptions(ellipseRect.size, NO, 0.0f);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextAddEllipseInRect(ctx, CGRectMake(0, 0, ellipseRect.size.width, ellipseRect.size.height));
    CGContextClip(ctx);
    
    UIImage *artworkImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[[artistName substringToIndex:1] lowercaseString]]];
    [artworkImage drawInRect:ellipseRect];
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    
    cell.imageView.image = img;
    
    MPMediaItemArtwork *artwork;
    artwork = [[songsForArtist objectAtIndex:0] valueForProperty: MPMediaItemPropertyArtwork];

    img = [artwork imageWithSize: CGSizeMake (50, 50)];
    int i = 1;
    while (i < songsForArtist.count && !img ) {
        artwork = [[songsForArtist objectAtIndex:i] valueForProperty: MPMediaItemPropertyArtwork];
        i++;
        img = [artwork imageWithSize: CGSizeMake (50, 50)];
    }
    // Configure the cell...
    if (img) {
        [img drawInRect:ellipseRect];
        img = UIGraphicsGetImageFromCurrentImageContext();
        cell.imageView.image = img;
    }
    UIGraphicsEndImageContext();
    // Configure the cell...
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.firstLetterArray objectAtIndex:section];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.firstLetterArray;
}

- (NSInteger) tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return [self.firstLetterArray indexOfObject:title];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    NSIndexPath *selectedIndexPath = [self. tableView indexPathForSelectedRow];
    NSString *firstLetterSection = [self.firstLetterArray objectAtIndex:selectedIndexPath.section];
    NSArray *sectionArtists = [self.firstLetterDict objectForKey:firstLetterSection];
    NSString *artistName = [sectionArtists objectAtIndex:selectedIndexPath.row];
    NSMutableArray *songsForArtist = [self.artistsDictionary objectForKey:artistName];
    
    //UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:selectedIndexPath];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:selectedIndexPath];

    self.songsTableViewcontroller = segue.destinationViewController;
    self.songsTableViewcontroller.artistName = artistName;
    self.songsTableViewcontroller.artistImg = [UIImage imageWithCGImage:cell.imageView.image.CGImage];
    self.songsTableViewcontroller.songsForArtist = songsForArtist;
}


@end
