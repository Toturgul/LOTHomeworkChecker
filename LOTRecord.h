//
//  LOTRecord.h
//  HomeworkChecker
//
//  Created by Levan Toturgul on 1/8/15.
//  Copyright (c) 2015 LevanPractice. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class LOTCourse;

@interface LOTRecord : NSManagedObject

@property (nonatomic, retain) NSString * courseName;
@property (nonatomic, retain) NSString * extraString1;
@property (nonatomic, retain) NSString * extraString2;
@property (nonatomic, retain) NSNumber * extraBoolean;
@property (nonatomic, retain) NSNumber * extraFloat;
@property (nonatomic, retain) NSSet *courses;
@end

@interface LOTRecord (CoreDataGeneratedAccessors)

- (void)addCoursesObject:(LOTCourse *)value;
- (void)removeCoursesObject:(LOTCourse *)value;
- (void)addCourses:(NSSet *)values;
- (void)removeCourses:(NSSet *)values;

@end
