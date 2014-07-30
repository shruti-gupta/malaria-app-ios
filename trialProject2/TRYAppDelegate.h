//
//  TRYAppDelegate.h
//  trialProject2
//
//  Created by shruti gupta on 30/07/14.
//  Copyright (c) 2014 Shruti Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TRYAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
