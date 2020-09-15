//
//  AppDelegate.h
//  Drink Time
//
//  Created by Rohit Gupta on 01/08/17.
//  Copyright © 2017 Rohit Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "UserNotifications/UserNotifications.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate , UIApplicationDelegate , UNUserNotificationCenterDelegate>
    
   
    @property (strong, nonatomic) UIWindow *window;
    @property (strong , nonatomic) NSString *morningt;
    @property (strong , nonatomic) NSString *sleepingT;
    @property (readonly, strong) NSPersistentContainer *persistentContainer;
    @property (strong , nonatomic) NSString *glassSize;
    @property (strong , nonatomic) NSString *date;
- (void)saveContext;
    
    
    @end

