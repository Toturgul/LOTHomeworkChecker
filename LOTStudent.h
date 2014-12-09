//
//  LOTStudent.h
//  HomeworkChecker
//
//  Created by Levan Toturgul on 12/9/14.
//  Copyright (c) 2014 LevanPractice. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class LOTCourse;

@interface LOTStudent : NSManagedObject

@property (nonatomic, retain) NSString * assignment;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) LOTCourse *course;

@end
