//
//  TopTenViewController.h
//  RottenTomatoes
//
//  Created by Bhargava, Rajat on 6/7/14.
//  Copyright (c) 2014 rnb. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, API_URL) {
    BoxOfficeUrl,
    Top_Ten_Url,
    Search_Url
};

@interface TopTenViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
@property(nonatomic,strong)NSString *url;
-(id)initWithEnum:(API_URL)urlEnum;

- (void)getDataForTable;
@end
