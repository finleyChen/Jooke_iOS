//
//  HostViewController.h
//  musicapp
//
//  Created by Daniel Yang on 5/20/14.
//
//

#import <UIKit/UIKit.h>
@class PlaylistViewController;

@interface HostViewController : UIViewController

@property (weak, nonatomic) IBOutlet UINavigationItem *titleItem;
@property (weak, nonatomic) IBOutlet UITextField *txtEventName;
@property (weak, nonatomic) IBOutlet UIButton *btnAdd;
@property (weak, nonatomic) IBOutlet UIButton *btnVote;
@property (strong, nonatomic) NSMutableDictionary *eventDict;

-(IBAction)back:(id)sender;
-(IBAction)onCreatePlaylistclicked:(id)sender;
-(IBAction)onSettingsclicked:(id)sender;
-(IBAction)onCreateEventclicked:(id)sender;
-(IBAction)onAddclicked:(id)sender;
-(IBAction)onVoteclicked:(id)sender;

@end
