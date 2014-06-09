//
//  TopTenViewController.h
//  RottenTomatoes
//
//  Created by Bhargava, Rajat on 6/7/14.
//  Copyright (c) 2014 rnb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopTenViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property(nonatomic,strong)NSString *url;

- (void)getDataForTable;
@end
