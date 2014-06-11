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
@property (nonatomic,strong)UILabel *noInternetLabel;



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
    [self configureSearchBar];
   
    [self configRefreshControl];
    
    self.navigationItem.title = @"Movie";
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    self.tableView.rowHeight = 120;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MovieCell" bundle:nil] forCellReuseIdentifier:@"MovieCell"];
    
    [self configureNoInternetLabel];
    
    self.url=[NSString stringWithFormat:self.url,RT_API_KEY];
    [self getDataForTable];
   
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.movies.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MovieCell *movieCell = [tableView dequeueReusableCellWithIdentifier:@"MovieCell"];
    
    Movie *movie = self.movies[indexPath.row];
    movieCell.titleLabel.text = movie.title;
    movieCell.synopsisLabel.text = movie.castMembersList;
    [movieCell.synopsisLabel sizeToFit];
    movieCell.criticsScore.text=[NSString stringWithFormat:@"%@", movie.critics_score];
    movieCell.audienceScoreLabel.text= [NSString stringWithFormat:@"%@", movie.audience_score];
    movieCell.mpaaRatingLabel.text=[NSString stringWithFormat:@"%@, %@ min", movie.mpaa_rating, movie.runtime];

    movieCell.posterImage.alpha=0;
    [movieCell.posterImage setImageWithURL:[NSURL URLWithString:movie.posters[@"profile"]]];
    [UIView animateWithDuration:2 animations:^{
        movieCell.posterImage.alpha=1;
    }];
    
    movieCell.selectionStyle=UITableViewCellSelectionStyleNone;

    return movieCell;
}

#pragma tableViewDelegateMethod
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController *dvc = [[DetailViewController alloc]init];
    dvc.movie=self.movies[indexPath.row];
    [self.navigationController pushViewController:dvc animated:true];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    return true;
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


- (void)getDataForTable
{
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    [self showProgressWithStatus];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                if(connectionError !=nil){
                    [self showNoInternetLabel];
                    
        } else {
            id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            self.noInternetLabel.hidden=YES;
            
            self.movies = [Movie moviesWithArray:object[@"movies"]];
            [self.tableView reloadData];
            
        }
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


-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {

    NSString *tempURL=self.url;
    NSString *searchUrl=@"http://api.rottentomatoes.com/api/public/v1.0/movies.json?apikey=%@&q=%@&page_limit=10";
    searchUrl=[NSString stringWithFormat:searchUrl, RT_API_KEY,[searchBar.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    self.url=searchUrl;
    [self getDataForTable];
    [self.view endEditing:YES];
    self.url=tempURL;
    
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self.view endEditing:YES];
}

#pragma mark - Init Methods

-(id)initWithEnum:(API_URL)urlEnum {
    self=[super init];
    if(self){
        switch (urlEnum) {
            case BoxOfficeUrl:
                self.url=@"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=%@";
                break;
                
            case Top_Ten_Url:
                self.url=@"http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=%@";
                break;
                
            case Search_Url:
                self.url=@"http://api.rottentomatoes.com/api/public/v1.0/movies.json?apikey=%@&q=%@&page_limit=10";
                break;
                
            default:
                break;
        }
    }
    return self;
    
}

#pragma -
#pragma Private Methods
- (void)showNoInternetLabel
{
    self.noInternetLabel.frame = CGRectMake(0, 34, 320, 30);
    self.noInternetLabel.hidden=NO;
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.noInternetLabel.frame  = CGRectMake(0, 64, 320,30);
    } completion:^(BOOL finished) {
        
    }];
}

- (void)configureSearchBar
{

    UISearchBar *searchBar=[[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    searchBar.delegate=self;
    searchBar.placeholder=@"Search";
    searchBar.showsCancelButton=YES;
    self.tableView.tableHeaderView=searchBar;
}

- (void)configureNoInternetLabel
{
    CGRect labelFrame = CGRectMake(0, 64, 320, 30);
    self.noInternetLabel = [[UILabel alloc] initWithFrame:labelFrame];
    [self.noInternetLabel setBackgroundColor:[UIColor redColor]];
    self.noInternetLabel.textColor=[UIColor whiteColor];
    self.noInternetLabel.textAlignment=  NSTextAlignmentCenter;
    [self.noInternetLabel setText:@"No Internet"];
    self.noInternetLabel.font=[UIFont systemFontOfSize:15];
    self.noInternetLabel.hidden=YES;
    [self.view addSubview:self.noInternetLabel];
}

@end
