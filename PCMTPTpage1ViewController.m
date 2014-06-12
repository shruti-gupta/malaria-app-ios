//
//  PCMTPTpage1ViewController.m
//  MalariaiOSApp
//
//  Created by shruti gupta on 10/06/14.
//  Copyright (c) 2014 Shruti Gupta. All rights reserved.
//

#import "PCMTPTpage1ViewController.h"
#import <objc/runtime.h>

@interface PCMTPTpage1ViewController ()

@end

@implementation PCMTPTpage1ViewController

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
    //Medicine not taken. No button clicked yet
    medTaken = 0;
    
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    self->medName = [prefs stringForKey:@"medicineName"];
    
    medicineName.text = self->medName;
    
    
    NSDate *startDay = [prefs objectForKey:@"startDay"];
    
    
    //self->reminderDate = startDay;
    
    self->reminderDate = [[NSDate alloc] initWithTimeInterval:0 sinceDate:startDay];
    
    //Function to update label with arguments reminderdate
    
    
    [self updateLabel:self->reminderDate];
    
    

    [self changeLabelColor:reminderDate givenFrequency:frequency];
    
    
    
    //[[NSUserDefaults standardUserDefaults] setObject:rDate1 forKey:@"reminderTime"];
    //[[NSUserDefaults standardUserDefaults] setObject:currentTime forKey:@"startDay"];
    
}

-(void) updateLabel:(NSDate*) argDate

{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    if([prefs objectForKey:@"reminderTimeFinal"])
    {
        self->reminderDate = [(NSDate*)[prefs objectForKey:@"reminderTimeFinal"] dateByAddingTimeInterval:0 ];
    }
    

    
    NSLog(@"Inside update Label");
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"EEEE"];
    //NSLog([dateFormat  stringFromDate:startDay]);
    remindDay.text = [dateFormat  stringFromDate:argDate ];
    
   [dateFormat setDateFormat:@"dd/MM/yyyy"];
    
    self->frequency = [self determineMedFrequency:medName.lowercaseString];
    //self->rDate = startDay;
    
    self->reminderDate = [[self getrDate:frequency] dateByAddingTimeInterval:0];
    [dateFormat setDateFormat:@"EEEE"];
    //NSLog([dateFormat  stringFromDate:startDay]);
    remindDay.text = [dateFormat  stringFromDate:self->reminderDate ];
    
   // NSString *x = [dateFormat stringFromDate:startDay];
    [dateFormat setDateFormat:@"dd/MM/yyyy"];
    
    remindDate.text = [dateFormat stringFromDate:reminderDate];
    
    [[NSUserDefaults standardUserDefaults] setObject:reminderDate forKey:@"reminderTimeFinal"];


    
}

-(NSInteger) determineMedFrequency: (NSString*) mName
{
    if([mName isEqual:@"malarone"]||[mName isEqual:@"doxycycline"])
    {
        //1 = daily
        return 1;
    }
    else
        //0 = weekly
        return 0;
}

-(void) changeLabelColor: (NSDate*) remDate
         givenFrequency : (NSInteger) freq
{
    //rDate is the date when the medicine should be next taken. Implement a function to get the same
    
    NSDate *today = [NSDate date];
    remindDay.textColor = [UIColor blackColor];
    
    //frequency = daily (1)
    
    if([remDate compare:today] == NSOrderedSame);
        //remind
        
    if([remDate compare:today] == NSOrderedDescending);
    {
        //remindDay.textColor = [UIColor redColor];
        //NSLog(@"missed");
    }
    
    if([remDate compare:today] == NSOrderedAscending)
    {
        remindDay.textColor = [UIColor redColor];
        NSLog(@"missed");
    }
   //do not change
    
    //frequency = weekly (0)
}


-(IBAction)medTakenYES:(id)sender
{
    medTaken = 1;
    NSLog(@"medTaken",medTaken);
    
    
    self->rDate1 = [self getrDate:frequency];
    [self changeLabelColor:self->reminderDate givenFrequency:self->frequency];
    [self updateLabel:self->reminderDate];

    
}

-(IBAction)medTakenNO:(id)sender
{
    medTaken = 2;
    
    self->rDate1 = [self getrDate:frequency];
    [self changeLabelColor:self->rDate1 givenFrequency:self->frequency];
    [self updateLabel:self->reminderDate];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSDate*) getrDate: (NSInteger) frequency
{
    NSDate *today = [NSDate date];
   
    //&& [rDate compare:today] == NSOrderedDescending
    if(frequency == 1 && ([self->reminderDate compare:today] == NSOrderedAscending||[self->reminderDate compare:today]==NSOrderedSame)&&(medTaken == 1||medTaken == 2))
    {
        //daily
        //get next date
        NSLog(@"shruti");
        self->reminderDate = [self->reminderDate dateByAddingTimeInterval:+1*24*60*60];
    }
    
    if(frequency == 0 && [self->reminderDate compare:today] == NSOrderedAscending)
    {
        //weekly
        //today>=rDate or medicine has been taken
        
        if(medTaken == 2)
        {
            //log
            self->reminderDate = [self->reminderDate dateByAddingTimeInterval:+7*24*60*60];

        }
        
       
        else if([self->reminderDate compare:today] == NSOrderedDescending||[self->reminderDate compare:today] == NSOrderedSame||medTaken==1)
        {
            self->reminderDate = [self->reminderDate dateByAddingTimeInterval:+7*24*60*60];
        }
        
       
            
    }
    
    return self->reminderDate;
}

- (void)viewDidAppear:(BOOL)animated
{
    self.screenNumber.text = [NSString stringWithFormat:@"Screen #%d", self.index];
    
}



@end
