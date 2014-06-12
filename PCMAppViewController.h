//
//  PCMAppViewController.h
//  MalariaiOSApp
//
//  Created by shruti gupta on 11/06/14.
//  Copyright (c) 2014 Shruti Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PCMAppViewController : UIViewController<UIPageViewControllerDataSource>
@property (strong, nonatomic) UIPageViewController *pageController;
@end
