//
//  OneController.m
//  yinDEMO
//
//  Created by taobo on 17/4/12.
//  Copyright © 2017年 rongyun. All rights reserved.
//

#import "OneController.h"
#import "UMSCashierPlugin.h"
#import "Tool.h"


@interface OneController ()<UMSCashierPluginDelegate>
@property (weak, nonatomic) IBOutlet UITextField *billsMID;//出账商户号
@property (weak, nonatomic) IBOutlet UITextField *billsTID;//出账商户终端号
@end

@implementation OneController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"设备设置,激活";
    
    //
    
}
- (IBAction)debugging:(UIButton *)sender {
    /*
     * billsMID 出账商户号
     * billsTID 出账商户终端号
     * controller 调用接口的 UIViewController
     * isProd YES:生产环境 NO:测试环境 */
    [UMSCashierPlugin setupDevice:_billsMID.text
                         BillsTID:_billsTID.text
               WithViewController:self
                         Delegate:self
                     ProductModel:NO];
}

// 定义设备设置、激活回调
- (void)onUMSSetupDevice:(BOOL)resultStatus resultInfo:(NSString *)resultInfo withDeviceId:(NSString *)deviceId{
    if(resultStatus == YES) {
        [Tool showAlertViewWithMSG:[NSString stringWithFormat:@"设备绑定成功,设备号为 %@",deviceId]
                    WithController:self];
        NSLog (@"设备绑定成功,设备号为 %@",deviceId);
    }else {
        [Tool showAlertViewWithMSG:@"设备绑定失败" WithController:self];
        NSLog (@"设备绑定失败" );
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
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
