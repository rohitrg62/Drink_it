//
//  DrinkViewController.m
//  Drink Time
//
//  Created by Rohit Gupta on 02/08/17.
//  Copyright © 2017 Rohit Gupta. All rights reserved.
//

#import "DrinkViewController.h"
#import "AppDelegate.h"

@interface DrinkViewController () <UICollectionViewDelegate , UICollectionViewDataSource , UIPopoverPresentationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIView *level;
@property (weak, nonatomic) IBOutlet UICollectionView *imageViews;
@property (nonatomic) int intr;
@property (weak, nonatomic) IBOutlet UITextField *drink;
@property (strong) NSMutableArray *devices;
@property (strong , nonatomic) UIView *tempView;
@property (nonatomic) float howMuch;
@end

@implementation DrinkViewController

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    context=delegate.persistentContainer.viewContext;
  //  NSDateFormatter *dataFormatter=[[NSDateFormatter alloc]init];
    //[dataFormatter setDateFormat:@"dd-MM-yyyy"];
    return context;
}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSManagedObjectContext *context=[self managedObjectContext];
    NSFetchRequest *request=[[NSFetchRequest alloc]initWithEntityName:@"DrinkDetails"];
    self.devices=[[context executeFetchRequest:request error:nil] mutableCopy];
    float x=[[[self.devices objectAtIndex:0]valueForKey:@"goal"]floatValue];
    NSLog(@"%@ htd%f", [NSString stringWithFormat:@"%@",[self.devices valueForKey:@"goal"]],x);
    self.howMuch=x;
    self.drink.text=[NSString stringWithFormat:@"Drink-%d/%.02f",0,x];
    self.imageViews.delegate=self;
    self.imageViews.dataSource=self;
    self.imageViews.bounces=NO;
    request=[[NSFetchRequest alloc]initWithEntityName:@"DrinkCount"];
    NSArray *dev=[[context executeFetchRequest:request error:nil] mutableCopy];
    [self.tempView removeFromSuperview];
    
    NSDateFormatter *dateformat=[[NSDateFormatter alloc]init];
    [dateformat setDateFormat:@"yyyy-MM-dd"];
    NSDate *now=[[NSDate alloc]init];
    NSString *temp=[[[dev objectAtIndex:0]valueForKey:@"date"]substringToIndex:10];
    NSLog(@"%@ %@",temp,[dateformat stringFromDate:now]);
    if (![temp isEqual:([dateformat stringFromDate:now] )]) {
        
        
        [dev setValue:[NSNumber numberWithInt:0] forKey:@"count"];
        [dev setValue:[NSString stringWithFormat:@"%@",now] forKey:@"date"];
        [dev setValue:[NSNumber numberWithInt:0] forKey:@"glasssize"];
        NSError *error=nil;
        if (![context save:&error]) {
            NSLog(@"Can't Save%@  %@",error,[error localizedDescription]);
        }
        
        self.tempView=  [[UIView alloc] initWithFrame:CGRectMake(self.level.frame.origin.x, (self.level.frame.origin.y+self.level.frame.size.height), self.level.frame.size.width,0.0)] ;
        
    }
    else
    {
        request=[[NSFetchRequest alloc]initWithEntityName:@"DrinkCount"];
        NSArray *dev=[[context executeFetchRequest:request error:nil] mutableCopy];
        _intr=[[[dev objectAtIndex:0]valueForKey:@"count" ]intValue];
        float z=([[[dev objectAtIndex:0]valueForKey:@"glasssize" ]floatValue])/1000;
        self.drink.text=[NSString stringWithFormat:@"Drink-%.02f/%.02f lt",z,_howMuch];
        float y=(z*100)/(_howMuch);
        
        y=self.level.frame.size.height*y/100;
        if(y>self.level.frame.size.height)
        {
            y=self.level.frame.size.height;
        }
        self.tempView=  [[UIView alloc] initWithFrame:CGRectMake(self.level.frame.origin.x, self.level.frame.size.height+self.level.frame.origin.y-y, self.level.frame.size.width,y)] ;
        [self.tempView setBackgroundColor:[UIColor blueColor]];
        
        [self.view addSubview:self.tempView];
    }
    [[self.imageViews subviews]makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.imageViews reloadData];

}
- (void)viewDidLoad {
    [super viewDidLoad];
        // Do any additional setup after loading the view.
//    NSManagedObjectContext *context=[self managedObjectContext];
//    NSFetchRequest *request=[[NSFetchRequest alloc]initWithEntityName:@"DrinkDetails"];
//    self.devices=[[context executeFetchRequest:request error:nil] mutableCopy];
//    float x=[[[self.devices objectAtIndex:0]valueForKey:@"goal"]floatValue];
//            NSLog(@"%@ htd%f", [NSString stringWithFormat:@"%@",[self.devices valueForKey:@"goal"]],x);
//    self.howMuch=x;
//      self.drink.text=[NSString stringWithFormat:@"Drink-%d/%.02f",0,x];
//    self.imageViews.delegate=self;
//    self.imageViews.dataSource=self;
//    self.imageViews.bounces=NO;
//    request=[[NSFetchRequest alloc]initWithEntityName:@"DrinkCount"];
//    NSArray *dev=[[context executeFetchRequest:request error:nil] mutableCopy];
//    [self.tempView removeFromSuperview];
//    
//    NSDateFormatter *dateformat=[[NSDateFormatter alloc]init];
//   [dateformat setDateFormat:@"yyyy-MM-dd"];
//    NSDate *now=[[NSDate alloc]init];
//    NSString *temp=[[[dev objectAtIndex:0]valueForKey:@"date"]substringToIndex:10];
//    NSLog(@"%@ %@",temp,[dateformat stringFromDate:now]);
//    if (![temp isEqual:([dateformat stringFromDate:now] )]) {
//        
//    
//    [dev setValue:[NSNumber numberWithInt:0] forKey:@"count"];
//        [dev setValue:[NSString stringWithFormat:@"%@",now] forKey:@"date"];
//        [dev setValue:[NSNumber numberWithInt:0] forKey:@"glasssize"];
//        NSError *error=nil;
//        if (![context save:&error]) {
//            NSLog(@"Can't Save%@  %@",error,[error localizedDescription]);
//        }
//        
//          self.tempView=  [[UIView alloc] initWithFrame:CGRectMake(self.level.frame.origin.x, (self.level.frame.origin.y+self.level.frame.size.height), self.level.frame.size.width,0.0)] ;
//        
//    }
//    else
//    {
//        request=[[NSFetchRequest alloc]initWithEntityName:@"DrinkCount"];
//        NSArray *dev=[[context executeFetchRequest:request error:nil] mutableCopy];
//        _intr=[[[dev objectAtIndex:0]valueForKey:@"count" ]intValue];
//        float z=([[[dev objectAtIndex:0]valueForKey:@"glasssize" ]floatValue])/1000;
//        self.drink.text=[NSString stringWithFormat:@"Drink-%.02f/%.02f lt",z,_howMuch];
//        float y=(z*100)/(_howMuch);
//        
//        y=self.level.frame.size.height*y/100;
//        if(y>self.level.frame.size.height)
//        {
//            y=self.level.frame.size.height;
//        }
// self.tempView=  [[UIView alloc] initWithFrame:CGRectMake(self.level.frame.origin.x, self.level.frame.size.height+self.level.frame.origin.y-y, self.level.frame.size.width,y)] ;
//        [self.tempView setBackgroundColor:[UIColor blueColor]];
//        
//        [self.view addSubview:self.tempView];
//    }
//    [[self.imageViews subviews]makeObjectsPerformSelector:@selector(removeFromSuperview)];
//    [self.imageViews reloadData];
    
}
-(void)drank
{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self.tempView removeFromSuperview];
    NSManagedObjectContext *context=[self managedObjectContext];
    NSFetchRequest *request=[[NSFetchRequest alloc]initWithEntityName:@"DrinkCount"];
    NSArray *dev=[[context executeFetchRequest:request error:nil] mutableCopy];
    float x=(float)([[[dev objectAtIndex:0]valueForKey:@"glasssize" ]floatValue]+[delegate.glassSize floatValue]);
    float y=(x*100)/(_howMuch*1000);
    y=self.level.frame.size.height*y/100;
    if(y>self.level.frame.size.height)
    {
        y=self.level.frame.size.height;
    }
    self.tempView=  [[UIView alloc] initWithFrame:CGRectMake(self.level.frame.origin.x, self.level.frame.size.height+self.level.frame.origin.y-y, self.level.frame.size.width,y)] ;
    [self.tempView setBackgroundColor:[UIColor blueColor]];
    
    [self.view addSubview:self.tempView];
    self.drink.text=[NSString stringWithFormat:@"Drink-%.02f/%.02f lt",x/1000,_howMuch];
    _intr =[[[dev objectAtIndex:0]valueForKey:@"count" ]intValue];
    _intr++;
    [dev setValue:[NSNumber numberWithInt:_intr] forKey:@"count"];
    [dev setValue:[NSNumber numberWithFloat:x] forKey:@"glasssize"];
    NSLog(@"%lu",(unsigned long)[dev count]);
    NSError *error=nil;
    if (![context save:&error]) {
        NSLog(@"Can't Save %@ %@",error,[error localizedDescription]);
    }
    NSManagedObject *newDevice=[NSEntityDescription insertNewObjectForEntityForName:@"Details" inManagedObjectContext:delegate.persistentContainer.viewContext];
    [newDevice setValue:delegate.glassSize forKey:@"drank"];
    
    NSDate *now=[[NSDate alloc]init];
    NSDateFormatter *dateformat=[[NSDateFormatter alloc]init];
    [dateformat setDateFormat:@"yyyy-MM-dd hh:mm aa"];
    
    [newDevice setValue:[NSString stringWithFormat:@"%@",[dateformat stringFromDate:now]] forKey:@"date"];
    error=nil;
    if (![context save:&error]) {
        NSLog(@"Can't Save %@ %@",error,[error localizedDescription]);
    }
    [[self.imageViews subviews]makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.imageViews.dataSource=nil;
    
    self.imageViews.dataSource=self;
    [self.imageViews reloadData];
    if((x/1000)>_howMuch)
    {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Advice" message:@"You May Feel Unhealthy By Drinking More Now" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
    

}
- (IBAction)Drank:(id)sender {
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self.tempView removeFromSuperview];
    NSManagedObjectContext *context=[self managedObjectContext];
    NSFetchRequest *request=[[NSFetchRequest alloc]initWithEntityName:@"DrinkCount"];
    NSArray *dev=[[context executeFetchRequest:request error:nil] mutableCopy];
    float x=(float)([[[dev objectAtIndex:0]valueForKey:@"glasssize" ]floatValue]+[delegate.glassSize floatValue]);
    float y=(x*100)/(_howMuch*1000);
    y=self.level.frame.size.height*y/100;
    if(y>self.level.frame.size.height)
    {
        y=self.level.frame.size.height;
    }
    self.tempView=  [[UIView alloc] initWithFrame:CGRectMake(self.level.frame.origin.x, self.level.frame.size.height+self.level.frame.origin.y-y, self.level.frame.size.width,y)] ;
    [self.tempView setBackgroundColor:[UIColor blueColor]];
    
    [self.view addSubview:self.tempView];
    self.drink.text=[NSString stringWithFormat:@"Drink-%.02f/%.02f lt",x/1000,_howMuch];
    _intr =[[[dev objectAtIndex:0]valueForKey:@"count" ]intValue];
    _intr++;
    [dev setValue:[NSNumber numberWithInt:_intr] forKey:@"count"];
    [dev setValue:[NSNumber numberWithFloat:x] forKey:@"glasssize"];
    NSLog(@"%lu",(unsigned long)[dev count]);
    NSError *error=nil;
    if (![context save:&error]) {
        NSLog(@"Can't Save %@ %@",error,[error localizedDescription]);
    }
    NSManagedObject *newDevice=[NSEntityDescription insertNewObjectForEntityForName:@"Details" inManagedObjectContext:delegate.persistentContainer.viewContext];
    [newDevice setValue:delegate.glassSize forKey:@"drank"];
    
    NSDate *now=[[NSDate alloc]init];
    NSDateFormatter *dateformat=[[NSDateFormatter alloc]init];
    [dateformat setDateFormat:@"yyyy-MM-dd hh:mm aa"];

    [newDevice setValue:[NSString stringWithFormat:@"%@",[dateformat stringFromDate:now]] forKey:@"date"];
     error=nil;
    if (![context save:&error]) {
        NSLog(@"Can't Save %@ %@",error,[error localizedDescription]);
    }
    [[self.imageViews subviews]makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.imageViews.dataSource=nil;
    
    self.imageViews.dataSource=self;
    [self.imageViews reloadData];
    if((x/1000)>_howMuch)
    {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Advice" message:@"You May Feel Unhealthy By Drinking More Now" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    }

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)glassSize:(id)sender {
    __block AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
  __block  NSString *x=[[NSString alloc]init];
    __block UIAlertController *alertController;
   UIAlertController* alert = [UIAlertController alertControllerWithTitle:nil
                                                                   message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction* action7 = [UIAlertAction actionWithTitle:@"CUSTOM" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        alertController =
        [UIAlertController alertControllerWithTitle:@"CUSTOM SIZE(ml)"
                                            message:nil
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            textField.font=[UIFont fontWithName:@"Helvetica Neue Bold" size:23];
            textField.keyboardType=UIKeyboardTypeNumberPad;
            x=[NSString stringWithFormat:@"%d",[delegate.glassSize intValue]];
            textField.text=x;
        }];
        UIAlertAction* saveButton = [UIAlertAction actionWithTitle:@"SAVE"
                                                             style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction * action)
                                     {
                                         x=alertController.textFields.firstObject.text;
                                         x=[NSString stringWithFormat:@"%d ml",[x intValue]];
                                         delegate.glassSize= x;
                                         
//                                         [self dismissViewControllerAnimated:YES completion:^{
//                                             
//                                         }];
                                         [self drank];
                                     }];
        
        UIAlertAction* cancelButton = [UIAlertAction actionWithTitle:@"CANCEL"
                                                               style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * action)
                                       {
                                           
                                           NSLog(@"you pressed Cancel button");
                                          // [self dismissViewControllerAnimated:YES completion:nil];
                                           
                                           
                                       }];

        [alertController addAction:saveButton];
        [alertController addAction:cancelButton];
        [self presentViewController:alertController animated:YES completion:nil];
    }];
    UIAlertAction* action8 = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
       
       // [self dismissViewControllerAnimated:YES completion:nil];
    }];

    UIAlertAction* action1 = [UIAlertAction actionWithTitle:@"150 ml" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        delegate.glassSize=@"150 ml";
//        [self dismissViewControllerAnimated:YES completion:^{
//            
//        }];
        [self drank];
    }];
    UIAlertAction* action2 = [UIAlertAction actionWithTitle:@"200 ml" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        delegate.glassSize=@"200 ml";
//        [self dismissViewControllerAnimated:YES completion:^{
//            
//        }];
        [self drank];
    }];
    UIAlertAction* action3 = [UIAlertAction actionWithTitle:@"250 ml" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        delegate.glassSize=@"250 ml";
       // [self dismissViewControllerAnimated:YES completion:^{
            
        //}];
        [self drank];
    }];
    UIAlertAction* action4 = [UIAlertAction actionWithTitle:@"300 ml" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        delegate.glassSize=@"300 ml";
//        [self dismissViewControllerAnimated:YES completion:^{
//            
//        }];
        [self drank];
    }];
    UIAlertAction* action5 = [UIAlertAction actionWithTitle:@"400 ml" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        delegate.glassSize=@"400 ml";
//        [self dismissViewControllerAnimated:YES completion:^{
//            
//        }];
        [self drank];
    }];
    UIAlertAction* action6 = [UIAlertAction actionWithTitle:@"500 ml" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        delegate.glassSize=@"500 ml";
//        [self dismissViewControllerAnimated:YES completion:^{
//            
//        }];
        [self drank];   }];
    [alert addAction:action8];
    [alert addAction:action7];
    [alert addAction:action1];
    [alert addAction:action2];
    [alert addAction:action3];
    [alert addAction:action4];
    [alert addAction:action5];
    [alert addAction:action6];
    [self presentViewController:alert animated:YES completion:nil];
}



