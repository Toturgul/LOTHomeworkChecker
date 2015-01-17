//
//  LOTCustomClass.h
//  HomeworkChecker
//
//  Created by Levan Toturgul on 1/16/15.
//  Copyright (c) 2015 LevanPractice. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LOTDataStore;

@interface LOTCustomClass : NSObject

@property (strong, nonatomic) LOTDataStore *dataStore;

-(NSArray *)findSpecificEntity:(NSString *)entity byMatchingThisAttribute:(NSString *)attribute withThisTerm:(NSString *)term;


@end
