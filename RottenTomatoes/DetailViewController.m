//
//  DetailViewController.m
//  RottenTomatoes
//
//  Created by Bhargava, Rajat on 6/8/14.
//  Copyright (c) 2014 rnb. All rights reserved.
//

#import "DetailViewController.h"
#import "UIImageView+AFNetworking.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *insideView;
@property (weak, nonatomic) IBOutlet UILabel *movieTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;
@property (weak, nonatomic) IBOutlet UILabel *castListLabel;


@end

@implementation DetailViewController

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
   
    self.scrollView.scrollEnabled=true;
    self.scrollView.contentSize=CGSizeMake(320, 1100);
    
    self.insideView.backgroundColor=[UIColor blackColor];
    self.insideView.alpha=0.75;
    
    self.movieTitleLabel.textColor=[UIColor whiteColor];
    self.movieTitleLabel.text=self.movie.title;
    
    self.castListLabel.textColor=[UIColor whiteColor];
    self.castListLabel.text=[NSString stringWithFormat:@"Cast: %@",self.movie.castMembersList];
    [self.castListLabel setNumberOfLines:0];
    [self.castListLabel sizeToFit];
    
    self.synopsisLabel.textColor=[UIColor whiteColor];
    self.synopsisLabel.text=self.movie.synopsis;
    [self.synopsisLabel setNumberOfLines:0];
    [self.synopsisLabel sizeToFit];
    
    
    NSCachedURLResponse *response = [[NSURLCache sharedURLCache] cachedResponseForRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.movie.posters[@"profile"]]]];
    UIImage *placeholder=nil;
    if (response) {
        NSLog(@"Detail image low res was there");
        placeholder=[[UIImage alloc]initWithData:response.data];
    }
    
    [self.imageView setImageWithURL:[NSURL URLWithString:self.movie.posters[@"original"]] placeholderImage:placeholder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
