//
//  Movie.m
//  RottenTomatoes
//
//  Created by Bhargava, Rajat on 6/7/14.
//  Copyright (c) 2014 rnb. All rights reserved.
//

#import "Movie.h"

@implementation Movie

-(id)initWithDictionary:(NSDictionary*)dictionary
{
    self = [super init];
    if(self){
        self.title = dictionary[@"title"];
        self.synopsis = dictionary[@"synopsis"];
        self.posters = dictionary[@"posters"];
    }
    
    return self;
}


+(NSArray*)moviesWithArray:(NSArray*)array
{
    NSMutableArray *movies = [[NSMutableArray alloc]init];
    
    for(NSDictionary* movieDict in array){
        Movie *movie = [[Movie alloc]initWithDictionary:movieDict];
        [movies addObject:movie];
        
    }
    return movies;
}

@end
