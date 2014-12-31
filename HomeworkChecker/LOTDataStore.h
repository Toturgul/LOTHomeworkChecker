//
//  LOTDataStore.h
//  HomeworkChecker
//
//  Created by Levan Toturgul on 12/8/14.
//  Copyright (c) 2014 LevanPractice. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@interface LOTDataStore : NSObject
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSArray *classListArray;
@property (strong, nonatomic) NSArray *coursesForRecordArray;

+ (instancetype)sharedHomeworkDataStore;
- (NSURL *)applicationDocumentsDirectory;
- (void)save;

- (void) sampleData;
- (void) fetchData;
- (void) fetchRecord;


@end
