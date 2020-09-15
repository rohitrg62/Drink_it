//
//  PopOverTimeViewController.m
//  Drink Time
//
//  Created by Rohit Gupta on 02/08/17.
//  Copyright © 2017 Rohit Gupta. All rights reserved.
//

#import "PopOverTimeViewController.h"
#import "IntroductionViewController.h"

@interface PopOverTimeViewController ()
@property (weak, nonatomic) IBOutlet UIDatePicker *morningTime;
@property (weak, nonatomic) IBOutlet UIDatePicker *sleepingTime;

@end

@implementation PopOverTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
   }
- (IBAction)wakeUptime:(id)sender {
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"h:mm a"];
    
    NSString *timetofill = [outputFormatter stringFromDate:_morningTime.date];
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    delegate.morningt=timetofill;
}
- (IBAction)sleepingT:(id)sender {
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"h:mm a"];
    
    NSString *timetofill = [outputFormatter stringFromDate:_sleepingTime.date];
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    delegate.sleepingT=timetofill;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
