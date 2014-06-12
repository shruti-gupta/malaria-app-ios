//
//  PCMSetupScreenViewController.m
//  MalariaiOSApp
//
//  Created by shruti gupta on 04/06/14.
//  Copyright (c) 2014 Shruti Gupta. All rights reserved.
//

#import "PCMSetupScreenViewController.h"
#define kOFFSET_FOR_KEYBOARD 80.0
#import "PCMAppViewController.h"


@interface PCMSetupScreenViewController ()<UITextFieldDelegate>

@end

@implementation PCMSetupScreenViewController


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
    
    //Set the background image
    
    [super viewDidLoad];
    background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background.png"]];
    background.frame = self.view.bounds;
    [[self view] addSubview:background];
    [background.superview sendSubviewToBack:background];
   
    
    
    //Code for the medicines Picker
    
    medicines = [NSArray arrayWithObjects:@"Doxycycline",@"Malarone",@"Mefloquine", nil];
    UIPickerView *medPicker = [[UIPickerView alloc]initWithFrame:CGRectZero];
    medPicker.delegate = self;
    medPicker.dataSource = self;
    [medPicker setShowsSelectionIndicator:YES];
    txt.inputView = medPicker;
    
    
    //Create done button in UIPickerView
    
    UIToolbar* myPickerToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 56)];
    myPickerToolbar.barStyle = UIBarStyleBlackOpaque;
    [myPickerToolbar sizeToFit];
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    [barItems addObject:flexSpace];
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(pickerDoneClicked)];
    [barItems addObject:doneBtn];
    
    [myPickerToolbar setItems:barItems animated:YES];
    txt.inputAccessoryView = myPickerToolbar;
    
   
    //Code for the date picker
    
    self->datePicker = [[UIDatePicker alloc] initWithFrame:CGRectZero];
    self->datePicker.datePickerMode = UIDatePickerModeTime;
    time.inputView = datePicker;
    [datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"hh:mm a"];
    [self.view addSubview:time];
    
    //Done Button in Date Picker
    
    UIToolbar* myDatePickerToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 56)];
    myDatePickerToolbar.barStyle = UIBarStyleBlackTranslucent;
    [myDatePickerToolbar sizeToFit];
    NSMutableArray *barItems1 = [[NSMutableArray alloc] init];
    UIBarButtonItem *flexSpace1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    [barItems1 addObject:flexSpace1];
    UIBarButtonItem *doneBtn1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(datePickerDoneClicked)];
    [barItems1 addObject:doneBtn1];
    
    [myDatePickerToolbar setItems:barItems1 animated:YES];
    time.inputAccessoryView = myDatePickerToolbar;
    
   
}

//Function to select date from the date picker

- (void)dateChanged:(id)sender
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"hh:mm a"];
    self->currentTime = self->datePicker.date;
    NSString *currentTimeString = [dateFormatter stringFromDate:currentTime];
    time.text = currentTimeString;
    
}

//Done Button Function for medicine picker

-(void)pickerDoneClicked
{
    
    if([txt.text  isEqual: @""])
        {
            NSLog(@"No medication entered");
            [medWarning setHidden:NO];
            [medWarning setText:@"Medication not entered"];
        }
    
        
    BOOL isMedThere = [medicines containsObject: txt.text];
        
       
        
    if(![txt.text isEqualToString:@""] && !isMedThere )
        {
            [medWarning setHidden:NO];
            [medWarning setText:@"Wrong Medication entered"];
            

        }
        
        
    isMedThere = [medicines containsObject: txt.text];
        
        
        
    if(![txt.text isEqualToString:@""] && isMedThere )
        {
            [medWarning setHidden:YES];

        }
        

    
    isMedThere = [medicines containsObject: txt.text];
    
    if(![txt.text isEqualToString:@""] && ![time.text isEqualToString:@""] && isMedThere)
        {
            [done setEnabled:YES];
        }
    
    [txt resignFirstResponder];


}



-(void)datePickerDoneClicked
{
    NSLog(@"Done Clicked");
    
    
  
    
    if([time.text isEqual: @""])
    {
        
    
        
        [timeWarning setHidden:NO];
        [timeWarning setText:@"Continuing with current time"];
        
        
        self->currentTime = [NSDate date];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"hh:mm";
        [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
        [time setText:[dateFormatter stringFromDate:self->currentTime]];
        
        
    }
    [time resignFirstResponder];
    
    if(![txt.text isEqualToString:@""] && ![time.text isEqualToString:@""])
    {
        //[timeWarning setHidden:YES];
        [done setEnabled:YES];
        //[timeWarning setHidden:YES];
    }

}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView*)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return medicines.count;
}

-(NSString*)pickerView: (UIPickerView*) pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [medicines objectAtIndex:row];
}

-(void)pickerView:(UIPickerView*)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    txt.text = (NSString*)[medicines objectAtIndex:row];
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)done:(id)sender
{
    
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"EEEE"];
    
    NSString *medicine = txt.text;
    NSString *remindTime = time.text;
    
    [[NSUserDefaults standardUserDefaults] setObject:medicine forKey:@"medicineName"];
    [[NSUserDefaults standardUserDefaults] setObject:remindTime forKey:@"reminderTime"];
    [[NSUserDefaults standardUserDefaults] setObject:currentTime forKey:@"startDay"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    PCMAppViewController *tPT1VC = [[PCMAppViewController alloc] init];
    
    
    [self presentModalViewController:tPT1VC animated:YES];
   


    
        /*[time setText:@"shruti"];
        [nextScreen setHidden:NO];
        [txt setHidden:YES];
        [time setHidden:YES];
        [iTake setHidden:YES];
        [remind setHidden:YES];
        [ifIFor setHidden:YES];
        [setup setHidden:YES];
        [done setHidden:YES];
        [timeWarning setHidden:YES];*/
    
}


-(void)keyboardWillShow {
    // Animate the current view out of the way
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

-(void)keyboardWillHide {
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}


//method to move the view up/down whenever the keyboard is shown/dismissed
-(void)setViewMovedUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    
    CGRect rect = self.view.frame;
    if (movedUp)
    {
        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
        // 2. increase the size of the view so that the area behind the keyboard is covered up.
        rect.origin.y -= kOFFSET_FOR_KEYBOARD;
        rect.size.height += kOFFSET_FOR_KEYBOARD;
    }
    else
    {
        // revert back to the normal state.
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
        rect.size.height -= kOFFSET_FOR_KEYBOARD;
    }
    self.view.frame = rect;
    
    [UIView commitAnimations];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}


@end
