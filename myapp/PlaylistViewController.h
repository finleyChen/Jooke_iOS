//
//  PlaylistViewController.h
//  myapp
//
//  Created by Daniel Yang on 5/20/14.
//
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
@class ArtistSongsTableViewController;

@interface PlaylistViewController : UIViewController

@property (nonatomic, strong) ArtistSongsTableViewController *songsTableViewcontroller;
@property (nonatomic, strong) NSMutableDictionary *artistsDictionary;
@property (nonatomic, strong) NSMutableArray *artistsArray;
@property (nonatomic, strong) NSArray *firstLetterArray;
@property (nonatomic, strong) NSMutableDictionary *firstLetterDict;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *lblSelected;

- (IBAction)onDoneclicked:(id)sender;

@end
