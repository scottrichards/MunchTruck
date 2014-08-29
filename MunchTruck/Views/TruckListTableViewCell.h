//
//  TruckListTableViewCell.h
//  MunchTruck
//
//  Created by Scott Richards on 8/26/14.
//  Copyright (c) 2014 Scott Richards. All rights reserved.
//

#import <Parse/Parse.h>

@interface TruckListTableViewCell : PFTableViewCell

@property (strong, nonatomic) IBOutlet UILabel *Name;
@property (strong, nonatomic) IBOutlet PFImageView *LogoImage;

@end
