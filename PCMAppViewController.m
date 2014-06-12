//
//  PCMAppViewController.m
//  MalariaiOSApp
//
//  Created by shruti gupta on 11/06/14.
//  Copyright (c) 2014 Shruti Gupta. All rights reserved.
//

#import "PCMAppViewController.h"
#import "PCMTPTpage1ViewController.h"

@interface PCMAppViewController ()

@end

@implementation PCMAppViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //self.view.backgroundColor = [UIColor blackColor];
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    self.pageController.dataSource = self;
    [[self.pageController view] setFrame:[[self view] bounds]];
    
    PCMTPTpage1ViewController *initialViewController = [self viewControllerAtIndex:0];
    
    NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
    
    [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self addChildViewController:self.pageController];
    [[self view] addSubview:[self.pageController view]];
    [self.pageController didMoveToParentViewController:self];
    
    
    for (UIView *subview in self.pageController.view.subviews) {
        if ([subview isKindOfClass:[UIPageControl class]]) {
            UIPageControl *pageControl = (UIPageControl *)subview;
            pageControl.pageIndicatorTintColor = [UIColor yellowColor];
            pageControl.currentPageIndicatorTintColor = [UIColor greenColor];
            pageControl.backgroundColor = [UIColor blueColor];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(PCMTPTpage1ViewController *)viewController index];
    
    if (index == 0) {
        return nil;
    }
    
    index--;
    
    return [self viewControllerAtIndex:index];
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(PCMTPTpage1ViewController *)viewController index];
    
    
    index++;
    
    if (index == 2) {
        return nil;
    }
    
    return [self viewControllerAtIndex:index];
    
}

- (PCMTPTpage1ViewController *)viewControllerAtIndex:(NSUInteger)index {
    
    PCMTPTpage1ViewController *childViewController = [[PCMTPTpage1ViewController alloc] initWithNibName:@"PCMTPTpage1ViewController" bundle:nil];
    childViewController.index = index;
    
    return childViewController;
    
}   

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    // The number of items reflected in the page indicator.
    return 2;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    // The selected item reflected in the page indicator.
    return 0;
}
@end
