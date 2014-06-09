//
//  Movie.h
//  RottenTomatoes
//
//  Created by Bhargava, Rajat on 6/7/14.
//  Copyright (c) 2014 rnb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Movie : NSObject

@property(strong,nonatomic)NSString *title;
@property(strong,nonatomic)NSString *synopsis;
@property(strong,nonatomic)NSDictionary *posters;

-(id)initWithDictionary:(NSDictionary*)dictionary;
+(NSArray*)moviesWithArray:(NSArray*)array;

@end
