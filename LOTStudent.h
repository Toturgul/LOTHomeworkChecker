//
//  LOTStudent.h
//  HomeworkChecker
//
//  Created by Levan Toturgul on 1/15/15.
//  Copyright (c) 2015 LevanPractice. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class LOTCourse;

@interface LOTStudent : NSManagedObject

@property (nonatomic, retain) NSString * assignment;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSNumber * extraBoolean;
@property (nonatomic, retain) NSNumber * extraFloat;
@property (nonatomic, retain) NSNumber * extraInteger;
@property (nonatomic, retain) NSString * extraString1;
@property (nonatomic, retain) NSString * extraString2;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * hwCompletion;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSString * courseName;
@property (nonatomic, retain) LOTCourse *course;

@end
