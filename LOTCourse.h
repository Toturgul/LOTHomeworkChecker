//
//  LOTCourse.h
//  HomeworkChecker
//
//  Created by Levan Toturgul on 12/9/14.
//  Copyright (c) 2014 LevanPractice. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class LOTStudent;

@interface LOTCourse : NSManagedObject

@property (nonatomic, retain) NSString * assignment;
@property (nonatomic, retain) NSString * courseName;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSSet *students;
@end

@interface LOTCourse (CoreDataGeneratedAccessors)

- (void)addStudentsObject:(LOTStudent *)value;
- (void)removeStudentsObject:(LOTStudent *)value;
- (void)addStudents:(NSSet *)values;
- (void)removeStudents:(NSSet *)values;

@end
