//
//  LOTRecord.h
//  HomeworkChecker
//
//  Created by Levan Toturgul on 12/28/14.
//  Copyright (c) 2014 LevanPractice. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class LOTCourse;

@interface LOTRecord : NSManagedObject

@property (nonatomic, retain) NSSet *courses;
@end

@interface LOTRecord (CoreDataGeneratedAccessors)

- (void)addCoursesObject:(LOTCourse *)value;
- (void)removeCoursesObject:(LOTCourse *)value;
- (void)addCourses:(NSSet *)values;
- (void)removeCourses:(NSSet *)values;

@end
