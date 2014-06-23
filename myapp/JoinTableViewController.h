//
//  EventsTableViewController.h
//  musicapp
//
//  Created by Daniel Yang on 5/20/14.
//
//

#import <UIKit/UIKit.h>
#import "SWTableViewCell.h"

@class EventTableViewController;

@interface JoinTableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource, SWTableViewCellDelegate>

@property (nonatomic, strong) EventTableViewController *eventViewcontroller;
@property (strong, nonatomic) NSMutableDictionary *eventDict;

@end