#pragma mark- Delegate

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return _intr;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    [[collectionView cellForItemAtIndexPath:indexPath]clearsContextBeforeDrawing];
    static NSString *CellIdentifier = @"Flickr Photo Cell";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    [cell clearsContextBeforeDrawing];
    [cell.contentView setNeedsDisplay];
  //  UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(cell.contentView.frame.origin.x, (cell.contentView.frame.origin.y),cell.contentView.frame.size.width ,(cell.contentView.frame.size.height-20.0))];
   // imageView.image=[UIImage imageNamed:@"1"];
    
    
     NSLog(@"%f   %f",cell.bounds.size.width,cell.bounds.size.height);
    UITextField *field=[[UITextField alloc]initWithFrame:CGRectMake(cell.contentView.frame.origin.x, cell.contentView.frame.origin.y+95, cell.contentView.frame.size.width, 19.0)];
    [field setAllowsEditingTextAttributes:NO];
    field.userInteractionEnabled=NO;
    field.textAlignment=NSTextAlignmentCenter;
    field.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    field.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
    field.backgroundColor=[UIColor lightGrayColor];
    NSManagedObjectContext *context=[self managedObjectContext];
    NSFetchRequest *request=[[NSFetchRequest alloc]initWithEntityName:@"Details"];
    NSDateFormatter *dateformat=[[NSDateFormatter alloc]init];
    [dateformat setDateFormat:@"yyyy-MM-dd"];
    NSDate *now=[[NSDate alloc]init];
    request.predicate = [NSPredicate predicateWithFormat:@"date contains %@",[dateformat stringFromDate:now]];
   NSSortDescriptor *sortDescriptors=[[NSSortDescriptor alloc]initWithKey:@"drank" ascending:YES];
    [request setSortDescriptors:@[sortDescriptors]];
    NSArray *dev=[[context executeFetchRequest:request error:nil] mutableCopy];
    NSLog(@"%ld",(long)indexPath.row);
    field.text=[NSString stringWithFormat:@"%@",[[dev objectAtIndex:indexPath.row] valueForKey:@"drank"]];
    UIImageView *imageView;
    if([field.text isEqual:@"150 ml"])
    {
        imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"1"]];
        
    }
    else if ([field.text isEqual:@"200 ml"])
    {
         imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"1"]];
    }
    else if ([field.text isEqual:@"250 ml"])
    {
         imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"1"]];    }
    else if ([field.text isEqual:@"300 ml"])
    {
        imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"1"]];
    }
    else if ([field.text isEqual:@"400 ml"])
    {
         imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"1"]];
    }
    else if ([field.text isEqual:@"500 ml"])
    {
         imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"1"]];
    }
    else
    {
           imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"1"]];
    }
    imageView.contentMode=UIViewContentModeScaleAspectFit;
    NSLog(@"%@",imageView.image);
    [cell addSubview:imageView];
    [cell addSubview:field];
    return cell;
}

@end
