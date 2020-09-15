//
//  CalendarViewController.m
//  Drink Time
//
//  Created by Rohit Gupta on 04/08/17.
//  Copyright © 2017 Rohit Gupta. All rights reserved.
//

#import "CalendarViewController.h"
#import <FSCalendar/FSCalendar.h>
#import "AppDelegate.h"
@interface CalendarViewController () <FSCalendarDelegateAppearance , FSCalendarDataSource , FSCalendarDelegate>
@property (weak, nonatomic) IBOutlet FSCalendar *calendar;

@end

@implementation CalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.calendar.delegate=self;
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSDateFormatter *dateformat=[[NSDateFormatter alloc]init];
    [dateformat setDateFormat:@"yyyy-MM-dd"];
    NSDate *now=[[NSDate alloc]init];
    delegate.date=[dateformat stringFromDate:now];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSLog(@"%@",date);
    NSDateFormatter *dateformat=[[NSDateFormatter alloc]init];
    [dateformat setDateFormat:@"yyyy-MM-dd"];
    delegate.date=[dateformat stringFromDate:date];
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
