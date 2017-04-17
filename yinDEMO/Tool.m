//
//  Tool.m
//  yinDEMO
//
//  Created by taobo on 17/4/17.
//  Copyright © 2017年 rongyun. All rights reserved.
//

#import "Tool.h"

@implementation Tool

+ (void)showAlertViewWithMSG:(NSString *)msg WithController:(UIViewController *)vc{
    UIAlertController * ac = [UIAlertController alertControllerWithTitle:@"提示"
                                                                 message:msg
                                                          preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * cancle = [UIAlertAction actionWithTitle:@"确认"
                                                      style:UIAlertActionStyleCancel
                                                    handler:nil];
    [ac addAction:cancle];
    [vc presentViewController:ac animated:YES completion:nil];
}

@end
