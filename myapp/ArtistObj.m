//
//  ArtistObj.m
//  myapp
//
//  Created by Daniel Yang on 5/22/14.
//
//

#import "ArtistObj.h"

@implementation ArtistObj

- (NSComparisonResult)compare:(ArtistObj *)otherObject {
    return [self.name compare:otherObject.name];
}

@end
