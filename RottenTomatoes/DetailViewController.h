//
//  DetailViewController.h
//  RottenTomatoes
//
//  Created by Bhargava, Rajat on 6/8/14.
//  Copyright (c) 2014 rnb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"

@interface DetailViewController : UIViewController
@property(strong, nonatomic)Movie *movie;
@property(strong, nonatomic)UIImage *lowResImage;
@end