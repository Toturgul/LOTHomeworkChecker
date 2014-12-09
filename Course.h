//
//  Course.h
//  HomeworkChecker
//
//  Created by Levan Toturgul on 12/8/14.
//  Copyright (c) 2014 LevanPractice. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Student;

@interface Course : NSManagedObject

@property (nonatomic, retain) NSString * courseName;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * assignment;
@property (nonatomic, retain) NSSet *students;
@end

@interface Course (CoreDataGeneratedAccessors)

- (void)addStudentsObject:(Student *)value;
- (void)removeStudentsObject:(Student *)value;
- (void)addStudents:(NSSet *)values;
- (void)removeStudents:(NSSet *)values;

@end
