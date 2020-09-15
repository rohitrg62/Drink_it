//
//  IntroductionViewController.m
//  Drink Time
//
//  Created by Rohit Gupta on 02/08/17.
//  Copyright © 2017 Rohit Gupta. All rights reserved.
//

#import "IntroductionViewController.h"
#import "PopOverTimeViewController.h"
#import "AppDelegate.h"
#import "CoreData/CoreData.h"
#import "SettingsViewController.h"
#import "DrinkViewController.h"


@interface IntroductionViewController () <UIPopoverPresentationControllerDelegate , UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *btnClose;
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *age;
@property (weak, nonatomic) IBOutlet UITextField *weight;
@property (strong, nonatomic) NSString *gender;
@property (weak, nonatomic) IBOutlet UITextField *physicalActivityText;
@property (strong , nonatomic) NSString *physicalActivityValue;
@property (weak, nonatomic) IBOutlet UIButton *morning;
@property (weak, nonatomic) IBOutlet UITextField *moringtext;
@property (weak, nonatomic) IBOutlet UITextField *bedTime;
@property (weak, nonatomic) IBOutlet UIButton *save;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gendertext;
@property (weak, nonatomic) IBOutlet UISlider *slide;
@property (nonatomic) float howMuch;


@end

@implementation IntroductionViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    
    if(_isUpdatingUserDetails)
        {
            self.btnClose.hidden = NO;
            NSManagedObjectContext *context=[self managedObjectContext];
         NSFetchRequest  *request=[[NSFetchRequest alloc]initWithEntityName:@"DrinkDetails"];
            NSArray *dev=[[context executeFetchRequest:request error:nil] mutableCopy];

            _name.text=[[dev objectAtIndex:0]valueForKey:@"name"];
            _age.text=[[dev objectAtIndex:0 ]valueForKey:@"age"];
            _weight.text=[[dev objectAtIndex:0]valueForKey:@"weight"];
            _gender=[[dev objectAtIndex:0]valueForKey:@"gender"];
            if([_gender isEqualToString:@"MALE"])
            {
                [_gendertext setSelectedSegmentIndex:0];
             }
            else
            {
                [_gendertext setSelectedSegmentIndex:1];
            }
            _physicalActivityValue=[[dev objectAtIndex:0]valueForKey:@"routinetime"];
            _slide.value=[_physicalActivityValue floatValue];
            if(_slide.value>0.9)
            {
                _physicalActivityText.text=[_physicalActivityText.text stringByAppendingString:@" Intense"];
                _physicalActivityText.textColor=[UIColor redColor];
            }
            else if(_slide.value>0.7)
            {
                _physicalActivityText.text=[_physicalActivityText.text stringByAppendingString:@" High"];
                _physicalActivityText.textColor=[UIColor yellowColor];
                
            }
            else if(_slide.value>0.3)
            {
                _physicalActivityText.text=[_physicalActivityText.text stringByAppendingString:@" Normal"];
                _physicalActivityText.textColor=[UIColor greenColor];
            }
            else
            {
                _physicalActivityText.text=[_physicalActivityText.text stringByAppendingString:@" Low"];
                _physicalActivityText.textColor=[UIColor whiteColor];
            }
            _physicalActivityText.text=[[dev objectAtIndex:0]valueForKey:@"dailyroutinetext"];
            _moringtext.text=[[dev objectAtIndex:0]valueForKey:@"routinetimemorning"];
            _bedTime.text=[[dev objectAtIndex:0]valueForKey:@"sleeptime"];
            [_save setTitle:@"UPDATE&SAVE" forState:UIControlStateNormal];
        }
        else
        {
            _physicalActivityValue=@"0.5";
            _physicalActivityText.text=[_physicalActivityText.text stringByAppendingString:@"Physical Routine Normal"];
            _physicalActivityText.textColor=[UIColor greenColor];
            _gender=@"MALE";
            [_save setTitle:@"CREATE&SAVE" forState:UIControlStateNormal];
        
        }
    
}


- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    context=delegate.persistentContainer.viewContext;
    
    return context;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
       [self.view endEditing:YES];
}


