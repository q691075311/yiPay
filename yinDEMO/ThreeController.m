//
//  ThreeController.m
//  yinDEMO
//
//  Created by taobo on 17/4/12.
//  Copyright © 2017年 rongyun. All rights reserved.
//

#import "ThreeController.h"
#import "Tool.h"
#import "UMSCashierPlugin.h"

@interface ThreeController ()<UMSCashierPluginDelegate>
@property (weak, nonatomic) IBOutlet UITextField *orderID;
@property (weak, nonatomic) IBOutlet UITextField *billsMID;
@property (weak, nonatomic) IBOutlet UITextField *billsTID;
@property (weak, nonatomic) IBOutlet UITextField *salesSlipType;
@property (weak, nonatomic) IBOutlet UITextField *payType;

@property (weak, nonatomic) IBOutlet UIButton *autoType;
@property (weak, nonatomic) IBOutlet UIButton *paper;
@property (weak, nonatomic) IBOutlet UIButton *ele;

@property (weak, nonatomic) IBOutlet UIButton *epos;
@property (weak, nonatomic) IBOutlet UIButton *mobile;

@property (nonatomic,assign) SalesSlipType salesType;
@property (nonatomic,assign) PayType pType;

@end

@implementation ThreeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"订单支付";
//    self.automaticallyAdjustsScrollViewInsets = NO;
    
}
- (IBAction)autoType:(UIButton *)sender {
    _salesType = SalesSlipType_AUTO;
    [_autoType setTitle:@"SalesSlipType_AUTO" forState:UIControlStateNormal];
}
- (IBAction)paper:(UIButton *)sender {
    [_paper setTitle:@"SalesSlipType_PAPER" forState:UIControlStateNormal];
    _salesType = SalesSlipType_PAPER;
}
- (IBAction)elecyronic:(UIButton *)sender {
    [_ele setTitle:@"SalesSlipType_ELECTRONIC" forState:UIControlStateNormal];
    _salesType = SalesSlipType_ELECTRONIC;
}


- (IBAction)epos:(UIButton *)sender {
    [_epos setTitle:@"PayType_EPOS" forState:UIControlStateNormal];
    _pType = PayType_EPOS;
}
- (IBAction)mobile:(UIButton *)sender {
    [_mobile setTitle:@"PayType_MOBILE" forState:UIControlStateNormal];
    _pType = PayType_MOBILE;
}


- (IBAction)debugging:(UIButton *)sender {
    [UMSCashierPlugin payOrder:_orderID.text
                      BillsMID:_billsMID.text
                      BillsTID:_billsTID.text
            WithViewController:self
                      Delegate:self
                 SalesSlipType:_salesType
                       PayType:_pType
                  ProductModel:NO];
}
- (void)onPayResult:(PayStatus)payStatus PrintStatus:(PrintStatus)printStatus withInfo:(NSDictionary *)dict{
    switch (payStatus) {
        case PayStatus_PAYSUCCESS:
            [Tool showAlertViewWithMSG:@"交易成功" WithController:self];
            NSLog(@"UMSCashie_PayStatus_PAYSUCCESS");
            break;
        case PayStatus_PAYFAIL:
            [Tool showAlertViewWithMSG:@"交易失败" WithController:self];
            NSLog(@"UMSCashier_PayStatus_PAYFAIL");
            break;
        case PayStatus_PAYCANCEL:
            [Tool showAlertViewWithMSG:@"交易取消" WithController:self];
            NSLog(@"UMSCashier_PayStatus_PAYCancel");
            break;
        case PayStatus_PAYTIMEOUT:
            [Tool showAlertViewWithMSG:@"交易超时" WithController:self];
            NSLog(@"UMSCashier_PayStatus_PAYTIMEOUT");
        default:
        break;
    }
    switch (printStatus) {
        case PrintStatus_PRINTSUCCESS:
            [Tool showAlertViewWithMSG:@"打印成功" WithController:self];
            NSLog(@"PrintStatus_PRINTSUCCESS");
            break;
        case PrintStatus_PRINTFAIL:
            [Tool showAlertViewWithMSG:@"打印失败" WithController:self];
            NSLog(@"PrintStatus_PRINTFAIL");
            break;
        default:
        break;
    }
    NSString *result=@"";
    for(NSString * key in dict)
    {
        result=[result stringByAppendingFormat:@"%@:%@ \n",key,[dict objectForKey:key]];
    }
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"支付结果" message:result delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
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
