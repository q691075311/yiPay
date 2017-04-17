//
//  SiController.m
//  yinDEMO
//
//  Created by taobo on 17/4/17.
//  Copyright © 2017年 rongyun. All rights reserved.
//

#import "SiController.h"
#import "Tool.h"
#import "UMSCashierPlugin.h"

@interface SiController ()<UMSCashierPluginDelegate>
@property (weak, nonatomic) IBOutlet UITextField *orderID;
@property (weak, nonatomic) IBOutlet UITextField *billsMID;
@property (weak, nonatomic) IBOutlet UITextField *billsTID;

@end

@implementation SiController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"订单查询";
}
- (IBAction)debugging:(UIButton *)sender {
    [UMSCashierPlugin queryOrder:_orderID.text
                        BillsMID:_billsMID.text
                        BillsTID:_billsTID.text
                        Delegate:self
                    ProductModel:NO];
}
- (void)onUMSQueryOrder:(NSDictionary *)dict{
    if ([[dict objectForKey:@"errCode"] isEqualToString:@"0000"]) {
        NSString *result = [[NSString alloc] init];
        for(NSString *s in [dict allKeys])
        {
            result=[result stringByAppendingFormat:@" %@ %@ \n",s,[dict objectForKey:s]]; NSLog(@"%@ %@",s,[dict objectForKey:s]);
        }
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"订单信息查询成功" message:result delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    else {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"订单信息查询失败" message:[dict objectForKey:@"errorMsg"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
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
