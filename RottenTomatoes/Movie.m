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
        self.audience_score=[[dictionary objectForKey:@"ratings"] objectForKey:@"audience_score"];
        self.critics_score=[[dictionary objectForKey:@"ratings"] objectForKey:@"critics_score"];
        self.mpaa_rating=dictionary[@"mpaa_rating"];
        self.runtime=dictionary[@"runtime"];
        
        NSArray *abridgedCast = dictionary[@"abridged_cast"];
        NSMutableArray *castMembers = [[NSMutableArray alloc] init];
        for (NSDictionary *cast in abridgedCast) {
            NSLog(@"Cast:%@",cast[@"name"]);
            [castMembers addObject:cast[@"name"]];
        }
        self.castMembersList = [[castMembers valueForKey:@"description"] componentsJoinedByString:@", "];
       
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
