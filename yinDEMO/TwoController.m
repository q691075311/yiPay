//
//  TwoController.m
//  yinDEMO
//
//  Created by taobo on 17/4/12.
//  Copyright © 2017年 rongyun. All rights reserved.
//

#import "TwoController.h"
#import "UMSCashierPlugin.h"
#import "Tool.h"
@interface TwoController ()<UMSCashierPluginDelegate>
@property (weak, nonatomic) IBOutlet UITextField *menoy;
@property (weak, nonatomic) IBOutlet UITextField *shanghuhao;
@property (weak, nonatomic) IBOutlet UITextField *shanghudingdanshu;
@property (weak, nonatomic) IBOutlet UITextField *chuzhangshanghuID;
@property (weak, nonatomic) IBOutlet UITextField *shanghuzhongduannum;
@property (weak, nonatomic) IBOutlet UITextField *caozuohao;

@end

@implementation TwoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"下单";
    
}
- (IBAction)debugging:(UIButton *)sender {
    [UMSCashierPlugin bookOrder:_menoy.text
                     MerorderId:_shanghuhao.text
                   MerOrderDesc:_shanghudingdanshu.text
                       BillsMID:_chuzhangshanghuID.text
                       BillsTID:_shanghuzhongduannum.text
                       operator:_caozuohao.text
                       Delegate:self
                   ProductModel:NO];
    
}
- (void)onUMSBookOrderResult:(NSDictionary *)dict{
    NSString * orderID = [dict objectForKey:@"orderId"]; if(orderID!= nil)
    {
        [Tool showAlertViewWithMSG:[NSString stringWithFormat:@"下单成功,订单号为 %@",orderID] WithController:self];
        NSLog (@"下单成功,订单号为 %@",orderID);
    }
    else {
        [Tool showAlertViewWithMSG:[NSString stringWithFormat:@"下单失败,错误码为 %@,错误信息为%@",[dict objectForKey:@"errCode"],[ dict objectForKey:@"errInfo"]] WithController:self];
        NSLog(@"下单失败,错误码为 %@,错误信息为%@",[dict objectForKey:@"errCode"],[ dict objectForKey:@"errInfo"]);
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
