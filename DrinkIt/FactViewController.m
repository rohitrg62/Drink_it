//
//  FactViewController.m
//  Drink Time
//
//  Created by Rohit Gupta on 08/08/17.
//  Copyright © 2017 Rohit Gupta. All rights reserved.
//

#import "FactViewController.h"
#import "AppDelegate.h"
@interface FactViewController () <UITableViewDelegate , UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation FactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    // Do any additional setup after loading the view.
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[self.tableView dequeueReusableCellWithIdentifier:@"Facts"];
    
    

    if (indexPath.row==0) {
        cell.textLabel.text=@"1. Water Relieves Fatigue";
    }
    else if(indexPath.row==1)
    {
         cell.textLabel.text=@"2. Proper Drinking Improves Mood";
    }
    else if(indexPath.row==2)
    {
         cell.textLabel.text=@"3. Treats Headaches and Migraines";
    }
    else if(indexPath.row==3)
    {
         cell.textLabel.text=@"4. Helps in Digestion and Constipation";
    }
    else if(indexPath.row==4)
    {
         cell.textLabel.text=@"5. Aids Weight Loss";
    }
    else if(indexPath.row==5)
    {
         cell.textLabel.text=@"6. Flushes Out Toxins";
    }
    else if(indexPath.row==6)
    {
         cell.textLabel.text=@"7. Regulates Body Temperature";
    }
    else if(indexPath.row==7)
    {
         cell.textLabel.text=@"8. Promotes Healthy Skin";
    }
    else if(indexPath.row==8)
    {
         cell.textLabel.text=@"9. Relieves Hangover";
    }
    else
    {
         cell.textLabel.text=@"10. Beats Bad Breath";
    }
    
    return cell;
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
