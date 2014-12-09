//
//  Student.h
//  HomeworkChecker
//
//  Created by Levan Toturgul on 12/8/14.
//  Copyright (c) 2014 LevanPractice. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Course;

@interface Student : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * assignment;
@property (nonatomic, retain) Course *course;

@end