- (IBAction)save:(UIButton *)sender {
       [self.view endEditing:YES];
    if([_save.titleLabel.text isEqualToString:@"UPDATE&SAVE"])
    {
        NSManagedObjectContext *context=[self managedObjectContext];
        NSFetchRequest  *request=[[NSFetchRequest alloc]initWithEntityName:@"DrinkDetails"];
        NSArray *dev=[[context executeFetchRequest:request error:nil] mutableCopy];
        [dev setValue:_name.text forKey:@"name"];
                [dev setValue:_age.text forKey:@"age"];
                [dev setValue:_weight.text forKey:@"weight"];
                [dev setValue:_gender forKey:@"gender"];
                [dev setValue:_physicalActivityValue forKey:@"routinetime"];
                [dev setValue:_moringtext.text forKey:@"routinetimemorning"];
                [dev setValue:_physicalActivityText.text forKey:@"dailyroutinetext"];
                [dev setValue:_bedTime.text forKey:@"sleeptime"];
                NSLog(@"%@", [NSString stringWithFormat:@"%@",[dev valueForKey:@"name"]]);
                NSError *error=nil;
                if (![context save:&error]) {
                    NSLog(@"Can't Save %@ %@",error,[error localizedDescription]);
                }
        [self drinkHowMuch];
        [dev setValue:[NSString stringWithFormat:@"%.02f",_howMuch] forKey:@"goal"];
        NSLog(@"%@", [NSString stringWithFormat:@"%@",[dev valueForKey:@"goal"]]);
        error=nil;
        if (![context save:&error]) {
            NSLog(@"Can't Save %@ %@",error,[error localizedDescription]);
        }
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
    
    
}

- (IBAction)slidePhysicalActivity:(UISlider *)sender {
     [self.view endEditing:YES];
    _physicalActivityText.text=@"Physical Routine";
    _physicalActivityValue=[NSString stringWithFormat:@"%f",sender.value];
    if(sender.value>0.9)
    {
    _physicalActivityText.text=[_physicalActivityText.text stringByAppendingString:@" Intense"];
    _physicalActivityText.textColor=[UIColor redColor];
    }
    else if(sender.value>0.7)
    {
         _physicalActivityText.text=[_physicalActivityText.text stringByAppendingString:@" High"];
        _physicalActivityText.textColor=[UIColor yellowColor];
        
    }
    else if(sender.value>0.3)
    {
        _physicalActivityText.text=[_physicalActivityText.text stringByAppendingString:@" Normal"];
        _physicalActivityText.textColor=[UIColor greenColor];
    }
    else
    {
        _physicalActivityText.text=[_physicalActivityText.text stringByAppendingString:@" Low"];
        _physicalActivityText.textColor=[UIColor whiteColor];
    }
}
- (IBAction)gender:(UISegmentedControl *)sender {
    [self.view endEditing:YES];
    _gender=[sender titleForSegmentAtIndex:sender.selectedSegmentIndex];
}



- (IBAction)routineTime:(UIButton *)sender {
      [self.view endEditing:YES];
}

-(float)drinkHowMuch
{
    NSManagedObjectContext *context=[self managedObjectContext];
    NSFetchRequest *request=[[NSFetchRequest alloc]initWithEntityName:@"DrinkDetails"];
    NSArray *dev=[[context executeFetchRequest:request error:nil] mutableCopy];
    float x=([[[dev objectAtIndex:0] valueForKey:@"weight"]floatValue])/30;
    int y=[[[dev objectAtIndex:0] valueForKey:@"age"]intValue];
    if(y<2)
    {
        _howMuch=0.7;
    }
    else if(y<=3)
    {
        _howMuch=1.3;
    }
    else if (y<=8)
    {
        _howMuch=1.7;
    }
    else if (y<=13)
    {
        if([[[dev objectAtIndex:0] valueForKey:@"gender"] isEqualToString:@"FEMALE"])
        {
            _howMuch=(x+1.9+2.1)/3;
        }
        else
        {
            _howMuch=(x+2.1+2.4)/3;
            
        }
    }
    else if(y<=18)
    {
        if([[[dev objectAtIndex:0] valueForKey:@"gender"] isEqualToString:@"FEMALE"])
        {
            _howMuch=(x+2.0+2.3)/3;
        }
        else
        {
            _howMuch=(x+2.5+2.7)/3;
            
        }
        
    }
    else
    {
        if([[[dev objectAtIndex:0] valueForKey:@"gender"] isEqualToString:@"FEMALE"])
        {
            _howMuch=(x+2.7+2.3+2.5)/4;
        }
        else
        {
            _howMuch=(x+2.5+2.7+3.2)/4;
            
        }
    }
    return _howMuch;
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"popOverIdentifier" ])
    {
        if([segue.destinationViewController isKindOfClass:[PopOverTimeViewController class]])
        {
            PopOverTimeViewController *posvc=(PopOverTimeViewController *)segue.destinationViewController;
            posvc.modalPresentationStyle=UIModalPresentationPopover;
            posvc.popoverPresentationController.delegate=(id<UIPopoverPresentationControllerDelegate>)self;
            
            
        }
    }
    else
    {
        NSManagedObjectContext *context=[self managedObjectContext];
        NSManagedObject *newDevice=[NSEntityDescription insertNewObjectForEntityForName:@"DrinkDetails" inManagedObjectContext:context];
        
        [newDevice setValue:_name.text forKey:@"name"];
        [newDevice setValue:_age.text forKey:@"age"];
        [newDevice setValue:_weight.text forKey:@"weight"];
        [newDevice setValue:_gender forKey:@"gender"];
        [newDevice setValue:_physicalActivityValue forKey:@"routinetime"];
        [newDevice setValue:_moringtext.text forKey:@"routinetimemorning"];
        [newDevice setValue:_physicalActivityText.text forKey:@"dailyroutinetext"];
        [newDevice setValue:_bedTime.text forKey:@"sleeptime"];
        [newDevice setValue:@"" forKey:@"goal"];
        NSLog(@"%@", [NSString stringWithFormat:@"%@",[newDevice valueForKey:@"name"]]);
        NSError *error=nil;
        if (![context save:&error]) {
            NSLog(@"Can't Save %@ %@",error,[error localizedDescription]);
        }
        
        NSFetchRequest *request=[[NSFetchRequest alloc]initWithEntityName:@"DrinkDetails"];
        NSArray *dev=[[context executeFetchRequest:request error:nil] mutableCopy];
        [self drinkHowMuch];
        [dev setValue:[NSString stringWithFormat:@"%.02f",_howMuch] forKey:@"goal"];
        NSLog(@"%@", [NSString stringWithFormat:@"%@",[dev valueForKey:@"goal"]]);
        error=nil;
        if (![context save:&error]) {
            NSLog(@"Can't Save %@ %@",error,[error localizedDescription]);
        }
    }
}
-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if ([identifier isEqualToString:@"popOverIdentifier"]) {
        return YES;
    }
    else
    {
    BOOL temp=YES;
    if ([_name.text isEqualToString:@""]) {
        temp=NO;
    }
    else if ([_age.text isEqualToString:@""])
    {
        
        temp=NO;
    }
    else if([_weight.text isEqualToString:@""])
    {
        temp=NO;
    }
    else if([_save.titleLabel.text isEqualToString:@"UPDATE&SAVE"])
    {
        return NO;
    }
    if(temp==YES)
        return YES;
    else
    {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Can't Create OR Save"
                                                                       message:@"Fill All the Details"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        return NO;
    }
    }
}




-(UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller
{
    return UIModalPresentationNone;
}

-(void)popoverPresentationControllerDidDismissPopover:(UIPopoverPresentationController *)popoverPresentationController
{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(delegate.morningt)
    _moringtext.text=delegate.morningt;
    if(delegate.sleepingT)
    _bedTime.text=delegate.sleepingT;

}
- (IBAction)closePressed:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)prepareForPopoverPresentation:(UIPopoverPresentationController *)popoverPresentationController
{
    _moringtext.text=@"9:00 AM";
    _bedTime.text=@"9:00 PM";
}

@end
