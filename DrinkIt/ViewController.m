//
//  ViewController.m
//  Drink Time
//
//  Created by Rohit Gupta on 01/08/17.
//  Copyright © 2017 Rohit Gupta. All rights reserved.
//NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//[dateFormatter setDateFormat:@"EEEE"];
//NSString *dayName = [dateFormatter stringFromDate:yourDate];
//[dateFormatter release];

#import "ViewController.h"
#import "SpriteKit/SpriteKit.h"
#import "AppDelegate.h"
#import "CalendarViewController.h"
@interface ViewController ()<UITableViewDelegate , UITableViewDataSource , UIPopoverPresentationControllerDelegate, UIPopoverControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *calendarDate;
@property (weak, nonatomic) IBOutlet UIButton *calendarButton;
@property (weak, nonatomic) IBOutlet UITableView *logTable;


@end

@implementation ViewController

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    context=delegate.persistentContainer.viewContext;
   // NSDateFormatter *dataFormatter=[[NSDateFormatter alloc]init];
    //[dataFormatter setDateFormat:@"dd-MM-yyyy"];
    
    
    return context;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.logTable.delegate=self;
    self.logTable.dataSource=self;
    NSDateFormatter *dateformat=[[NSDateFormatter alloc]init];
    [dateformat setDateFormat:@"yyyy-MM-dd"];
    NSDate *now=[[NSDate alloc]init];
    self.calendarDate.textAlignment=NSTextAlignmentCenter;
    self.calendarDate.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    self.calendarDate.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
     self.calendarDate.backgroundColor=[UIColor lightGrayColor];
    
    self.calendarDate.text=[dateformat stringFromDate:now];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSManagedObjectContext *context=[self managedObjectContext];
    NSFetchRequest *request=[[NSFetchRequest alloc]initWithEntityName:@"Details"];
    request.predicate = [NSPredicate predicateWithFormat:@"date contains %@",self.calendarDate.text];
    NSArray *dev=[[context executeFetchRequest:request error:nil] mutableCopy];
    return [dev count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[self.logTable dequeueReusableCellWithIdentifier:@"calendar"];
    NSManagedObjectContext *context=[self managedObjectContext];
    NSFetchRequest *request=[[NSFetchRequest alloc]initWithEntityName:@"Details"];
    request.predicate = [NSPredicate predicateWithFormat:@"date contains %@",self.calendarDate.text];
    NSArray *dev=[[context executeFetchRequest:request error:nil] mutableCopy];
    cell.textLabel.text=[[dev objectAtIndex:indexPath.row] valueForKey:@"drank"];
    NSLog(@"%lu",[[[dev objectAtIndex:indexPath.row]valueForKey:@"date" ] length]);
    cell.detailTextLabel.text=[[[[dev objectAtIndex:indexPath.row]valueForKey:@"date" ]substringFromIndex:11]substringToIndex:8];
    cell.textLabel.font=[UIFont boldSystemFontOfSize:15];
    return  cell;
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"calendar" ])
    {
        if([segue.destinationViewController isKindOfClass:[CalendarViewController class]])
        {
            CalendarViewController *posvc=(CalendarViewController *)segue.destinationViewController;
            posvc.modalPresentationStyle=UIModalPresentationPopover;
            posvc.popoverPresentationController.delegate=(id<UIPopoverPresentationControllerDelegate>)self;
            
            
        }
    }
    
}

-(void)popoverPresentationControllerDidDismissPopover:(UIPopoverPresentationController *)popoverPresentationController
{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    self.calendarDate.text=delegate.date;
    
    [self.logTable reloadData];
}

-(UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller
{
    return UIModalPresentationNone;
}

@end
