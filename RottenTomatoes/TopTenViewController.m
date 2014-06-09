//
//  TopTenViewController.m
//  RottenTomatoes
//
//  Created by Bhargava, Rajat on 6/7/14.
//  Copyright (c) 2014 rnb. All rights reserved.
//

#import "TopTenViewController.h"
#import "MovieCell.h"
#import "Movie.h"
#import "UIImageView+AFNetworking.h"
#import "SVProgressHUD.h"
#import "DetailViewController.h"
#import "Reachability.h"

@interface TopTenViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSArray *movies;
@property(nonatomic,strong)UIRefreshControl *refreshControl;


@end

@implementation TopTenViewController

static const NSString *RT_API_KEY = @"eguunce463gp87nf7xjtsj5s";


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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityDidChange:) name:kReachabilityChangedNotification object:nil];

    
    [self configRefreshControl];
    
    
    
    self.navigationItem.title = @"Movie";
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    self.tableView.rowHeight = 120;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MovieCell" bundle:nil] forCellReuseIdentifier:@"MovieCell"];
    
   
   
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.movies.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MovieCell *movieCell = [tableView dequeueReusableCellWithIdentifier:@"MovieCell"];
    
    Movie *movie = self.movies[indexPath.row];
    
    NSURL *url = [NSURL URLWithString:movie.posters[@"profile"]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    __weak UITableViewCell *weakCell = movieCell;
   
    
    
 
    movieCell.titleLabel.text = movie.title;
    movieCell.synopsisLabel.text = movie.synopsis;
    
    NSCachedURLResponse *response = [[NSURLCache sharedURLCache] cachedResponseForRequest:request];
    if(response){
        NSLog(@"I have the image!: Movie: %@", movie.title);
        UIImage *image = [[UIImage alloc] initWithData:response.data scale:1];
        weakCell.imageView.image=image;
        [weakCell setNeedsLayout];
        
    } else {
        NSLog(@"I do not have the image! Movie: %@", movie.title);
        [movieCell.imageView setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
            //weakCell.imageView.image=image;
            //[weakCell setNeedsLayout];
            
            [UIView transitionWithView:weakCell.imageView
                              duration:5.0f
                               options:UIViewAnimationOptionTransitionCrossDissolve
                            animations:^{
                                weakCell.imageView.image=image;
                                [weakCell setNeedsLayout];
                            } completion:nil];
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
            NSLog(@"Error:%@",error);
        }];
    }
    
   
    return movieCell;
}

#pragma tableViewDelegateMethod
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController *dvc = [[DetailViewController alloc]init];
    dvc.movie=self.movies[indexPath.row];
    MovieCell *cell= (MovieCell*)[self.tableView cellForRowAtIndexPath:indexPath];
    dvc.lowResImage = cell.imageView.image;
    
    [self.navigationController pushViewController:dvc animated:true];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Show Progress Methods

- (void)showProgressWithStatus {
    [SVProgressHUD showWithStatus:@"Loading..." ];
}

#pragma mark Dismiss Methods Sample

- (void)dismissProgress {
    [SVProgressHUD dismiss];
}


-(void) endRefresh {
    [self.refreshControl endRefreshing];
}

#pragma -
#pragma Private Methods
- (void)getDataForTable
{
   // NSString *url = @"http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=%@";
    NSString *url = self.url;
    url=[NSString stringWithFormat:url,RT_API_KEY];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [self showProgressWithStatus];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSLog(@"%@", object);
        self.movies = [Movie moviesWithArray:object[@"movies"]];
        
        
        [self.tableView reloadData];
        [self dismissProgress];
        [self endRefresh];
        
    }];
}

- (void)configRefreshControl
{
    self.refreshControl = [[UIRefreshControl alloc]init];
    [self.tableView addSubview:self.refreshControl];
    [self.refreshControl addTarget:self action:@selector(getDataForTable) forControlEvents:UIControlEventValueChanged];
}

#pragma mark -check for intertnet listner method
- (void)reachabilityDidChange:(NSNotification *)notification {
    Reachability *reachability = (Reachability *)[notification object];
    CGRect labelFrame = CGRectMake(0, 64, 320, 30);
    UILabel *myLabel = [[UILabel alloc] initWithFrame:labelFrame];
    [myLabel setBackgroundColor:[UIColor redColor]];
    myLabel.textColor=[UIColor whiteColor];
    myLabel.textAlignment=  NSTextAlignmentCenter;
    NSString *labelText = @"No Internet";
    [myLabel setText:labelText];
    
    [self.view addSubview:myLabel];
    
   
    if ([reachability isReachable]) {
        myLabel.hidden=true;
        
    } else {
        myLabel.hidden=false;
    }
}

@end
