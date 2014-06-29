//
//  ArtistSongsTableViewController.h
//  myapp
//
//  Created by Daniel Yang on 5/22/14.
//
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface ArtistSongsTableViewController : UITableViewController

@property (strong,nonatomic) NSMutableArray *songsForArtist;
@property (strong,nonatomic) NSString *artistName;
@property (strong,nonatomic) UIImage *artistImg;
@property (strong,nonatomic) NSMutableArray *playlist;

- (IBAction)back:(id)sender;

@end
