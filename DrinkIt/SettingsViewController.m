//
//  SettingsViewController.m
//  Drink Time
//
//  Created by Rohit Gupta on 10/08/17.
//  Copyright © 2017 Rohit Gupta. All rights reserved.
//

#import "SettingsViewController.h"
#import "IntroductionViewController.h"
#import "AppDelegate.h"
@interface SettingsViewController ()  <UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *targetGoal;
@property (weak, nonatomic) IBOutlet UIButton *setReminder;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [_setReminder setTitle:[NSString stringWithFormat:@"SET REMINDER-%@",[[NSUserDefaults standardUserDefaults]
                            stringForKey:@"preferenceName"] ] forState:UIControlStateNormal];
    [super viewDidLoad];
     
    // Do any additional setup after loading the view.
}
- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    context=delegate.persistentContainer.viewContext;
    
    //  NSDateFormatter *dataFormatter=[[NSDateFormatter alloc]init];
    //[dataFormatter setDateFormat:@"dd-MM-yyyy"];
    return context;
}
#pragma mark-Settings

- (IBAction)updatePersonalInfo:(id)sender {
    
}
- (IBAction)targetGoal:(id)sender {
    NSManagedObjectContext *context=[self managedObjectContext];
    __block NSString *x=[[NSString alloc]init];
    NSFetchRequest *request=[[NSFetchRequest alloc]initWithEntityName:@"DrinkDetails"];
    
    NSArray *dev=[[context executeFetchRequest:request error:nil] mutableCopy];
    UIAlertController *alertController =
    [UIAlertController alertControllerWithTitle:@"SET YOUR TARGET(IN Lt.)"
                                        message:@"THIS WILL REPLACE CURRENT DRINK GOAL FOR TODAY"
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.font=[UIFont fontWithName:@"Helvetica Neue Bold" size:23];
        textField.text=[[dev objectAtIndex:0]valueForKey:@"goal"];
        textField.keyboardType=UIKeyboardTypeDecimalPad;
        x=[NSString stringWithFormat:@"%.02f",[textField.text floatValue]];
        
    }];
    UIAlertAction* saveButton = [UIAlertAction actionWithTitle:@"SAVE"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction * action)
    {
        x=alertController.textFields.firstObject.text;
        x=[NSString stringWithFormat:@"%.02f",[x floatValue]];
        [[dev objectAtIndex:0] setValue:x forKey:@"goal"];
        NSError *error=nil;
        if (![context save:&error]) {
            NSLog(@"Can't Save%@  %@",error,[error localizedDescription]);
        }
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    UIAlertAction* cancelButton = [UIAlertAction actionWithTitle:@"CANCEL"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * action)
    {
        
        NSLog(@"you pressed Cancel button");
        [self dismissViewControllerAnimated:YES completion:nil];

       
    }];
    
    [alertController addAction:saveButton];
    [alertController addAction:cancelButton];

    [self presentViewController:alertController animated:TRUE completion:^{
    }];
    
//    for (UIView* textfield in alertController.textFields) {
//        UIView *container = textfield.superview;
//        UIView *effectView = container.superview.subviews[0];
//        
//        if (effectView && [effectView class] == [UIVisualEffectView class]){
//            container.backgroundColor = [UIColor clearColor];
//            [effectView removeFromSuperview];
//        }
//    }
}
- (IBAction)setReminder:(id)sender {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:nil
                                                                   message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction* action4 = [UIAlertAction actionWithTitle:@"CANCEL" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
       
        
        
        
    }];

    
       UIAlertAction* action1 = [UIAlertAction actionWithTitle:@"EVERY HALF HOUR" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        [_setReminder setTitle:@"SET REMINDER-EVERY HALF HOUR" forState:UIControlStateNormal];
        
        
            [[NSUserDefaults standardUserDefaults] setObject:_setReminder.titleLabel.text forKey:@"preferenceName"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        
    }];
    UIAlertAction* action2 = [UIAlertAction actionWithTitle:@"EVERY HOUR" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        [_setReminder setTitle:@"SET REMINDER-EVERY HOUR" forState:UIControlStateNormal];
       
            [[NSUserDefaults standardUserDefaults] setObject:_setReminder.titleLabel.text forKey:@"preferenceName"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        
        
        
    }];
    UIAlertAction* action3 = [UIAlertAction actionWithTitle:@"EVERY 2 HOUR" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        [_setReminder setTitle:@"SET REMINDER-EVERY 2 HOUR" forState:UIControlStateNormal];
        
            [[NSUserDefaults standardUserDefaults] setObject:_setReminder.titleLabel.text forKey:@"preferenceName"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        
        
        
    }];
   
    [alert addAction:action4];
    [alert addAction:action1];
    [alert addAction:action2];
    [alert addAction:action3];
    [self presentViewController:alert animated:YES completion:nil];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"updateUserDetails"])
    {
        IntroductionViewController *introVC = (IntroductionViewController*) segue.destinationViewController;
        introVC.isUpdatingUserDetails = YES;
    }
}


@end
