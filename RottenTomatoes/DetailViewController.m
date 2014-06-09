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
    NSLog(@"Movie title: %@",self.movie.title);
    self.scrollView.scrollEnabled=true;
    self.scrollView.contentSize=CGSizeMake(320, 1100);
    
    self.insideView.backgroundColor=[UIColor blackColor];
    self.insideView.alpha=0.75;
    
    self.movieTitleLabel.textColor=[UIColor whiteColor];
    self.movieTitleLabel.text=self.movie.title;
    
    self.synopsisLabel.textColor=[UIColor whiteColor];
    
    self.synopsisLabel.text=self.movie.synopsis;
    [self.synopsisLabel setNumberOfLines:0];
    [self.synopsisLabel sizeToFit];
    
   

    
    NSURL *url = [NSURL URLWithString:self.movie.posters[@"original"]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [self.imageView setImageWithURLRequest:request placeholderImage:self.lowResImage success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        self.imageView.image=image;
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        NSLog(@"Error:%@",error);
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
