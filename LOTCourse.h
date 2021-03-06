//
//  LOTCourse.h
//  HomeworkChecker
//
//  Created by Levan Toturgul on 1/12/15.
//  Copyright (c) 2015 LevanPractice. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class LOTRecord, LOTStudent;

@interface LOTCourse : NSManagedObject

@property (nonatomic, retain) NSString * assignment;
@property (nonatomic, retain) NSString * courseName;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) LOTRecord *record;
@property (nonatomic, retain) NSSet *students;
@end

@interface LOTCourse (CoreDataGeneratedAccessors)

- (void)addStudentsObject:(LOTStudent *)value;
- (void)removeStudentsObject:(LOTStudent *)value;
- (void)addStudents:(NSSet *)values;
- (void)removeStudents:(NSSet *)values;

@end
