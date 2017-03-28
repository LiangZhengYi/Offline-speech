//
//  ViewController.m
//  myDemo
//
//  Created by 公司 on 17/3/8.
//  Copyright © 2017年 PiYa. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UIButton * buttons;//三个骑行方式的按钮
    UIButton * btn;//两个播报方式的按钮
    UIButton * bobaoButton;
    NSString * str;//第一个输入框的字符串
    NSString * timeStr;//第二个输入框的字符串
    NSString * hsStr;//第三个输入框的字符串
    NSString * housStr;//小时
    NSString * minStr;//分钟
    NSString * secondsStr;//秒
    NSArray  * BtnTitleArray;
    UILabel  * lbl;
    UILabel  * llbl;
    UIView   * bgView;
    UITableView    * titleView;
    NSMutableArray * muArray;//单元格 以及数据
    NSNotification * notificaon; //创建通知 ,监听按钮的事件
    NSNotification * notificaonBtn;
    NSNotification * bgNotion;

}
/*
 创建文件的各种播放音效对象 (主要使用SystemSoundID这个类来播放发时间比较短的音效)
 */
@property (nonatomic,assign)SystemSoundID  oneSoundID;
@property (nonatomic,assign)SystemSoundID  zlSoundID;
@property (nonatomic,assign)SystemSoundID  pbSoundID;
@property (nonatomic,assign)SystemSoundID  qxSoundID;
@property (nonatomic,assign)SystemSoundID  glSoundID;
@property (nonatomic,assign)SystemSoundID  psSoundID;
@property (nonatomic,assign)SystemSoundID  xsSoundID;
@property (nonatomic,assign)SystemSoundID  mglSoundID;
@property (nonatomic,assign)SystemSoundID  sdSoundID;
@property (nonatomic,assign)SystemSoundID  mxsSoundID;
@property (nonatomic,assign)SystemSoundID  fzSoundID;
@property (nonatomic,assign)SystemSoundID  minSoundID;
@property (nonatomic,assign)SystemSoundID  fsSoundID;
@property (nonatomic,assign)SystemSoundID  shiSoundID;

//三个数据输入框
@property (nonatomic,strong)UITextField * jlTextField;
@property (nonatomic,strong)UITextField * timeTextField;
@property (nonatomic,strong)UITextField * hsTextField;

//三个数据框的音频
@property (nonatomic,assign)SystemSoundID  csSoundID;
@property (nonatomic,assign)SystemSoundID  timeSoundID;
@property (nonatomic,assign)SystemSoundID  hsSoundID;
@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self textFields];
    [self buttons];
    [self bobaoButton];
    
}
- (void)btnView
{
    bgView = [[UIView alloc]initWithFrame:CGRectMake(110, 130, 250, 35)];
    bgView.backgroundColor = [UIColor cyanColor];
    BtnTitleArray = [[NSArray alloc]initWithObjects:@"按距离",@"按时间", nil];
    for (int i = 0; i<2; i++) {
        btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0+(60+60)*(i%2), 0, 90, 35);
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitle:BtnTitleArray[i] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"YSEvaluateSelectedBtn"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"YSEvaluateNomalBtn"] forState:UIControlStateSelected];
        [btn setImageEdgeInsets:UIEdgeInsetsMake(10, 100, 10, 0)];
        btn.backgroundColor = [UIColor clearColor];
        btn.tag = i;
        btn.selected = YES;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:btn];
        [self.view addSubview:bgView];}
}
#pragma mark---播报按钮
- (void)bobaoButton
{
    bobaoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    bobaoButton.frame = CGRectMake(150, 340, 80, 40);
    [bobaoButton setTitle:@"开始播报" forState:UIControlStateNormal];
    [bobaoButton addTarget:self action:@selector(bbClick:) forControlEvents:UIControlEventTouchUpInside];
    bobaoButton.tag = 0;
    bobaoButton.backgroundColor = [UIColor redColor];
    [self.view addSubview:bobaoButton];
}
- (void)bbClick:(UIButton *)btnn
{
    if (notificaon.name ==nil && notificaonBtn.name == nil ) {
        AudioServicesPlaySystemSound(self.oneSoundID);
        [self performSelector:@selector(method1) withObject:nil afterDelay:1.4];
        [self performSelector:@selector(method2) withObject:nil afterDelay:2];
    }else{
    //接收通知
    if ([notificaonBtn.name isEqualToString:@"juli"] && [notificaon.name isEqualToString:@"zoulu"]) {
        AudioServicesPlaySystemSound(self.oneSoundID);
        [self performSelector:@selector(method1) withObject:nil afterDelay:1.4];
        [self performSelector:@selector(method2) withObject:nil afterDelay:2.5];
    }if ([notificaonBtn.name isEqualToString:@"juli"] && [notificaon.name isEqualToString:@"paobu"]) {
        AudioServicesPlaySystemSound(self.oneSoundID);
        [self performSelector:@selector(paoleMethod) withObject:nil afterDelay:1.4];
        [self performSelector:@selector(method2) withObject:nil afterDelay:2.5];
    }if ([notificaonBtn.name isEqualToString:@"juli"] && [notificaon.name isEqualToString:@"qixing"]) {
        AudioServicesPlaySystemSound(self.oneSoundID);
        [self performSelector:@selector(qileMethod) withObject:nil afterDelay:1.4];
        [self performSelector:@selector(method2) withObject:nil afterDelay:2.5];
    }if ([notificaonBtn.name isEqualToString:@"shijian"] &&[notificaon.name isEqualToString:@"zoulu"]) {
        AudioServicesPlaySystemSound(self.oneSoundID);
        [self performSelector:@selector(method1) withObject:nil afterDelay:1.4];
        [self performSelector:@selector(housStrMethod) withObject:nil afterDelay:2.5];
    }if ([notificaonBtn.name isEqualToString:@"shijian"] &&[notificaon.name isEqualToString:@"paobu"]) {
        AudioServicesPlaySystemSound(self.oneSoundID);
        [self performSelector:@selector(paoleMethod) withObject:nil afterDelay:1.4];
        [self performSelector:@selector(housStrMethod) withObject:nil afterDelay:2.5];
    }if ([notificaonBtn.name isEqualToString:@"shijian"] &&[notificaon.name isEqualToString:@"qixing"]) {
        AudioServicesPlaySystemSound(self.oneSoundID);
        [self performSelector:@selector(qileMethod) withObject:nil afterDelay:1.4];
        [self performSelector:@selector(housStrMethod) withObject:nil afterDelay:2.5];}}
}
#pragma mark----0.存放标题数据的单元格
- (void)UItableViewTitle{
    titleView = [[UITableView alloc]initWithFrame:CGRectMake(110, 20, 250, 100) style:UITableViewStylePlain];
    titleView.delegate = self;
    titleView.dataSource = self;
    [self.view addSubview:titleView];
    muArray = [[NSMutableArray alloc]init];
    NSArray * titleArray = [[NSArray alloc]initWithObjects:@"走路",@"跑步",@"骑行", nil];
    [muArray addObject:titleArray];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return muArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [muArray[section]count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor cyanColor];
    }
    cell.textLabel.text = muArray[indexPath.section][indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray * array = [tableView visibleCells];
    for (UITableViewCell * cell  in array) {
        [cell setAccessoryType:UITableViewCellAccessoryNone];
        cell.textLabel.textColor = [UIColor blackColor];
    }
    UITableViewCell * cell = [titleView cellForRowAtIndexPath:indexPath];
    cell.textLabel.textColor = [UIColor redColor];
    [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    if (indexPath.row == 0) {
        //发送通知
        notificaon = [[NSNotification alloc]initWithName:@"zoulu" object:self userInfo:nil];
        bgNotion = [[NSNotification alloc]initWithName:@"zoulu" object:self userInfo:nil];
        [self performSelector:@selector(bgMethod) withObject:nil afterDelay:0.5];
    }if (indexPath.row == 1 ) {
        notificaon = [[NSNotification alloc]initWithName:@"paobu" object:self userInfo:nil];
        bgNotion = [[NSNotification alloc]initWithName:@"paobu" object:self userInfo:nil];
        [self performSelector:@selector(bgMethod) withObject:nil afterDelay:0.5];
    }if (indexPath.row == 2) {
        notificaon = [[NSNotification alloc]initWithName:@"qixing" object:self userInfo:nil];
        bgNotion = [[NSNotification alloc]initWithName:@"qixing" object:self userInfo:nil];
        [self performSelector:@selector(bgMethod) withObject:nil afterDelay:0.5];}
}
- (void)bgMethod
{
    [UIView animateWithDuration:0.5 animations:^{
        titleView.frame = CGRectMake(10000, 20, 0, 0);
    } completion:^(BOOL finished) {
        lbl = [[UILabel alloc]initWithFrame:CGRectMake(120, 23, 60, 30)];
        lbl.backgroundColor = [UIColor cyanColor];
        if ([bgNotion.name isEqualToString:@"zoulu"]) {
            lbl.text = @"走路";
        }
        if ([bgNotion.name isEqualToString:@"paobu"]) {
            lbl.text = @"跑步";
        }
        if ([bgNotion.name isEqualToString:@"qixing"]) {
            lbl.text = @"骑行";
        }
        [self.view addSubview:lbl];}];
}
- (void)BtnMethod
{
    [UIView animateWithDuration:0.5 animations:^{
        bgView.frame = CGRectMake(10000, 130, 0, 0);
    } completion:^(BOOL finished) {
        llbl = [[UILabel alloc]initWithFrame:CGRectMake(120, 133, 60, 30)];
        llbl.backgroundColor = [UIColor cyanColor];
        if ([bgNotion.name isEqualToString:@"jl"]) {
            llbl.text = @"按距离";
        }
        if ([bgNotion.name isEqualToString:@"sj"]) {
            llbl.text = @"按时间";
        }
        [self.view addSubview:llbl];}];
}
#pragma mark ---1.创建三个运动方式按钮
- (void)buttons{
    lbl =[[UILabel alloc]initWithFrame:CGRectMake(120, 23, 60, 30)];
    lbl.backgroundColor = [UIColor cyanColor];
    lbl.text = @"走路";
    [self.view addSubview:lbl];
    llbl = [[UILabel alloc]initWithFrame:CGRectMake(120, 133, 60, 30)];
    llbl.backgroundColor = [UIColor cyanColor];
    llbl.text = @"按距离";
    [self.view addSubview:llbl];
    NSArray * array = [[NSArray alloc]initWithObjects:@"运动项目:",@"播报方式:", nil];
    for (int i = 0; i<2; i++) {
        buttons = [UIButton buttonWithType:UIButtonTypeCustom];
        buttons.frame = CGRectMake(20, 20+(55+55)*(i%3), 80,40);
        buttons.showsTouchWhenHighlighted= YES;
        buttons.backgroundColor =  [UIColor lightGrayColor];
        buttons.tag = i;
        [buttons addTarget:self action:@selector(Click:) forControlEvents:UIControlEventTouchUpInside];
        [buttons setTitle:array[i] forState:UIControlStateNormal];
        [self.view addSubview:buttons];}
}
- (void)Click:(UIButton *)seleBtn{
    switch (seleBtn.tag) {
        case 0:
        {
            [self UItableViewTitle];
        }break;
        case 1:
        {
            [self btnView];
        }break;}
}
#pragma mark----3.两种播报方式的方法
- (void)btnClick:(UIButton *)btns{
    switch (btns.tag) {
        case 0:
        {
            btn.selected = btns;
            btns.selected = NO;
        notificaonBtn = [[NSNotification alloc]initWithName:@"juli" object:self userInfo:nil];
            bgNotion = [[NSNotification alloc]initWithName:@"jl" object:self userInfo:nil];
            [self performSelector:@selector(BtnMethod) withObject:nil afterDelay:0.5];
        }break;
        case 1:
        {
            btn.selected = btns;
            btns.selected = NO;
            notificaonBtn = [[NSNotification alloc]initWithName:@"shijian" object:self userInfo:nil];
            bgNotion = [[NSNotification alloc]initWithName:@"sj" object:self userInfo:nil];
            [self performSelector:@selector(BtnMethod) withObject:nil afterDelay:0.5];
        }break;}
}
#pragma mark---4.创建三个数据框
- (void)textFields{
    _jlTextField = [[UITextField alloc]init];
    _jlTextField.frame = CGRectMake(20, 200, 100, 40);
    _jlTextField.backgroundColor = [UIColor brownColor];
    [self.view addSubview:_jlTextField];
    UILabel * jlLbl = [[UILabel alloc]init];
    jlLbl.frame = CGRectMake(20, 240, 110, 40);
    jlLbl.font = [UIFont systemFontOfSize:15];
    jlLbl.text = @"均速:公里/小时";
    [self.view addSubview:jlLbl];
    
    _timeTextField = [[UITextField alloc]init];
    _timeTextField.frame = CGRectMake(140, 200, 100, 40);
    _timeTextField.backgroundColor = [UIColor brownColor];
    [self.view addSubview:_timeTextField];
    UILabel * timeLbl = [[UILabel alloc]init];
    timeLbl.frame = CGRectMake(140, 240, 110, 40);
    timeLbl.font = [UIFont systemFontOfSize:15];
    timeLbl.text = @"配速:分钟/公里";
    [self.view addSubview:timeLbl];
    
    _hsTextField = [[UITextField alloc]init];
    _hsTextField.frame = CGRectMake(260, 200, 100, 40);
    _hsTextField.backgroundColor = [UIColor brownColor];
    [self.view addSubview:_hsTextField];
    UILabel * hsLbl = [[UILabel alloc]init];
    hsLbl.frame = CGRectMake(270, 240, 110, 40);
    hsLbl.font = [UIFont systemFontOfSize:15];
    hsLbl.text = @"消耗:大卡";
    [self.view addSubview:hsLbl];
}
#pragma mark ---5.创建按距离\按时间的音频数据文件
- (SystemSoundID )oneSoundID
{
    if (_oneSoundID == 0) {
        NSURL * url = [[NSBundle mainBundle]URLForResource:@"你已经.mp3" withExtension:nil];
        AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &(_oneSoundID));
    }
    return _oneSoundID;
}
#pragma mark---6.判断输入框的数字是否是整型(纯数字)
- (BOOL)isPureInt:(NSString *)string{
    NSScanner * scan = [NSScanner scannerWithString:str];
    int vol;
    return [scan scanInt:&vol]&&[scan isAtEnd];
}
- (BOOL)timePureInt:(NSString *)string{
    NSScanner * scan = [NSScanner scannerWithString:timeStr];
    int vol;
    return [scan scanInt:&vol]&&[scan isAtEnd];
}
- (BOOL)hsPureInt:(NSString *)string{
    NSScanner * scan = [NSScanner scannerWithString:hsStr];
    int vol;
    return [scan scanInt:&vol]&&[scan isAtEnd];
}
#pragma mark---7.第一个输入框的数据(按距离方式)
- (void)method2{
    str = _jlTextField.text;
    if ([self isPureInt:str] == YES) {
        if (_jlTextField.text.length == 1) {
            NSString * strr = [NSString stringWithFormat:@"%@.mp3",_jlTextField.text];
            NSURL * url = [[NSBundle mainBundle]URLForResource:strr withExtension:nil];
            AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &(_csSoundID));
            AudioServicesPlayAlertSound(_csSoundID);
            [self performSelector:@selector(method3) withObject:nil afterDelay:0.5];/////
            [self performSelector:@selector(method4) withObject:nil afterDelay:1.5];
            [self performSelector:@selector(method5) withObject:nil afterDelay:3];
        }if (_jlTextField.text.length == 2) {
            NSString * str1 =[str substringWithRange:NSMakeRange(0, 1)];
            NSString * sttr = [NSString stringWithFormat:@"%@.mp3",str1];
            NSURL * url = [[NSBundle mainBundle]URLForResource:sttr withExtension:nil];
            AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &(_csSoundID));
            AudioServicesPlayAlertSound(_csSoundID);
            NSString * str2 =[str substringWithRange:NSMakeRange(1, 1)];
            if ([str2 isEqualToString:@"0"]) {
                [self performSelector:@selector(shiMethod) withObject:nil afterDelay:0.5];
                [self performSelector:@selector(method3) withObject:nil afterDelay:1];
                [self performSelector:@selector(method4) withObject:nil afterDelay:1.5];
                [self performSelector:@selector(method5) withObject:nil afterDelay:3];
            }else{
                [self performSelector:@selector(shiMethod) withObject:nil afterDelay:0.5];
                [self performSelector:@selector(method15) withObject:nil afterDelay:1.0];
                [self performSelector:@selector(method3) withObject:nil afterDelay:1.5];//
                [self performSelector:@selector(method4) withObject:nil afterDelay:2.5];
                [self performSelector:@selector(method5) withObject:nil afterDelay:4];}
        }if (_jlTextField.text.length == 3) {
            NSString * str1 =[str substringWithRange:NSMakeRange(0, 1)];
            if ([str1 isEqualToString:@"2"]) {
                NSURL * url = [[NSBundle mainBundle]URLForResource:@"两.mp3" withExtension:nil];
                AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &(_csSoundID));
                AudioServicesPlayAlertSound(_csSoundID);
            }else{
                NSString * sttr = [NSString stringWithFormat:@"%@.mp3",str1];
                NSURL * url = [[NSBundle mainBundle]URLForResource:sttr withExtension:nil];
                AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &(_csSoundID));
                AudioServicesPlayAlertSound(_csSoundID);
            }
            NSString * str2 =[str substringWithRange:NSMakeRange(1, 1)];
            NSString * str3 =[str substringWithRange:NSMakeRange(2, 1)];
            if ([str2 isEqualToString:@"0"] && [str3 isEqualToString:@"0"]) {
                [self performSelector:@selector(baiMethod) withObject:nil afterDelay:0.8];
                [self performSelector:@selector(method3) withObject:nil afterDelay:1.5];
                [self performSelector:@selector(method4) withObject:nil afterDelay:2];
                [self performSelector:@selector(method5) withObject:nil afterDelay:3.5];
                return;
            }if ([str2 isEqualToString:@"0"] && str3 != 0) {
                [self performSelector:@selector(baiMethod) withObject:nil afterDelay:0.8];
                [self performSelector:@selector(lingMethod) withObject:nil afterDelay:1.3];
                [self performSelector:@selector(method16) withObject:nil afterDelay:1.8];
                [self performSelector:@selector(method3) withObject:nil afterDelay:2.3];//
                [self performSelector:@selector(method4) withObject:nil afterDelay:3.3];
                [self performSelector:@selector(method5) withObject:nil afterDelay:4.8];
                return;
            }else if ([str3 isEqualToString:@"0"] && str2 != 0) {
                [self performSelector:@selector(baiMethod) withObject:nil afterDelay:0.8];
                [self performSelector:@selector(method15) withObject:nil afterDelay:1.3];
                [self performSelector:@selector(shiMethod) withObject:nil afterDelay:1.8];
                [self performSelector:@selector(method3) withObject:nil afterDelay:2.3];//
                [self performSelector:@selector(method4) withObject:nil afterDelay:3.3];
                [self performSelector:@selector(method5) withObject:nil afterDelay:4.8];
                return;
            }else{
                [self performSelector:@selector(baiMethod) withObject:nil afterDelay:0.7];
                [self performSelector:@selector(method15)];
                [self performSelector:@selector(shiMethod) withObject:nil afterDelay:1.7];
                [self performSelector:@selector(method16) withObject:nil afterDelay:2.2];
                [self performSelector:@selector(method3) withObject:nil afterDelay:2.7];//
                [self performSelector:@selector(method4) withObject:nil afterDelay:3.7];
                [self performSelector:@selector(method5) withObject:nil afterDelay:5.2];}
        }if (_jlTextField.text.length == 4) {
            NSString * str1 =[str substringWithRange:NSMakeRange(0, 1)];
            if ([str1 isEqualToString:@"2"]) {
                NSURL * url = [[NSBundle mainBundle]URLForResource:@"两.mp3" withExtension:nil];
                AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &(_csSoundID));
                AudioServicesPlayAlertSound(_csSoundID);
            }else{
                NSString * sttr = [NSString stringWithFormat:@"%@.mp3",str1];
                NSURL * url = [[NSBundle mainBundle]URLForResource:sttr withExtension:nil];
                AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &(_csSoundID));
                AudioServicesPlayAlertSound(_csSoundID);
            }
            NSString * str2 =[str substringWithRange:NSMakeRange(1, 1)];
            NSString * str3 =[str substringWithRange:NSMakeRange(2, 1)];
            NSString * str4 =[str substringWithRange:NSMakeRange(3, 1)];
            if ([str2 isEqualToString:@"0"] && [str3 isEqualToString:@"0"] && [str4 isEqualToString:@"0"]) {
                [self performSelector:@selector(qianMethod) withObject:nil afterDelay:0.7];
                [self performSelector:@selector(method3) withObject:nil afterDelay:1.2];//
                [self performSelector:@selector(method4) withObject:nil afterDelay:1.8];
                [self performSelector:@selector(method5) withObject:nil afterDelay:2.8];
                return;
            }if ([str2 isEqualToString:@"0"] && [str3 isEqualToString:@"0"]) {
                [self performSelector:@selector(qianMethod) withObject:nil afterDelay:0.7];
                [self performSelector:@selector(lingMethod) withObject:nil afterDelay:1.2];
                [self performSelector:@selector(method17) withObject:nil afterDelay:1.7];
                [self performSelector:@selector(method3) withObject:nil afterDelay:2.3];//
                [self performSelector:@selector(method4) withObject:nil afterDelay:2.8];
                [self performSelector:@selector(method5) withObject:nil afterDelay:3.8];
                return;
            }if ([str2 isEqualToString:@"0"] && [str4 isEqualToString:@"0"]) {
                [self performSelector:@selector(qianMethod) withObject:nil afterDelay:0.7];
                [self performSelector:@selector(lingMethod) withObject:nil afterDelay:1.2];
                [self performSelector:@selector(method16) withObject:nil afterDelay:1.7];
                [self performSelector:@selector(shiMethod) withObject:nil afterDelay:2.2];
                [self performSelector:@selector(method3) withObject:nil afterDelay:2.7];//
                [self performSelector:@selector(method4) withObject:nil afterDelay:3.2];
                [self performSelector:@selector(method5) withObject:nil afterDelay:4.2];
                return;
            }if ([str3 isEqualToString:@"0"] && [str4 isEqualToString:@"0"]) {
                [self performSelector:@selector(qianMethod) withObject:nil afterDelay:0.7];
                [self performSelector:@selector(method15) withObject:nil afterDelay:1.2];
                [self performSelector:@selector(baiMethod) withObject:nil afterDelay:1.7];
                [self performSelector:@selector(method3) withObject:nil afterDelay:2.2];//
                [self performSelector:@selector(method4) withObject:nil afterDelay:3];
                [self performSelector:@selector(method5) withObject:nil afterDelay:4];
                return;
            }if ([str2 isEqualToString:@"0"]) {
                [self performSelector:@selector(qianMethod) withObject:nil afterDelay:0.7];
                [self performSelector:@selector(lingMethod) withObject:nil afterDelay:1.2];
                [self performSelector:@selector(method16) withObject:nil afterDelay:1.7];
                [self performSelector:@selector(shiMethod) withObject:nil afterDelay:2.2];
                [self performSelector:@selector(method17) withObject:nil afterDelay:2.7];
                [self performSelector:@selector(method3) withObject:nil afterDelay:3.2];//
                [self performSelector:@selector(method4) withObject:nil afterDelay:4.7];
                [self performSelector:@selector(method5) withObject:nil afterDelay:6.7];
                return;
            }if ([str3 isEqualToString:@"0"]) {
                [self performSelector:@selector(qianMethod) withObject:nil afterDelay:0.7];
                [self performSelector:@selector(method15) withObject:nil afterDelay:1.2];
                [self performSelector:@selector(baiMethod) withObject:nil afterDelay:1.7];
                [self performSelector:@selector(lingMethod) withObject:nil afterDelay:2.2];
                [self performSelector:@selector(method17) withObject:nil afterDelay:2.7];
                [self performSelector:@selector(method3) withObject:nil afterDelay:3.2];//
                [self performSelector:@selector(method4) withObject:nil afterDelay:4.7];
                [self performSelector:@selector(method5) withObject:nil afterDelay:6.7];
                return;
            }if ([str4 isEqualToString:@"0"]) {
                [self performSelector:@selector(qianMethod) withObject:nil afterDelay:0.7];
                [self performSelector:@selector(method15) withObject:nil afterDelay:1.2];
                [self performSelector:@selector(baiMethod) withObject:nil afterDelay:1.7];
                [self performSelector:@selector(method16) withObject:nil afterDelay:2.2];
                [self performSelector:@selector(shiMethod) withObject:nil afterDelay:2.7];
                [self performSelector:@selector(method3) withObject:nil afterDelay:3.2];//
                [self performSelector:@selector(method4) withObject:nil afterDelay:4.7];
                [self performSelector:@selector(method5) withObject:nil afterDelay:6.7];
            }else{
                [self performSelector:@selector(qianMethod) withObject:nil afterDelay:0.7];
                [self performSelector:@selector(method15) withObject:nil afterDelay:1.2];
                [self performSelector:@selector(baiMethod) withObject:nil afterDelay:1.7];
                [self performSelector:@selector(method16) withObject:nil afterDelay:2.2];
                [self performSelector:@selector(shiMethod) withObject:nil afterDelay:2.7];
                [self performSelector:@selector(method17) withObject:nil afterDelay:3.2];
                [self performSelector:@selector(method3) withObject:nil afterDelay:3.7];//
                [self performSelector:@selector(method4) withObject:nil afterDelay:4.2];
                [self performSelector:@selector(method5) withObject:nil afterDelay:6.2];}}
    }else{
        if (str.length>1) {
            if (str.length == 4 ){
                NSString * str1 =[str substringWithRange:NSMakeRange(0, 1)];
                NSString * stt = [NSString stringWithFormat:@"%@.mp3",str1];
                NSURL * url = [[NSBundle mainBundle]URLForResource:stt withExtension:nil];
                AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &(_csSoundID));
                    AudioServicesPlayAlertSound(_csSoundID);
                NSString * str2 =[str substringWithRange:NSMakeRange(2, 1)];
                NSString * str3 =[str substringWithRange:NSMakeRange(3, 1)];
                if ([str2 isEqualToString:@"0"] && [str3 isEqualToString:@"0"]) {
                    [self performSelector:@selector(method3) withObject:nil afterDelay:0.5];//
                    [self performSelector:@selector(method4) withObject:nil afterDelay:1];
                    [self performSelector:@selector(method5) withObject:nil afterDelay:1.8];
                }else{
                    [self performSelector:@selector(dianMethod) withObject:nil afterDelay:0.5];
                    [self performSelector:@selector(yy) withObject:nil afterDelay:1.0];
                    [self performSelector:@selector(gg) withObject:nil afterDelay:1.5];
                    [self performSelector:@selector(method3) withObject:nil afterDelay:2];//
                    [self performSelector:@selector(method4) withObject:nil afterDelay:3.3];
                    [self performSelector:@selector(method5) withObject:nil afterDelay:5];}
            }else if (str.length == 5){
                NSString * str1 =[str substringWithRange:NSMakeRange(0, 1)];
                NSString * stt = [NSString stringWithFormat:@"%@.mp3",str1];
                NSURL * url = [[NSBundle mainBundle]URLForResource:stt withExtension:nil];
                AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &(_csSoundID));
                AudioServicesPlayAlertSound(_csSoundID);
                NSString * sstr1 =[str substringWithRange:NSMakeRange(1, 1)];
                NSString * str2 =[str substringWithRange:NSMakeRange(3, 1)];
                NSString * str3 =[str substringWithRange:NSMakeRange(4, 1)];
                if ([str2 isEqualToString:@"0"] && [str3 isEqualToString:@"0"] && [sstr1 isEqualToString:@"0"]) {
                    [self performSelector:@selector(shiMethod) withObject:nil afterDelay:0.5];
                    [self performSelector:@selector(method3) withObject:nil afterDelay:1];//
                    [self performSelector:@selector(method4) withObject:nil afterDelay:1.5];
                    [self performSelector:@selector(method5) withObject:nil afterDelay:3];
                    return;
                }if ([str2 isEqualToString:@"0"] && [str3 isEqualToString:@"0"] && sstr1 != 0) {
                    [self performSelector:@selector(shiMethod) withObject:nil afterDelay:0.5];
                    [self performSelector:@selector(cc) withObject:nil afterDelay:1];
                    [self performSelector:@selector(method3) withObject:nil afterDelay:1.5];//
                    [self performSelector:@selector(method4) withObject:nil afterDelay:2];
                    [self performSelector:@selector(method5) withObject:nil afterDelay:3.5];
                    return;
                }if ([sstr1 isEqualToString:@"0"]) {
                    [self performSelector:@selector(shiMethod) withObject:nil afterDelay:0.5];
                    [self performSelector:@selector(dianMethod) withObject:nil afterDelay:1];
                    [self performSelector:@selector(gg) withObject:nil afterDelay:1.5];
                    [self performSelector:@selector(aa) withObject:nil afterDelay:2];
                    [self performSelector:@selector(method3) withObject:nil afterDelay:2.5];//
                    [self performSelector:@selector(method4) withObject:nil afterDelay:3.8];
                    [self performSelector:@selector(method5) withObject:nil afterDelay:5.5];
                }else{
                    [self performSelector:@selector(shiMethod) withObject:nil afterDelay:0.4];
                    [self performSelector:@selector(cc) withObject:nil afterDelay:0.8];
                    [self performSelector:@selector(dianMethod) withObject:nil afterDelay:1.5];
                    [self performSelector:@selector(gg) withObject:nil afterDelay:2.0];
                    [self performSelector:@selector(aa) withObject:nil afterDelay:2.5];
                    [self performSelector:@selector(method3) withObject:nil afterDelay:3];//
                    [self performSelector:@selector(method4) withObject:nil afterDelay:3.8];
                    [self performSelector:@selector(method5) withObject:nil afterDelay:5.5];}
            }else if (str.length == 6){
                NSString * str1 =[str substringWithRange:NSMakeRange(0, 1)];
                if ([str1 isEqualToString:@"2"]) {
                    NSURL * url = [[NSBundle mainBundle]URLForResource:@"两.mp3" withExtension:nil];
                    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &(_csSoundID));
                    AudioServicesPlayAlertSound(_csSoundID);
                }else{
                    NSString * stt = [NSString stringWithFormat:@"%@.mp3",str1];
                    NSURL * url = [[NSBundle mainBundle]URLForResource:stt withExtension:nil];
                    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &(_csSoundID));
                    AudioServicesPlayAlertSound(_csSoundID);
                }
                NSString * sstr1 =[str substringWithRange:NSMakeRange(1, 1)];
                NSString * str2 =[str substringWithRange:NSMakeRange(2, 1)];
                NSString * str4 =[str substringWithRange:NSMakeRange(4, 1)];
                NSString * str5 =[str substringWithRange:NSMakeRange(5, 1)];
                if ([sstr1 isEqualToString:@"0"] && [str2 isEqualToString:@"0"] && [str4 isEqualToString:@"0"] && [str5 isEqualToString:@"0"]) {
                    [self performSelector:@selector(baiMethod) withObject:nil afterDelay:0.7];
                    [self performSelector:@selector(method3) withObject:nil afterDelay:1.2];//
                    [self performSelector:@selector(method4) withObject:nil afterDelay:2];
                    [self performSelector:@selector(method5) withObject:nil afterDelay:3.2];
                    return;
                }if ([str2 isEqualToString:@"0"] && [str4 isEqualToString:@"0"] && [str5 isEqualToString:@"0"]) {
                     [self performSelector:@selector(baiMethod) withObject:nil afterDelay:0.7];
                     [self performSelector:@selector(cc) withObject:nil afterDelay:1.2];
                     [self performSelector:@selector(shiMethod) withObject:nil afterDelay:1.7];
                     [self performSelector:@selector(method3) withObject:nil afterDelay:2.2];//
                     [self performSelector:@selector(method4) withObject:nil afterDelay:3.2];
                     [self performSelector:@selector(method5) withObject:nil afterDelay:4.4];
                    return;
                }if ([sstr1 isEqualToString:@"0"] && [str4 isEqualToString:@"0"] && [str5 isEqualToString:@"0"]) {
                    [self performSelector:@selector(baiMethod) withObject:nil afterDelay:0.7];
                    [self performSelector:@selector(lingMethod) withObject:nil afterDelay:1.2];
                    [self performSelector:@selector(yy) withObject:nil afterDelay:1.7];
                    [self performSelector:@selector(method3) withObject:nil afterDelay:2.2];//
                    [self performSelector:@selector(method4) withObject:nil afterDelay:3.2];
                    [self performSelector:@selector(method5) withObject:nil afterDelay:4.5];
                    return;
                }if (str2 != 0 && [str4 isEqualToString:@"0"] && [str5 isEqualToString:@"0"]) {
                    [self performSelector:@selector(baiMethod) withObject:nil afterDelay:0.7];
                    [self performSelector:@selector(cc) withObject:nil afterDelay:1.2];
                    [self performSelector:@selector(shiMethod) withObject:nil afterDelay:1.7];
                    [self performSelector:@selector(yy) withObject:nil afterDelay:2.2];
                    [self performSelector:@selector(method3) withObject:nil afterDelay:2.7];//
                    [self performSelector:@selector(method4) withObject:nil afterDelay:3.5];
                    [self performSelector:@selector(method5) withObject:nil afterDelay:4.7];
                    return;
                }if ([sstr1 isEqualToString:@"0"] && [str2 isEqualToString:@"0"]) {
                    [self performSelector:@selector(baiMethod) withObject:nil afterDelay:0.7];
                    [self performSelector:@selector(dianMethod) withObject:nil afterDelay:1.2];
                    [self performSelector:@selector(aa) withObject:nil afterDelay:1.7];
                    [self performSelector:@selector(dd) withObject:nil afterDelay:2.2];
                    [self performSelector:@selector(method3) withObject:nil afterDelay:2.7];//
                    [self performSelector:@selector(method4) withObject:nil afterDelay:3.5];
                    [self performSelector:@selector(method5) withObject:nil afterDelay:4.7];
                    return;
                }if ([sstr1 isEqualToString:@"0"]) {
                    [self performSelector:@selector(baiMethod) withObject:nil afterDelay:0.7];
                    [self performSelector:@selector(lingMethod) withObject:nil afterDelay:1.2];
                    [self performSelector:@selector(yy) withObject:nil afterDelay:1.7];
                    [self performSelector:@selector(dianMethod) withObject:nil afterDelay:2.2];
                    [self performSelector:@selector(aa) withObject:nil afterDelay:2.7];
                    [self performSelector:@selector(dd) withObject:nil afterDelay:3.2];
                    [self performSelector:@selector(method3) withObject:nil afterDelay:3.7];//
                    [self performSelector:@selector(method4) withObject:nil afterDelay:5];
                    [self performSelector:@selector(method5) withObject:nil afterDelay:6.7];
                    return;
                }if ([str2 isEqualToString:@"0"]) {
                    [self performSelector:@selector(baiMethod) withObject:nil afterDelay:0.7];
                    [self performSelector:@selector(cc) withObject:nil afterDelay:1.2];
                    [self performSelector:@selector(shiMethod) withObject:nil afterDelay:1.7];
                    [self performSelector:@selector(dianMethod) withObject:nil afterDelay:2.2];
                    [self performSelector:@selector(aa) withObject:nil afterDelay:2.7];
                    [self performSelector:@selector(dd) withObject:nil afterDelay:3.2];
                    [self performSelector:@selector(method3) withObject:nil afterDelay:3.7];
                    [self performSelector:@selector(method4) withObject:nil afterDelay:5];
                    [self performSelector:@selector(method5) withObject:nil afterDelay:6.7];
                    return;
                }else{
                    [self performSelector:@selector(baiMethod) withObject:nil afterDelay:0.7];
                    [self performSelector:@selector(cc) withObject:nil afterDelay:1.2];
                    [self performSelector:@selector(shiMethod) withObject:nil afterDelay:1.7];
                    [self performSelector:@selector(yy) withObject:nil afterDelay:2.2];
                    [self performSelector:@selector(dianMethod) withObject:nil afterDelay:2.8];
                    [self performSelector:@selector(aa) withObject:nil afterDelay:3.2];
                    [self performSelector:@selector(dd) withObject:nil afterDelay:3.7];
                    [self performSelector:@selector(method3) withObject:nil afterDelay:4.2];
                    [self performSelector:@selector(method4) withObject:nil afterDelay:5];
                    [self performSelector:@selector(method5) withObject:nil afterDelay:6.7];}
            }else if (str.length == 7){
                NSString * str1 =[str substringWithRange:NSMakeRange(0, 1)];
                if ([str1 isEqualToString:@"2"]) {
                    NSURL * url = [[NSBundle mainBundle]URLForResource:@"两.mp3" withExtension:nil];
                    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &(_csSoundID));
                    AudioServicesPlayAlertSound(_csSoundID);
                }else{
                    NSString * stt = [NSString stringWithFormat:@"%@.mp3",str1];
                    NSURL * url = [[NSBundle mainBundle]URLForResource:stt withExtension:nil];
                    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &(_csSoundID));
                    AudioServicesPlayAlertSound(_csSoundID);
                }
                NSString * sstr1 =[str substringWithRange:NSMakeRange(1, 1)];
                NSString * sstr2 =[str substringWithRange:NSMakeRange(2, 1)];
                NSString * sstr3 =[str substringWithRange:NSMakeRange(3, 1)];
                NSString * sstr4 =[str substringWithRange:NSMakeRange(5, 1)];
                NSString * sstr5 =[str substringWithRange:NSMakeRange(6, 1)];
                if ([sstr1 isEqualToString:@"0"] && [sstr2 isEqualToString:@"0"] && [sstr3 isEqualToString:@"0"] && [sstr4 isEqualToString:@"0"] && [sstr5 isEqualToString:@"0"]) {
                    [self performSelector:@selector(qianMethod) withObject:nil afterDelay:0.7];
                    [self performSelector:@selector(method3) withObject:nil afterDelay:1.2];
                    [self performSelector:@selector(method4) withObject:nil afterDelay:2];
                    [self performSelector:@selector(method5) withObject:nil afterDelay:3.2];
                    return;
                }if ([sstr1 isEqualToString:@"0"] && [sstr2 isEqualToString:@"0"] && [sstr4 isEqualToString:@"0"] && [sstr5 isEqualToString:@"0"]) {
                    [self performSelector:@selector(qianMethod) withObject:nil afterDelay:0.7];
                    [self performSelector:@selector(lingMethod) withObject:nil afterDelay:1.2];
                    [self performSelector:@selector(gg) withObject:nil afterDelay:1.7];
                    [self performSelector:@selector(method3) withObject:nil afterDelay:2.2];
                    [self performSelector:@selector(method4) withObject:nil afterDelay:3];
                    [self performSelector:@selector(method5) withObject:nil afterDelay:4.2];
                    return;
                }if ([sstr1 isEqualToString:@"0"] && [sstr3 isEqualToString:@"0"] && [sstr4 isEqualToString:@"0"] && [sstr5 isEqualToString:@"0"]) {
                    [self performSelector:@selector(qianMethod) withObject:nil afterDelay:0.7];
                    [self performSelector:@selector(lingMethod) withObject:nil afterDelay:1.2];
                    [self performSelector:@selector(yy) withObject:nil afterDelay:1.7];
                     [self performSelector:@selector(shiMethod) withObject:nil afterDelay:2.2];
                    [self performSelector:@selector(method3) withObject:nil afterDelay:3];
                    [self performSelector:@selector(method4) withObject:nil afterDelay:4];
                    [self performSelector:@selector(method5) withObject:nil afterDelay:5.2];
                    return;
                }if ([sstr2 isEqualToString:@"0"] && [sstr3 isEqualToString:@"0"] && [sstr4 isEqualToString:@"0"] && [sstr5 isEqualToString:@"0"]) {
                    [self performSelector:@selector(qianMethod) withObject:nil afterDelay:0.7];
                    [self performSelector:@selector(cc) withObject:nil afterDelay:1.2];
                    [self performSelector:@selector(baiMethod) withObject:nil afterDelay:1.7];
                    [self performSelector:@selector(method3) withObject:nil afterDelay:2.2];
                    [self performSelector:@selector(method4) withObject:nil afterDelay:3];
                    [self performSelector:@selector(method5) withObject:nil afterDelay:4.2];
                    return;
                }if ([sstr1 isEqualToString:@"0"] && [sstr4 isEqualToString:@"0"] && [sstr5 isEqualToString:@"0"]) {
                     [self performSelector:@selector(qianMethod) withObject:nil afterDelay:0.7];
                    [self performSelector:@selector(lingMethod) withObject:nil afterDelay:1.2];
                    [self performSelector:@selector(yy) withObject:nil afterDelay:1.7];
                    [self performSelector:@selector(shiMethod) withObject:nil afterDelay:2.2];
                    [self performSelector:@selector(gg) withObject:nil afterDelay:2.7];
                    [self performSelector:@selector(method3) withObject:nil afterDelay:3.2];
                    [self performSelector:@selector(method4) withObject:nil afterDelay:4];
                    [self performSelector:@selector(method5) withObject:nil afterDelay:5.2];
                    return;
                }if ([sstr2 isEqualToString:@"0"] && [sstr4 isEqualToString:@"0"] && [sstr5 isEqualToString:@"0"]) {
                    [self performSelector:@selector(qianMethod) withObject:nil afterDelay:0.7];
                    [self performSelector:@selector(cc) withObject:nil afterDelay:1.2];
                    [self performSelector:@selector(baiMethod) withObject:nil afterDelay:1.7];
                    [self performSelector:@selector(lingMethod) withObject:nil afterDelay:2.2];
                    [self performSelector:@selector(gg) withObject:nil afterDelay:2.7];
                    [self performSelector:@selector(method3) withObject:nil afterDelay:3.2];
                    [self performSelector:@selector(method4) withObject:nil afterDelay:4];
                    [self performSelector:@selector(method5) withObject:nil afterDelay:5.2];
                    return;
                }if ([sstr3 isEqualToString:@"0"] && [sstr4 isEqualToString:@"0"] && [sstr5 isEqualToString:@"0"]) {
                    [self performSelector:@selector(qianMethod) withObject:nil afterDelay:0.7];
                    [self performSelector:@selector(cc) withObject:nil afterDelay:1.2];
                    [self performSelector:@selector(baiMethod) withObject:nil afterDelay:1.7];
                    [self performSelector:@selector(yy) withObject:nil afterDelay:2.2];
                    [self performSelector:@selector(shiMethod) withObject:nil afterDelay:2.7];
                    [self performSelector:@selector(method3) withObject:nil afterDelay:3.2];
                    [self performSelector:@selector(method4) withObject:nil afterDelay:4];
                    [self performSelector:@selector(method5) withObject:nil afterDelay:5.2];
                    return;}
                if ([sstr4 isEqualToString:@"0"] && [sstr5 isEqualToString:@"0"]) {
                    [self performSelector:@selector(qianMethod) withObject:nil afterDelay:0.7];
                    [self performSelector:@selector(cc) withObject:nil afterDelay:1.2];
                    [self performSelector:@selector(baiMethod) withObject:nil afterDelay:1.7];
                    [self performSelector:@selector(yy) withObject:nil afterDelay:2.2];
                    [self performSelector:@selector(shiMethod) withObject:nil afterDelay:2.7];
                    [self performSelector:@selector(gg) withObject:nil afterDelay:3.2];
                    [self performSelector:@selector(method3) withObject:nil afterDelay:3.7];
                    [self performSelector:@selector(method4) withObject:nil afterDelay:4.2];
                    [self performSelector:@selector(method5) withObject:nil afterDelay:4.7];
                    return;
                }if ([sstr1 isEqualToString:@"0"] && [sstr2 isEqualToString:@"0"] ) {
                    [self performSelector:@selector(qianMethod) withObject:nil afterDelay:0.7];
                    [self performSelector:@selector(lingMethod) withObject:nil afterDelay:1.2];
                    [self performSelector:@selector(gg) withObject:nil afterDelay:1.7];
                    [self performSelector:@selector(dianMethod) withObject:nil afterDelay:2.2];
                    [self performSelector:@selector(dd) withObject:nil afterDelay:2.7];
                    [self performSelector:@selector(hh) withObject:nil afterDelay:3.2];
                    [self performSelector:@selector(method3) withObject:nil afterDelay:4];
                    [self performSelector:@selector(method4) withObject:nil afterDelay:5];
                    [self performSelector:@selector(method5) withObject:nil afterDelay:6.2];
                    return;
                }if ([sstr1 isEqualToString:@"0"] && [sstr3 isEqualToString:@"0"] ) {
                    [self performSelector:@selector(qianMethod) withObject:nil afterDelay:0.7];
                    [self performSelector:@selector(lingMethod) withObject:nil afterDelay:1.2];
                    [self performSelector:@selector(yy) withObject:nil afterDelay:1.7];
                    [self performSelector:@selector(shiMethod) withObject:nil afterDelay:2.2];
                    [self performSelector:@selector(dianMethod) withObject:nil afterDelay:2.7];
                    [self performSelector:@selector(dd) withObject:nil afterDelay:3.2];
                    [self performSelector:@selector(hh) withObject:nil afterDelay:3.7];
                    [self performSelector:@selector(method3) withObject:nil afterDelay:4.2];
                    [self performSelector:@selector(method4) withObject:nil afterDelay:5];
                    [self performSelector:@selector(method5) withObject:nil afterDelay:6.2];
                    return;
                }if ([sstr2 isEqualToString:@"0"] && [sstr3 isEqualToString:@"0"] ) {
                    [self performSelector:@selector(qianMethod) withObject:nil afterDelay:0.7];
                    [self performSelector:@selector(cc) withObject:nil afterDelay:1.2];
                    [self performSelector:@selector(baiMethod) withObject:nil afterDelay:1.7];
                    [self performSelector:@selector(dianMethod) withObject:nil afterDelay:2.2];
                    [self performSelector:@selector(dd) withObject:nil afterDelay:2.7];
                    [self performSelector:@selector(hh) withObject:nil afterDelay:3.2];
                    [self performSelector:@selector(method3) withObject:nil afterDelay:4];
                    [self performSelector:@selector(method4) withObject:nil afterDelay:5];
                    [self performSelector:@selector(method5) withObject:nil afterDelay:6.2];
                    return;
                }if ([sstr1 isEqualToString:@"0"]) {
                    [self performSelector:@selector(qianMethod) withObject:nil afterDelay:0.7];
                    [self performSelector:@selector(lingMethod) withObject:nil afterDelay:1.2];
                    [self performSelector:@selector(yy) withObject:nil afterDelay:1.7];
                    [self performSelector:@selector(shiMethod) withObject:nil afterDelay:2.2];
                    [self performSelector:@selector(gg) withObject:nil afterDelay:2.7];
                    [self performSelector:@selector(dianMethod) withObject:nil afterDelay:3.2];
                    [self performSelector:@selector(dd) withObject:nil afterDelay:3.7];
                    [self performSelector:@selector(hh) withObject:nil afterDelay:4.2];
                    [self performSelector:@selector(method3) withObject:nil afterDelay:5];
                    [self performSelector:@selector(method4) withObject:nil afterDelay:5.7];
                    [self performSelector:@selector(method5) withObject:nil afterDelay:7.2];
                    return;
                }if ([sstr2 isEqualToString:@"0"]) {
                    [self performSelector:@selector(qianMethod) withObject:nil afterDelay:0.7];
                    [self performSelector:@selector(cc) withObject:nil afterDelay:1.2];
                    [self performSelector:@selector(baiMethod) withObject:nil afterDelay:1.7];
                    [self performSelector:@selector(lingMethod) withObject:nil afterDelay:2.2];
                    [self performSelector:@selector(gg) withObject:nil afterDelay:2.7];
                    [self performSelector:@selector(dianMethod) withObject:nil afterDelay:3.2];
                    [self performSelector:@selector(dd) withObject:nil afterDelay:3.7];
                    [self performSelector:@selector(hh) withObject:nil afterDelay:4.2];
                    [self performSelector:@selector(method3) withObject:nil afterDelay:5];
                    [self performSelector:@selector(method4) withObject:nil afterDelay:5.7];
                    [self performSelector:@selector(method5) withObject:nil afterDelay:7.2];
                    return;
                }if ([sstr3 isEqualToString:@"0"]) {
                    [self performSelector:@selector(qianMethod) withObject:nil afterDelay:0.7];
                    [self performSelector:@selector(cc) withObject:nil afterDelay:1.2];
                    [self performSelector:@selector(baiMethod) withObject:nil afterDelay:1.7];
                    [self performSelector:@selector(yy) withObject:nil afterDelay:2.2];
                    [self performSelector:@selector(shiMethod) withObject:nil afterDelay:2.7];
                    [self performSelector:@selector(dianMethod) withObject:nil afterDelay:3.2];
                    [self performSelector:@selector(dd) withObject:nil afterDelay:3.7];
                    [self performSelector:@selector(hh) withObject:nil afterDelay:4.2];
                    [self performSelector:@selector(method3) withObject:nil afterDelay:5];
                    [self performSelector:@selector(method4) withObject:nil afterDelay:5.7];
                    [self performSelector:@selector(method5) withObject:nil afterDelay:7.7];
                }else{
                    [self performSelector:@selector(qianMethod) withObject:nil afterDelay:0.7];
                    [self performSelector:@selector(cc) withObject:nil afterDelay:1.2];
                    [self performSelector:@selector(baiMethod) withObject:nil afterDelay:1.7];
                    [self performSelector:@selector(yy) withObject:nil afterDelay:2.2];
                    [self performSelector:@selector(shiMethod) withObject:nil afterDelay:2.7];
                    [self performSelector:@selector(gg) withObject:nil afterDelay:3.2];
                    [self performSelector:@selector(dianMethod) withObject:nil afterDelay:4];
                    [self performSelector:@selector(dd) withObject:nil afterDelay:4.2];
                    [self performSelector:@selector(hh)withObject:nil afterDelay:4.7];
                    [self performSelector:@selector(method3) withObject:nil afterDelay:5.2];
                    [self performSelector:@selector(method4) withObject:nil afterDelay:5.7];
                    [self performSelector:@selector(method5) withObject:nil afterDelay:7.7];}}
        }else{
            NSLog(@"请输入数据!");}}
}
#pragma mark---8.第一个输入框的数据(按时间方式)
- (void)TimeMethod2{
    str = _jlTextField.text;
    NSString * timer = str;
    long long srrrr = [timer longLongValue];
    long hous = srrrr/3600;
    long min = (srrrr /60)%60;
    long seconds = srrrr%60;
    NSLog(@"%ld小时 %ld分钟 %ld秒",hous,min,seconds);
    [self housStrMethod];
}
#pragma mark---第一个输入框按时间方式
- (void)housStrMethod{
    str = _jlTextField.text;
    NSString * timer = str;
    long long srrrr = [timer longLongValue];
    long hous = srrrr/3600;
    housStr = [NSString stringWithFormat:@"%ld",hous];
    NSLog(@"--->%@",housStr);
    NSString * str1 =[housStr substringWithRange:NSMakeRange(0, 1)];
    if ([str1 isEqualToString:@"0"]) {
        [self performSelector:@selector(minStrMethod) withObject:nil afterDelay:0];
    }else{
        if (housStr.length == 1) {
            NSString * strr = [NSString stringWithFormat:@"%@.mp3",housStr];
            NSURL * url = [[NSBundle mainBundle]URLForResource:strr withExtension:nil];
            AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &(_csSoundID));
            AudioServicesPlayAlertSound(_csSoundID);
            [self performSelector:@selector(method6) withObject:nil afterDelay:0.7];
            [self performSelector:@selector(minStrMethod) withObject:nil afterDelay:1.2];
            return;
        }if (housStr.length == 2) {
            NSString * str1 = [housStr substringWithRange:NSMakeRange(0, 1)];
            NSString * sttr = [NSString stringWithFormat:@"%@.mp3",str1];
            NSURL * url = [[NSBundle mainBundle]URLForResource:sttr withExtension:nil];
            AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &(_csSoundID));
            AudioServicesPlayAlertSound(_csSoundID);
            NSString * str2 = [housStr substringFromIndex:1];
            if ([str2 isEqualToString:@"0"]) {
                [self performSelector:@selector(shiMethod) withObject:nil afterDelay:0.5];
                [self performSelector:@selector(method6) withObject:nil afterDelay:1];
                [self performSelector:@selector(minStrMethod) withObject:nil afterDelay:1.5];
                return;
            }else{
                [self performSelector:@selector(shiMethod) withObject:nil afterDelay:0.5];
                [self performSelector:@selector(huoStrStr) withObject:nil afterDelay:1];
                [self performSelector:@selector(method6) withObject:nil afterDelay:1.8];
                [self performSelector:@selector(minStrMethod) withObject:nil afterDelay:2.3];}
        }if (housStr.length == 3) {
            NSString * str1 =[housStr substringWithRange:NSMakeRange(0, 1)];
            NSString * sttr = [NSString stringWithFormat:@"%@.mp3",str1];
            NSURL * url = [[NSBundle mainBundle]URLForResource:sttr withExtension:nil];
            AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &(_csSoundID));
            AudioServicesPlayAlertSound(_csSoundID);
            [self performSelector:@selector(baiMethod) withObject:nil afterDelay:0.5];
            [self performSelector:@selector(huoStrStr) withObject:nil afterDelay:1];
            [self performSelector:@selector(shiMethod) withObject:nil afterDelay:1.5];
            [self performSelector:@selector(huoStrStr2) withObject:nil afterDelay:2];
            [self performSelector:@selector(method6) withObject:nil afterDelay:2.5];
            [self performSelector:@selector(minStrMethod) withObject:nil afterDelay:3];
            return;
        }if (housStr.length == 4) {
            NSString * str1 =[housStr substringWithRange:NSMakeRange(0, 1)];
            NSString * sttr = [NSString stringWithFormat:@"%@.mp3",str1];
            NSURL * url = [[NSBundle mainBundle]URLForResource:sttr withExtension:nil];
            AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &(_csSoundID));
            AudioServicesPlayAlertSound(_csSoundID);
            [self performSelector:@selector(qianMethod) withObject:nil afterDelay:0.5];
            [self performSelector:@selector(huoStrStr) withObject:nil afterDelay:1];
            [self performSelector:@selector(baiMethod) withObject:nil afterDelay:1.5];
            [self performSelector:@selector(huoStrStr2) withObject:nil afterDelay:2];
            [self performSelector:@selector(shiMethod) withObject:nil afterDelay:2.5];
            [self performSelector:@selector(huoStrStr3) withObject:nil afterDelay:3];
            [self performSelector:@selector(method6) withObject:nil afterDelay:3.5];
            [self performSelector:@selector(minStrMethod) withObject:nil afterDelay:4];
            return;}}
}
- (void)huoStrStr{
    NSString * str2 =[housStr substringWithRange:NSMakeRange(1, 1)];
    NSString * sttr = [NSString stringWithFormat:@"%@.mp3",str2];
    NSURL * url = [[NSBundle mainBundle]URLForResource:sttr withExtension:nil];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &(_csSoundID));
    AudioServicesPlayAlertSound(_csSoundID);
}
- (void)huoStrStr2{
    NSString * str3 =[housStr substringWithRange:NSMakeRange(2, 1)];
    NSString * sttr = [NSString stringWithFormat:@"%@.mp3",str3];
    NSURL * url = [[NSBundle mainBundle]URLForResource:sttr withExtension:nil];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &(_csSoundID));
    AudioServicesPlayAlertSound(_csSoundID);
}
- (void)huoStrStr3{
    NSString * str4 =[housStr substringWithRange:NSMakeRange(3, 1)];
    NSString * sttr = [NSString stringWithFormat:@"%@.mp3",str4];
    NSURL * url = [[NSBundle mainBundle]URLForResource:sttr withExtension:nil];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &(_csSoundID));
    AudioServicesPlayAlertSound(_csSoundID);
}
#pragma mark---第一个输入框的数据转化为分钟.
- (void)minStrMethod{
    str = _jlTextField.text;
    NSString * timer = str;
    long long srrrr = [timer longLongValue];
    long min = (srrrr /60)%60;
    minStr = [NSString stringWithFormat:@"%ld",min];
    NSString * ss = [minStr substringWithRange:NSMakeRange(0, 1)];
    if ([ss isEqualToString:@"0"]) {
        [self performSelector:@selector(secondsStrMethod) withObject:nil afterDelay:0];
    }else{
        if (minStr.length == 1) {
            NSString * strr = [NSString stringWithFormat:@"%@.mp3",minStr];
            NSURL * url = [[NSBundle mainBundle]URLForResource:strr withExtension:nil];
            AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &(_csSoundID));
            AudioServicesPlayAlertSound(_csSoundID);
            [self performSelector:@selector(method11) withObject:nil afterDelay:0.5];
            [self performSelector:@selector(secondsStrMethod) withObject:nil afterDelay:1];
            return;
        }if (minStr.length == 2) {
            NSString * ss = [minStr substringWithRange:NSMakeRange(0, 1)];
            NSString * strr = [NSString stringWithFormat:@"%@.mp3",ss];
            NSURL * url = [[NSBundle mainBundle]URLForResource:strr withExtension:nil];
            AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &(_csSoundID));
            AudioServicesPlayAlertSound(_csSoundID);
            NSString * sss = [minStr substringFromIndex:1];
            if ([sss isEqualToString:@"0"]) {
                [self performSelector:@selector(shiMethod) withObject:nil afterDelay:0.5];
                [self performSelector:@selector(method11) withObject:nil afterDelay:1];
                [self performSelector:@selector(secondsStrMethod) withObject:nil afterDelay:1.5];
                return;
            }else{
                [self performSelector:@selector(shiMethod) withObject:nil afterDelay:0.5];
                [self performSelector:@selector(MinStrStr) withObject:nil afterDelay:1];
                [self performSelector:@selector(method11) withObject:nil afterDelay:1.5];
                [self performSelector:@selector(secondsStrMethod) withObject:nil afterDelay:2];}}}
}
- (void)MinStrStr{
    NSString * str2 =[minStr substringFromIndex:1];
    NSString * sttr = [NSString stringWithFormat:@"%@.mp3",str2];
    NSURL * url = [[NSBundle mainBundle]URLForResource:sttr withExtension:nil];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &(_csSoundID));
    AudioServicesPlayAlertSound(_csSoundID);
}
#pragma mark---第一个输入框数据转化为秒.
- (void)secondsStrMethod{
    str = _jlTextField.text;
    NSString * timer = str;
    long long srrrr = [timer integerValue];
    long seconds = srrrr%60;
    secondsStr = [NSString stringWithFormat:@"%ld",seconds];
    NSString * ss = [secondsStr substringWithRange:NSMakeRange(0, 1)];
    if ([ss isEqualToString:@"0"]) {
        [self performSelector:@selector(method9) withObject:nil afterDelay:0];
    }else{
        if (secondsStr.length == 1) {
            NSString * strr = [NSString stringWithFormat:@"%@.mp3",secondsStr];
            NSURL * url = [[NSBundle mainBundle]URLForResource:strr withExtension:nil];
            AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &(_csSoundID));
            AudioServicesPlayAlertSound(_csSoundID);
            [self performSelector:@selector(method12) withObject:nil afterDelay:0.5];
            [self performSelector:@selector(method4) withObject:nil afterDelay:1];
            [self performSelector:@selector(method5) withObject:nil afterDelay:2.2];
            return;
        }if (secondsStr.length == 2) {
            NSString * ss = [secondsStr substringWithRange:NSMakeRange(0, 1)];
            NSString * strr = [NSString stringWithFormat:@"%@.mp3",ss];
            NSURL * url = [[NSBundle mainBundle]URLForResource:strr withExtension:nil];
            AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &(_csSoundID));
            AudioServicesPlayAlertSound(_csSoundID);
            NSString * sss = [secondsStr substringFromIndex:1];
            if ([sss isEqualToString:@"0"]) {
                [self performSelector:@selector(shiMethod) withObject:nil afterDelay:0.5];
                [self performSelector:@selector(method12) withObject:nil afterDelay:1];
                [self performSelector:@selector(method4) withObject:nil afterDelay:1.7];
                [self performSelector:@selector(method5) withObject:nil afterDelay:2.7];
                return;
            }else{
                [self performSelector:@selector(shiMethod) withObject:nil afterDelay:0.5];
                [self performSelector:@selector(secondStrStr) withObject:nil afterDelay:1];
                [self performSelector:@selector(method12) withObject:nil afterDelay:1.5];
                [self performSelector:@selector(method4) withObject:nil afterDelay:2.2];
                [self performSelector:@selector(method5) withObject:nil afterDelay:3.5];}}}
}
- (void)secondStrStr{
    NSString * str2 =[secondsStr substringFromIndex:1];
    NSString * sttr = [NSString stringWithFormat:@"%@.mp3",str2];
    NSURL * url = [[NSBundle mainBundle]URLForResource:sttr withExtension:nil];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &(_csSoundID));
    AudioServicesPlayAlertSound(_csSoundID);
}
#pragma mark---9.第二个输入框的数据
- (void)method5{
    timeStr = _timeTextField.text;
    NSString * timer = timeStr;
    long long srrrr = [timer longLongValue];
    long hous = srrrr/3600;
    long min = (srrrr /60)%60;
    long seconds = srrrr%60;
    NSLog(@"%ld小时 %ld分钟 %ld秒",hous,min,seconds);
    [self housMethod];
}
#pragma mark---第二个输入框转化为小时
- (void)housMethod{
    timeStr = _timeTextField.text;
    NSString * timer = timeStr;
    long long srrrr = [timer longLongValue];
    long hous = srrrr/3600;
    housStr = [NSString stringWithFormat:@"%ld",hous];
    NSString * str1 =[housStr substringWithRange:NSMakeRange(0, 1)];
    if ([str1 isEqualToString:@"0"]) {
         [self performSelector:@selector(minMethod) withObject:nil afterDelay:0];
    }else{
        if (housStr.length == 1) {
            NSString * strr = [NSString stringWithFormat:@"%@.mp3",housStr];
            NSURL * url = [[NSBundle mainBundle]URLForResource:strr withExtension:nil];
            AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &(_timeSoundID));
            AudioServicesPlayAlertSound(_timeSoundID);
            [self performSelector:@selector(method6) withObject:nil afterDelay:0.7];
            [self performSelector:@selector(minMethod) withObject:nil afterDelay:1.2];
            return;
        }if (housStr.length == 2 ) {
            NSString * str1 =[housStr substringWithRange:NSMakeRange(0, 1)];
            NSString * sttr = [NSString stringWithFormat:@"%@.mp3",str1];
            NSURL * url = [[NSBundle mainBundle]URLForResource:sttr withExtension:nil];
            AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &(_timeSoundID));
            AudioServicesPlayAlertSound(_timeSoundID);
            NSString * str2 = [housStr substringFromIndex:1];
            if ([str2 isEqualToString:@"0"]) {
                [self performSelector:@selector(shiMethod) withObject:nil afterDelay:0.5];
                [self performSelector:@selector(method6) withObject:nil afterDelay:1];
                [self performSelector:@selector(minMethod) withObject:nil afterDelay:1.5];
                return;
            }else{
                [self performSelector:@selector(shiMethod) withObject:nil afterDelay:0.5];
                [self performSelector:@selector(huoStr) withObject:nil afterDelay:1];
                [self performSelector:@selector(method6) withObject:nil afterDelay:1.8];
                [self performSelector:@selector(minMethod) withObject:nil afterDelay:2.3];}
        }if (housStr.length == 3) {
            NSString * str1 =[housStr substringWithRange:NSMakeRange(0, 1)];
            NSString * sttr = [NSString stringWithFormat:@"%@.mp3",str1];
            NSURL * url = [[NSBundle mainBundle]URLForResource:sttr withExtension:nil];
            AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &(_timeSoundID));
            AudioServicesPlayAlertSound(_timeSoundID);
            [self performSelector:@selector(baiMethod) withObject:nil afterDelay:0.5];
            [self performSelector:@selector(huoStr) withObject:nil afterDelay:1];
            [self performSelector:@selector(shiMethod) withObject:nil afterDelay:1.5];
            [self performSelector:@selector(huoStr2) withObject:nil afterDelay:2];
            [self performSelector:@selector(method6) withObject:nil afterDelay:2.5];
            [self performSelector:@selector(minMethod) withObject:nil afterDelay:3];
            return;
        }if (housStr.length == 4) {
            NSString * str1 =[housStr substringWithRange:NSMakeRange(0, 1)];
            NSString * sttr = [NSString stringWithFormat:@"%@.mp3",str1];
            NSURL * url = [[NSBundle mainBundle]URLForResource:sttr withExtension:nil];
            AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &(_timeSoundID));
            AudioServicesPlayAlertSound(_timeSoundID);
            [self performSelector:@selector(qianMethod) withObject:nil afterDelay:0.5];
            [self performSelector:@selector(huoStr) withObject:nil afterDelay:1];
            [self performSelector:@selector(baiMethod) withObject:nil afterDelay:1.5];
            [self performSelector:@selector(huoStr2) withObject:nil afterDelay:2];
            [self performSelector:@selector(shiMethod) withObject:nil afterDelay:2.5];
            [self performSelector:@selector(huoStr3) withObject:nil afterDelay:3];
            [self performSelector:@selector(method6) withObject:nil afterDelay:3.5];
            [self performSelector:@selector(minMethod) withObject:nil afterDelay:4];
            return;}}
}
- (void)huoStr{
    NSString * str2 =[housStr substringWithRange:NSMakeRange(1, 1)];
    NSString * sttr = [NSString stringWithFormat:@"%@.mp3",str2];
    NSURL * url = [[NSBundle mainBundle]URLForResource:sttr withExtension:nil];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &(_timeSoundID));
    AudioServicesPlayAlertSound(_timeSoundID);
}
- (void)huoStr2{
    NSString * str3 =[housStr substringWithRange:NSMakeRange(2, 1)];
    NSString * sttr = [NSString stringWithFormat:@"%@.mp3",str3];
    NSURL * url = [[NSBundle mainBundle]URLForResource:sttr withExtension:nil];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &(_timeSoundID));
    AudioServicesPlayAlertSound(_timeSoundID);
}
- (void)huoStr3{
    NSString * str4 =[housStr substringWithRange:NSMakeRange(3, 1)];
    NSString * sttr = [NSString stringWithFormat:@"%@.mp3",str4];
    NSURL * url = [[NSBundle mainBundle]URLForResource:sttr withExtension:nil];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &(_timeSoundID));
    AudioServicesPlayAlertSound(_timeSoundID);
}
#pragma mark---第二个输入框的数据转化为分钟.
- (void)minMethod{
    timeStr = _timeTextField.text;
    NSString * timer = timeStr;
    long long srrrr = [timer longLongValue];
    long min = (srrrr /60)%60;
    minStr = [NSString stringWithFormat:@"%ld",min];
    NSString * ss = [minStr substringWithRange:NSMakeRange(0, 1)];
    if ([ss isEqualToString:@"0"]) {
        [self performSelector:@selector(secondsMethod) withObject:nil afterDelay:0];
    }else{
        if (minStr.length == 1) {
            NSString * strr = [NSString stringWithFormat:@"%@.mp3",minStr];
            NSURL * url = [[NSBundle mainBundle]URLForResource:strr withExtension:nil];
            AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &(_timeSoundID));
            AudioServicesPlayAlertSound(_timeSoundID);
            [self performSelector:@selector(method11) withObject:nil afterDelay:0.5];
            [self performSelector:@selector(secondsMethod) withObject:nil afterDelay:1];
            return;
        }if (minStr.length == 2) {
            NSString * ss = [minStr substringWithRange:NSMakeRange(0, 1)];
            NSString * strr = [NSString stringWithFormat:@"%@.mp3",ss];
            NSURL * url = [[NSBundle mainBundle]URLForResource:strr withExtension:nil];
            AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &(_timeSoundID));
            AudioServicesPlayAlertSound(_timeSoundID);
            NSString * sss = [minStr substringFromIndex:1];
            if ([sss isEqualToString:@"0"]) {
                [self performSelector:@selector(shiMethod) withObject:nil afterDelay:0.5];
                [self performSelector:@selector(method11) withObject:nil afterDelay:1];
                [self performSelector:@selector(secondsMethod) withObject:nil afterDelay:1.5];
                return;
            }else{
                [self performSelector:@selector(shiMethod) withObject:nil afterDelay:0.5];
                [self performSelector:@selector(MinStr) withObject:nil afterDelay:1];
                [self performSelector:@selector(method11) withObject:nil afterDelay:1.5];
                [self performSelector:@selector(secondsMethod) withObject:nil afterDelay:2];}}}
}
- (void)MinStr{
    NSString * str2 =[minStr substringFromIndex:1];
    NSString * sttr = [NSString stringWithFormat:@"%@.mp3",str2];
    NSURL * url = [[NSBundle mainBundle]URLForResource:sttr withExtension:nil];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &(_timeSoundID));
    AudioServicesPlayAlertSound(_timeSoundID);
}
#pragma mark---第二个输入框数据转化为秒.
- (void)secondsMethod{
    timeStr = _timeTextField.text;
    NSString * timer = timeStr;
    long long srrrr = [timer integerValue];
    long seconds = srrrr%60;
    secondsStr = [NSString stringWithFormat:@"%ld",seconds];
    NSString * ss = [secondsStr substringWithRange:NSMakeRange(0, 1)];
    if ([ss isEqualToString:@"0"]) {
        [self performSelector:@selector(method9) withObject:nil afterDelay:0];
    }else{
        if (secondsStr.length == 1) {
            NSString * strr = [NSString stringWithFormat:@"%@.mp3",secondsStr];
            NSURL * url = [[NSBundle mainBundle]URLForResource:strr withExtension:nil];
            AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &(_timeSoundID));
            AudioServicesPlayAlertSound(_timeSoundID);
            [self performSelector:@selector(method12) withObject:nil afterDelay:0.5];
            [self performSelector:@selector(method7) withObject:nil afterDelay:1];
            [self performSelector:@selector(method8) withObject:nil afterDelay:2.2];
            [self performSelector:@selector(method9) withObject:nil afterDelay:3.7];
            return;
        }if (secondsStr.length == 2) {
            NSString * ss = [secondsStr substringWithRange:NSMakeRange(0, 1)];
            NSString * strr = [NSString stringWithFormat:@"%@.mp3",ss];
            NSURL * url = [[NSBundle mainBundle]URLForResource:strr withExtension:nil];
            AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &(_timeSoundID));
            AudioServicesPlayAlertSound(_timeSoundID);
            NSString * sss = [secondsStr substringFromIndex:1];
            if ([sss isEqualToString:@"0"]) {
                [self performSelector:@selector(shiMethod) withObject:nil afterDelay:0.5];
                [self performSelector:@selector(method12) withObject:nil afterDelay:1];
                [self performSelector:@selector(method7) withObject:nil afterDelay:1.5];
                [self performSelector:@selector(method8) withObject:nil afterDelay:2.7];
                [self performSelector:@selector(method9) withObject:nil afterDelay:4.2];
                return;
            }else{
                [self performSelector:@selector(shiMethod) withObject:nil afterDelay:0.5];
                [self performSelector:@selector(secondStr) withObject:nil afterDelay:1];
                [self performSelector:@selector(method12) withObject:nil afterDelay:1.5];
                [self performSelector:@selector(method7) withObject:nil afterDelay:2];
                [self performSelector:@selector(method8) withObject:nil afterDelay:3.2];
                [self performSelector:@selector(method9) withObject:nil afterDelay:4.7];}}}
}
- (void)secondStr{
    NSString * str2 =[secondsStr substringFromIndex:1];
    NSString * sttr = [NSString stringWithFormat:@"%@.mp3",str2];
    NSURL * url = [[NSBundle mainBundle]URLForResource:sttr withExtension:nil];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &(_timeSoundID));
    AudioServicesPlayAlertSound(_timeSoundID);
}
#pragma mark---10.第三个输入框的数据
- (void)method9{
    hsStr = _hsTextField.text;
    if ([self hsPureInt:hsStr] == YES) {
        if (hsStr.length == 1) {
            NSString * strr = [NSString stringWithFormat:@"%@.mp3",_hsTextField.text];
            NSURL * url = [[NSBundle mainBundle]URLForResource:strr withExtension:nil];
            AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &(_hsSoundID));
            AudioServicesPlayAlertSound(_hsSoundID);
            [self performSelector:@selector(method3) withObject:nil afterDelay:0.5];
            [self performSelector:@selector(method10) withObject:nil afterDelay:1.0];
        }if (hsStr.length == 2){
            NSString * str1 =[hsStr substringWithRange:NSMakeRange(0, 1)];
            NSString * sttr = [NSString stringWithFormat:@"%@.mp3",str1];
            NSURL * url = [[NSBundle mainBundle]URLForResource:sttr withExtension:nil];
            AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &(_hsSoundID));
            AudioServicesPlayAlertSound(_hsSoundID);
            NSString * str2 =[hsStr substringWithRange:NSMakeRange(1, 1)];
            if ([str2 isEqualToString:@"0"]) {
                [self performSelector:@selector(shiMethod) withObject:nil afterDelay:0.4];
                [self performSelector:@selector(method3) withObject:nil afterDelay:1];
                [self performSelector:@selector(method10) withObject:nil afterDelay:1.5];
            }else{
                [self performSelector:@selector(shiMethod) withObject:nil afterDelay:0.4];
                [self performSelector:@selector(method21) withObject:nil afterDelay:1.0];
                [self performSelector:@selector(method3) withObject:nil afterDelay:1.5];
                [self performSelector:@selector(method10) withObject:nil afterDelay:2];}
        }if (hsStr.length == 3) {
            NSString * str1 =[hsStr substringWithRange:NSMakeRange(0, 1)];
            if ([str1 isEqualToString:@"2"]) {
                NSURL * url = [[NSBundle mainBundle]URLForResource:@"两.mp3" withExtension:nil];
                AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &(_hsSoundID));
                AudioServicesPlayAlertSound(_hsSoundID);
            }else{
            NSString * sttr = [NSString stringWithFormat:@"%@.mp3",str1];
            NSURL * url = [[NSBundle mainBundle]URLForResource:sttr withExtension:nil];
            AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &(_hsSoundID));
            AudioServicesPlayAlertSound(_hsSoundID);
            }
            NSString * str2 =[hsStr substringWithRange:NSMakeRange(1, 1)];
            NSString * str3 =[hsStr substringWithRange:NSMakeRange(2, 1)];
            if ([str2 isEqualToString:@"0"] && [str3 isEqualToString:@"0"]) {
                [self performSelector:@selector(baiMethod) withObject:nil afterDelay:0.7];
                [self performSelector:@selector(method3) withObject:nil afterDelay:1.2];
                [self performSelector:@selector(method10) withObject:nil afterDelay:1.7];
                return;
            }if ([str2 isEqualToString:@"0"]) {
                [self performSelector:@selector(baiMethod) withObject:nil afterDelay:0.5];
                [self performSelector:@selector(lingMethod) withObject:nil afterDelay:1];
                [self performSelector:@selector(method22)];
                [self performSelector:@selector(method3) withObject:nil afterDelay:2];
                [self performSelector:@selector(method10) withObject:nil afterDelay:2.5];
                return;
            }if ([str3 isEqualToString:@"0"]) {
                [self performSelector:@selector(baiMethod) withObject:nil afterDelay:0.5];
                [self performSelector:@selector(method21) withObject:nil  afterDelay:1];
                [self performSelector:@selector(shiMethod) withObject:nil  afterDelay:1.5];
                [self performSelector:@selector(method3) withObject:nil afterDelay:2];
                [self performSelector:@selector(method10) withObject:nil afterDelay:2.5];
                return;
            }else{
            [self performSelector:@selector(baiMethod) withObject:nil afterDelay:0.5];
            [self performSelector:@selector(method21) withObject:nil afterDelay:1.0];
            [self performSelector:@selector(shiMethod) withObject:nil afterDelay:1.5];
            [self performSelector:@selector(method22) withObject:nil afterDelay:2];
            [self performSelector:@selector(method3) withObject:nil afterDelay:2.5];
            [self performSelector:@selector(method10) withObject:nil afterDelay:3];}
    }if (hsStr.length == 4) {
        NSString * str1 =[hsStr substringWithRange:NSMakeRange(0, 1)];
        if ([str1 isEqualToString:@"2"]) {
            NSURL * url = [[NSBundle mainBundle]URLForResource:@"两.mp3" withExtension:nil];
            AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &(_hsSoundID));
            AudioServicesPlayAlertSound(_hsSoundID);
        }else{
            NSString * sttr = [NSString stringWithFormat:@"%@.mp3",str1];
            NSURL * url = [[NSBundle mainBundle]URLForResource:sttr withExtension:nil];
            AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &(_hsSoundID));
            AudioServicesPlayAlertSound(_hsSoundID);
        }
        NSString * str2 =[hsStr substringWithRange:NSMakeRange(1, 1)];
        NSString * str3 =[hsStr substringWithRange:NSMakeRange(2, 1)];
        NSString * str4 =[hsStr substringWithRange:NSMakeRange(3, 1)];
        if ([str2 isEqualToString:@"0"] && [str3 isEqualToString:@"0"] && [str4 isEqualToString:@"0"]) {
            [self performSelector:@selector(qianMethod) withObject:nil afterDelay:0.7];
            [self performSelector:@selector(method3) withObject:nil afterDelay:1.2];
            [self performSelector:@selector(method10) withObject:nil afterDelay:1.7];
            return;
        }if ([str2 isEqualToString:@"0"] && [str3 isEqualToString:@"0"]) {
            [self performSelector:@selector(qianMethod) withObject:nil afterDelay:0.7];
            [self performSelector:@selector(lingMethod) withObject:nil afterDelay:1.2];
            [self performSelector:@selector(method23) withObject:nil afterDelay:1.7];
            [self performSelector:@selector(method3) withObject:nil afterDelay:2.2];
            [self performSelector:@selector(method10) withObject:nil afterDelay:2.7];
            return;
        }if ([str2 isEqualToString:@"0"] && [str4 isEqualToString:@"0"]) {
            [self performSelector:@selector(qianMethod) withObject:nil afterDelay:0.7];
            [self performSelector:@selector(lingMethod) withObject:nil afterDelay:1.2];
            [self performSelector:@selector(method22) withObject:nil afterDelay:1.7];
            [self performSelector:@selector(shiMethod) withObject:nil afterDelay:2.2];
            [self performSelector:@selector(method3) withObject:nil afterDelay:2.7];
            [self performSelector:@selector(method10) withObject:nil afterDelay:3.2];
            return;
        }if ([str3 isEqualToString:@"0"] && [str4 isEqualToString:@"0"]) {
            [self performSelector:@selector(qianMethod) withObject:nil afterDelay:0.7];
            [self performSelector:@selector(method21) withObject:nil afterDelay:1.2];
            [self performSelector:@selector(baiMethod) withObject:nil afterDelay:1.7];
            [self performSelector:@selector(method3) withObject:nil afterDelay:2.2];
            [self performSelector:@selector(method10) withObject:nil afterDelay:2.7];
            return;
        }if ([str2 isEqualToString:@"0"]) {
            [self performSelector:@selector(qianMethod) withObject:nil afterDelay:0.5];
            [self performSelector:@selector(lingMethod) withObject:nil afterDelay:1];
            [self performSelector:@selector(method22) withObject:nil afterDelay:1.5];
            [self performSelector:@selector(shiMethod) withObject:nil afterDelay:2];
            [self performSelector:@selector(method23) withObject:nil afterDelay:2.5];
            [self performSelector:@selector(method3) withObject:nil afterDelay:3];
            [self performSelector:@selector(method10) withObject:nil afterDelay:3.5];
            return;
        }if ([str3 isEqualToString:@"0"]) {
            [self performSelector:@selector(qianMethod) withObject:nil afterDelay:0.5];
            [self performSelector:@selector(method21) withObject:nil afterDelay:1];
            [self performSelector:@selector(baiMethod) withObject:nil afterDelay:1.5];
            [self performSelector:@selector(lingMethod) withObject:nil afterDelay:2];
            [self performSelector:@selector(method23) withObject:nil afterDelay:2.5];
            [self performSelector:@selector(method3) withObject:nil afterDelay:3];
            [self performSelector:@selector(method10) withObject:nil afterDelay:3.5];
            return;
        }if ([str4 isEqualToString:@"0"]) {
            [self performSelector:@selector(qianMethod) withObject:nil afterDelay:0.5];
            [self performSelector:@selector(method21) withObject:nil afterDelay:1];
            [self performSelector:@selector(baiMethod) withObject:nil afterDelay:1.5];
            [self performSelector:@selector(method22) withObject:nil afterDelay:2];
            [self performSelector:@selector(shiMethod) withObject:nil afterDelay:2.5];
            [self performSelector:@selector(method3) withObject:nil afterDelay:3];
            [self performSelector:@selector(method10) withObject:nil afterDelay:3.5];
        }else{
            [self performSelector:@selector(qianMethod) withObject:nil afterDelay:0.5];
            [self performSelector:@selector(method21) withObject:nil afterDelay:1];
            [self performSelector:@selector(baiMethod) withObject:nil afterDelay:1.5];
            [self performSelector:@selector(method22) withObject:nil afterDelay:2];
            [self performSelector:@selector(shiMethod) withObject:nil afterDelay:2.5];
            [self performSelector:@selector(method23) withObject:nil afterDelay:3];
            [self performSelector:@selector(method3) withObject:nil afterDelay:3.5];
            [self performSelector:@selector(method10) withObject:nil afterDelay:4];}}
    }else{
        if (hsStr.length>1) {
            if (hsStr.length == 4 ){
                NSString * str1 =[hsStr substringWithRange:NSMakeRange(0, 1)];
                NSString * stt = [NSString stringWithFormat:@"%@.mp3",str1];
                NSURL * url = [[NSBundle mainBundle]URLForResource:stt withExtension:nil];
                AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &(_hsSoundID));
                AudioServicesPlayAlertSound(_hsSoundID);
                NSString * str2 = [hsStr substringWithRange:NSMakeRange(2, 1)];
                NSString * str3 = [hsStr substringWithRange:NSMakeRange(3, 1)];
                if ([str2 isEqualToString:@"0"] &&[str3 isEqualToString:@"0"]) {
                    [self performSelector:@selector(method3) withObject:nil afterDelay:0.5];
                    [self performSelector:@selector(method10) withObject:nil afterDelay:1];
                }else{
                    [self performSelector:@selector(dianMethod) withObject:nil afterDelay:0.5];
                    [self performSelector:@selector(yyyy) withObject:nil afterDelay:1.0];
                    [self performSelector:@selector(gggg) withObject:nil afterDelay:1.5];
                    [self performSelector:@selector(method3) withObject:nil afterDelay:2];
                    [self performSelector:@selector(method10) withObject:nil afterDelay:2.5];}
                
            }else if (hsStr.length == 5){
                NSString * str1 =[hsStr substringWithRange:NSMakeRange(0, 1)];
                NSString * stt = [NSString stringWithFormat:@"%@.mp3",str1];
                NSURL * url = [[NSBundle mainBundle]URLForResource:stt withExtension:nil];
                AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &(_hsSoundID));
                AudioServicesPlayAlertSound(_hsSoundID);
                NSString * sstr1 =[hsStr substringWithRange:NSMakeRange(1, 1)];
                NSString * str2 =[hsStr substringWithRange:NSMakeRange(3, 1)];
                NSString * str3 =[hsStr substringWithRange:NSMakeRange(4, 1)];
                if ([str2 isEqualToString:@"0"] && [str3 isEqualToString:@"0"] && [sstr1 isEqualToString:@"0"]) {
                    [self performSelector:@selector(shiMethod) withObject:nil afterDelay:0.5];
                    [self performSelector:@selector(method3) withObject:nil afterDelay:1];//
                    [self performSelector:@selector(method10) withObject:nil afterDelay:1.5];
                    return;
                }if ([str2 isEqualToString:@"0"] && [str3 isEqualToString:@"0"] && sstr1 != 0) {
                    [self performSelector:@selector(shiMethod) withObject:nil afterDelay:0.5];
                    [self performSelector:@selector(cccc) withObject:nil afterDelay:1];
                    [self performSelector:@selector(method3) withObject:nil afterDelay:1.5];//
                    [self performSelector:@selector(method10) withObject:nil afterDelay:2];
                    return;
                }if ([sstr1 isEqualToString:@"0"]) {
                    [self performSelector:@selector(shiMethod) withObject:nil afterDelay:0.5];
                    [self performSelector:@selector(dianMethod) withObject:nil afterDelay:1];
                    [self performSelector:@selector(gggg) withObject:nil afterDelay:1.5];
                    [self performSelector:@selector(aaaa) withObject:nil afterDelay:2];
                    [self performSelector:@selector(method3) withObject:nil afterDelay:2.5];//
                    [self performSelector:@selector(method10) withObject:nil afterDelay:3];
                }else{
                    [self performSelector:@selector(shiMethod) withObject:nil afterDelay:0.4];
                    [self performSelector:@selector(cccc) withObject:nil afterDelay:0.8];
                    [self performSelector:@selector(dianMethod) withObject:nil afterDelay:1.5];
                    [self performSelector:@selector(gggg) withObject:nil afterDelay:2.0];
                    [self performSelector:@selector(aaaa) withObject:nil afterDelay:2.5];
                    [self performSelector:@selector(method3) withObject:nil afterDelay:3];//
                    [self performSelector:@selector(method10) withObject:nil afterDelay:3.5];}
            }else if (hsStr.length == 6){
                NSString * str1 =[hsStr substringWithRange:NSMakeRange(0, 1)];
                if ([str1 isEqualToString:@"2"]) {
                    NSURL * url = [[NSBundle mainBundle]URLForResource:@"两.mp3" withExtension:nil];
                    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &(_hsSoundID));
                    AudioServicesPlayAlertSound(_hsSoundID);
                }else{
                    NSString * stt = [NSString stringWithFormat:@"%@.mp3",str1];
                    NSURL * url = [[NSBundle mainBundle]URLForResource:stt withExtension:nil];
                    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &(_hsSoundID));
                    AudioServicesPlayAlertSound(_hsSoundID);
                }
                NSString * sstr1 =[hsStr substringWithRange:NSMakeRange(1, 1)];
                NSString * str2 =[hsStr substringWithRange:NSMakeRange(2, 1)];
                NSString * str4 =[hsStr substringWithRange:NSMakeRange(4, 1)];
                NSString * str5 =[hsStr substringWithRange:NSMakeRange(5, 1)];
                if ([sstr1 isEqualToString:@"0"] && [str2 isEqualToString:@"0"] && [str4 isEqualToString:@"0"] && [str5 isEqualToString:@"0"]) {
                    [self performSelector:@selector(baiMethod) withObject:nil afterDelay:0.7];
                    [self performSelector:@selector(method3) withObject:nil afterDelay:1.2];//
                    [self performSelector:@selector(method10) withObject:nil afterDelay:1.7];
                    return;
                }if ([str2 isEqualToString:@"0"] && [str4 isEqualToString:@"0"] && [str5 isEqualToString:@"0"]) {
                    [self performSelector:@selector(baiMethod) withObject:nil afterDelay:0.7];
                    [self performSelector:@selector(cccc) withObject:nil afterDelay:1.2];
                    [self performSelector:@selector(shiMethod) withObject:nil afterDelay:1.7];
                    [self performSelector:@selector(method3) withObject:nil afterDelay:2.2];//
                    [self performSelector:@selector(method10) withObject:nil afterDelay:2.7];
                    return;
                }if ([sstr1 isEqualToString:@"0"] && [str4 isEqualToString:@"0"] && [str5 isEqualToString:@"0"]) {
                    [self performSelector:@selector(baiMethod) withObject:nil afterDelay:0.7];
                    [self performSelector:@selector(lingMethod) withObject:nil afterDelay:1.2];
                    [self performSelector:@selector(yyyy) withObject:nil afterDelay:1.7];
                    [self performSelector:@selector(method3) withObject:nil afterDelay:2.2];//
                    [self performSelector:@selector(method10) withObject:nil afterDelay:2.7];
                    return;
                }if (str2 != 0 && [str4 isEqualToString:@"0"] && [str5 isEqualToString:@"0"]) {
                    [self performSelector:@selector(baiMethod) withObject:nil afterDelay:0.7];
                    [self performSelector:@selector(cccc) withObject:nil afterDelay:1.2];
                    [self performSelector:@selector(shiMethod) withObject:nil afterDelay:1.7];
                    [self performSelector:@selector(yyyy) withObject:nil afterDelay:2.2];
                    [self performSelector:@selector(method3) withObject:nil afterDelay:2.7];//
                    [self performSelector:@selector(method10) withObject:nil afterDelay:3.2];
                    return;
                }if ([sstr1 isEqualToString:@"0"] && [str2 isEqualToString:@"0"]) {
                    [self performSelector:@selector(baiMethod) withObject:nil afterDelay:0.7];
                    [self performSelector:@selector(dianMethod) withObject:nil afterDelay:1.2];
                    [self performSelector:@selector(aaaa) withObject:nil afterDelay:1.7];
                    [self performSelector:@selector(dddd) withObject:nil afterDelay:2.2];
                    [self performSelector:@selector(method3) withObject:nil afterDelay:2.7];//
                    [self performSelector:@selector(method10) withObject:nil afterDelay:3.2];
                    return;
                }if ([sstr1 isEqualToString:@"0"]) {
                    [self performSelector:@selector(baiMethod) withObject:nil afterDelay:0.7];
                    [self performSelector:@selector(lingMethod) withObject:nil afterDelay:1.2];
                    [self performSelector:@selector(yyyy) withObject:nil afterDelay:1.7];
                    [self performSelector:@selector(dianMethod) withObject:nil afterDelay:2.2];
                    [self performSelector:@selector(aaaa) withObject:nil afterDelay:2.7];
                    [self performSelector:@selector(dddd) withObject:nil afterDelay:3.2];
                    [self performSelector:@selector(method3) withObject:nil afterDelay:3.7];//
                    [self performSelector:@selector(method10) withObject:nil afterDelay:4.2];
                    return;
                }if ([str2 isEqualToString:@"0"]) {
                    [self performSelector:@selector(baiMethod) withObject:nil afterDelay:0.7];
                    [self performSelector:@selector(cccc) withObject:nil afterDelay:1.2];
                    [self performSelector:@selector(shiMethod) withObject:nil afterDelay:1.7];
                    [self performSelector:@selector(dianMethod) withObject:nil afterDelay:2.2];
                    [self performSelector:@selector(aaaa) withObject:nil afterDelay:2.7];
                    [self performSelector:@selector(dddd) withObject:nil afterDelay:3.2];
                    [self performSelector:@selector(method3) withObject:nil afterDelay:3.7];
                    [self performSelector:@selector(method10) withObject:nil afterDelay:4.2];
                    return;
                }else{
                    [self performSelector:@selector(baiMethod) withObject:nil afterDelay:0.7];
                    [self performSelector:@selector(cccc) withObject:nil afterDelay:1.2];
                    [self performSelector:@selector(shiMethod) withObject:nil afterDelay:1.7];
                    [self performSelector:@selector(yyyy) withObject:nil afterDelay:2.2];
                    [self performSelector:@selector(dianMethod) withObject:nil afterDelay:2.7];
                    [self performSelector:@selector(aaaa) withObject:nil afterDelay:3.2];
                    [self performSelector:@selector(dddd) withObject:nil afterDelay:3.7];
                    [self performSelector:@selector(method3) withObject:nil afterDelay:4.2];
                    [self performSelector:@selector(method10) withObject:nil afterDelay:4.7];}
            }else if (hsStr.length == 7){
                NSString * str1 =[hsStr substringWithRange:NSMakeRange(0, 1)];
                if ([str1 isEqualToString:@"2"]) {
                    NSURL * url = [[NSBundle mainBundle]URLForResource:@"两.mp3" withExtension:nil];
                    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &(_hsSoundID));
                    AudioServicesPlayAlertSound(_hsSoundID);
                }else{
                    NSString * stt = [NSString stringWithFormat:@"%@.mp3",str1];
                    NSURL * url = [[NSBundle mainBundle]URLForResource:stt withExtension:nil];
                    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &(_hsSoundID));
                    AudioServicesPlayAlertSound(_hsSoundID);
                }
                NSString * sstr1 =[hsStr substringWithRange:NSMakeRange(1, 1)];
                NSString * sstr2 =[hsStr substringWithRange:NSMakeRange(2, 1)];
                NSString * sstr3 =[hsStr substringWithRange:NSMakeRange(3, 1)];
                NSString * sstr4 =[hsStr substringWithRange:NSMakeRange(5, 1)];
                NSString * sstr5 =[hsStr substringWithRange:NSMakeRange(6, 1)];
                if ([sstr1 isEqualToString:@"0"] && [sstr2 isEqualToString:@"0"] && [sstr3 isEqualToString:@"0"] && [sstr4 isEqualToString:@"0"] && [sstr5 isEqualToString:@"0"]) {
                    [self performSelector:@selector(qianMethod) withObject:nil afterDelay:0.7];
                    [self performSelector:@selector(method3) withObject:nil afterDelay:1.2];
                    [self performSelector:@selector(method4) withObject:nil afterDelay:1.7];
                    [self performSelector:@selector(method10) withObject:nil afterDelay:2.2];
                    return;
                }if ([sstr1 isEqualToString:@"0"] && [sstr2 isEqualToString:@"0"] && [sstr4 isEqualToString:@"0"] && [sstr5 isEqualToString:@"0"]) {
                    [self performSelector:@selector(qianMethod) withObject:nil afterDelay:0.7];
                    [self performSelector:@selector(lingMethod) withObject:nil afterDelay:1.2];
                    [self performSelector:@selector(gggg) withObject:nil afterDelay:1.7];
                    [self performSelector:@selector(method3) withObject:nil afterDelay:2.2];
                    [self performSelector:@selector(method10) withObject:nil afterDelay:2.7];
                    return;
                }if ([sstr1 isEqualToString:@"0"] && [sstr3 isEqualToString:@"0"] && [sstr4 isEqualToString:@"0"] && [sstr5 isEqualToString:@"0"]) {
                    [self performSelector:@selector(qianMethod) withObject:nil afterDelay:0.7];
                    [self performSelector:@selector(lingMethod) withObject:nil afterDelay:1.2];
                    [self performSelector:@selector(yyyy) withObject:nil afterDelay:1.7];
                    [self performSelector:@selector(shiMethod) withObject:nil afterDelay:2.2];
                    [self performSelector:@selector(method3) withObject:nil afterDelay:2.7];
                    [self performSelector:@selector(method10) withObject:nil afterDelay:3.2];
                    return;
                }if ([sstr2 isEqualToString:@"0"] && [sstr3 isEqualToString:@"0"] && [sstr4 isEqualToString:@"0"] && [sstr5 isEqualToString:@"0"]) {
                    [self performSelector:@selector(qianMethod) withObject:nil afterDelay:0.7];
                    [self performSelector:@selector(cccc) withObject:nil afterDelay:1.2];
                    [self performSelector:@selector(baiMethod) withObject:nil afterDelay:1.7];
                    [self performSelector:@selector(method3) withObject:nil afterDelay:2.2];
                    [self performSelector:@selector(method10) withObject:nil afterDelay:2.7];
                    return;
                }if ([sstr1 isEqualToString:@"0"] && [sstr4 isEqualToString:@"0"] && [sstr5 isEqualToString:@"0"]) {
                    [self performSelector:@selector(qianMethod) withObject:nil afterDelay:0.7];
                    [self performSelector:@selector(lingMethod) withObject:nil afterDelay:1.2];
                    [self performSelector:@selector(yyyy) withObject:nil afterDelay:1.7];
                    [self performSelector:@selector(shiMethod) withObject:nil afterDelay:2.2];
                    [self performSelector:@selector(gggg) withObject:nil afterDelay:2.7];
                    [self performSelector:@selector(method3) withObject:nil afterDelay:3.2];
                    [self performSelector:@selector(method10) withObject:nil afterDelay:3.7];
                    return;
                }if ([sstr2 isEqualToString:@"0"] && [sstr4 isEqualToString:@"0"] && [sstr5 isEqualToString:@"0"]) {
                    [self performSelector:@selector(qianMethod) withObject:nil afterDelay:0.7];
                    [self performSelector:@selector(cccc) withObject:nil afterDelay:1.2];
                    [self performSelector:@selector(baiMethod) withObject:nil afterDelay:1.7];
                    [self performSelector:@selector(lingMethod) withObject:nil afterDelay:2.2];
                    [self performSelector:@selector(gggg) withObject:nil afterDelay:2.7];
                    [self performSelector:@selector(method3) withObject:nil afterDelay:3.2];
                    [self performSelector:@selector(method10) withObject:nil afterDelay:3.7];
                    return;
                }if ([sstr3 isEqualToString:@"0"] && [sstr4 isEqualToString:@"0"] && [sstr5 isEqualToString:@"0"]) {
                    [self performSelector:@selector(qianMethod) withObject:nil afterDelay:0.7];
                    [self performSelector:@selector(cccc) withObject:nil afterDelay:1.2];
                    [self performSelector:@selector(baiMethod) withObject:nil afterDelay:1.7];
                    [self performSelector:@selector(yyyy) withObject:nil afterDelay:2.2];
                    [self performSelector:@selector(shiMethod) withObject:nil afterDelay:2.7];
                    [self performSelector:@selector(method3) withObject:nil afterDelay:3.2];
                    [self performSelector:@selector(method10) withObject:nil afterDelay:3.7];
                    return;}
                if ([sstr4 isEqualToString:@"0"] && [sstr5 isEqualToString:@"0"]) {
                    [self performSelector:@selector(qianMethod) withObject:nil afterDelay:0.7];
                    [self performSelector:@selector(cccc) withObject:nil afterDelay:1.2];
                    [self performSelector:@selector(baiMethod) withObject:nil afterDelay:1.7];
                    [self performSelector:@selector(yyyy) withObject:nil afterDelay:2.2];
                    [self performSelector:@selector(shiMethod) withObject:nil afterDelay:2.7];
                    [self performSelector:@selector(gggg) withObject:nil afterDelay:3.2];
                    [self performSelector:@selector(method3) withObject:nil afterDelay:3.7];
                    [self performSelector:@selector(method10) withObject:nil afterDelay:4.2];
                    return;
                }if ([sstr1 isEqualToString:@"0"] && [sstr2 isEqualToString:@"0"] ) {
                    [self performSelector:@selector(qianMethod) withObject:nil afterDelay:0.7];
                    [self performSelector:@selector(lingMethod) withObject:nil afterDelay:1.2];
                    [self performSelector:@selector(gggg) withObject:nil afterDelay:1.7];
                    [self performSelector:@selector(dianMethod) withObject:nil afterDelay:2.2];
                    [self performSelector:@selector(dddd) withObject:nil afterDelay:2.7];
                    [self performSelector:@selector(ddddGG) withObject:nil afterDelay:3.2];
                    [self performSelector:@selector(method3) withObject:nil afterDelay:3.7];
                    [self performSelector:@selector(method10) withObject:nil afterDelay:4.2];
                    return;
                }if ([sstr1 isEqualToString:@"0"] && [sstr3 isEqualToString:@"0"] ) {
                    [self performSelector:@selector(qianMethod) withObject:nil afterDelay:0.7];
                    [self performSelector:@selector(lingMethod) withObject:nil afterDelay:1.2];
                    [self performSelector:@selector(yyyy) withObject:nil afterDelay:1.7];
                    [self performSelector:@selector(shiMethod) withObject:nil afterDelay:2.2];
                    [self performSelector:@selector(dianMethod) withObject:nil afterDelay:2.7];
                    [self performSelector:@selector(dddd) withObject:nil afterDelay:3.2];
                    [self performSelector:@selector(ddddGG) withObject:nil afterDelay:3.7];
                    [self performSelector:@selector(method3) withObject:nil afterDelay:4.2];
                    [self performSelector:@selector(method10) withObject:nil afterDelay:4.7];
                    return;
                }if ([sstr2 isEqualToString:@"0"] && [sstr3 isEqualToString:@"0"] ) {
                    [self performSelector:@selector(qianMethod) withObject:nil afterDelay:0.7];
                    [self performSelector:@selector(cccc) withObject:nil afterDelay:1.2];
                    [self performSelector:@selector(baiMethod) withObject:nil afterDelay:1.7];
                    [self performSelector:@selector(dianMethod) withObject:nil afterDelay:2.2];
                    [self performSelector:@selector(dddd) withObject:nil afterDelay:2.7];
                    [self performSelector:@selector(ddddGG) withObject:nil afterDelay:3.2];
                    [self performSelector:@selector(method3) withObject:nil afterDelay:3.7];
                    [self performSelector:@selector(method10) withObject:nil afterDelay:4.2];
                    return;
                }if ([sstr1 isEqualToString:@"0"]) {
                    [self performSelector:@selector(qianMethod) withObject:nil afterDelay:0.7];
                    [self performSelector:@selector(lingMethod) withObject:nil afterDelay:1.2];
                    [self performSelector:@selector(yyyy) withObject:nil afterDelay:1.7];
                    [self performSelector:@selector(shiMethod) withObject:nil afterDelay:2.2];
                    [self performSelector:@selector(gggg) withObject:nil afterDelay:2.7];
                    [self performSelector:@selector(dianMethod) withObject:nil afterDelay:3.2];
                    [self performSelector:@selector(dddd) withObject:nil afterDelay:3.7];
                    [self performSelector:@selector(ddddGG) withObject:nil afterDelay:4.2];
                    [self performSelector:@selector(method3) withObject:nil afterDelay:4.7];
                    [self performSelector:@selector(method10) withObject:nil afterDelay:5.2];
                    return;
                }if ([sstr2 isEqualToString:@"0"]) {
                    [self performSelector:@selector(qianMethod) withObject:nil afterDelay:0.7];
                    [self performSelector:@selector(cccc) withObject:nil afterDelay:1.2];
                    [self performSelector:@selector(baiMethod) withObject:nil afterDelay:1.7];
                    [self performSelector:@selector(lingMethod) withObject:nil afterDelay:2.2];
                    [self performSelector:@selector(gggg) withObject:nil afterDelay:2.7];
                    [self performSelector:@selector(dianMethod) withObject:nil afterDelay:3.2];
                    [self performSelector:@selector(dddd) withObject:nil afterDelay:3.7];
                    [self performSelector:@selector(ddddGG) withObject:nil afterDelay:4.2];
                    [self performSelector:@selector(method3) withObject:nil afterDelay:4.7];
                    [self performSelector:@selector(method10) withObject:nil afterDelay:5.2];
                    return;
                }if ([sstr3 isEqualToString:@"0"]) {
                    [self performSelector:@selector(qianMethod) withObject:nil afterDelay:0.7];
                    [self performSelector:@selector(cccc) withObject:nil afterDelay:1.2];
                    [self performSelector:@selector(baiMethod) withObject:nil afterDelay:1.7];
                    [self performSelector:@selector(yyyy) withObject:nil afterDelay:2.2];
                    [self performSelector:@selector(shiMethod) withObject:nil afterDelay:2.7];
                    [self performSelector:@selector(dianMethod) withObject:nil afterDelay:3.2];
                    [self performSelector:@selector(dddd) withObject:nil afterDelay:3.7];
                    [self performSelector:@selector(ddddGG) withObject:nil afterDelay:4.2];
                    [self performSelector:@selector(method3) withObject:nil afterDelay:4.7];
                    [self performSelector:@selector(method10) withObject:nil afterDelay:5.2];
                }else{
                    [self performSelector:@selector(qianMethod) withObject:nil afterDelay:0.7];
                    [self performSelector:@selector(cccc) withObject:nil afterDelay:1.2];
                    [self performSelector:@selector(baiMethod) withObject:nil afterDelay:1.7];
                    [self performSelector:@selector(yyyy) withObject:nil afterDelay:2.2];
                    [self performSelector:@selector(shiMethod) withObject:nil afterDelay:2.7];
                    [self performSelector:@selector(gggg) withObject:nil afterDelay:3.2];
                    [self performSelector:@selector(dianMethod) withObject:nil afterDelay:3.7];
                    [self performSelector:@selector(dddd) withObject:nil afterDelay:4.2];
                    [self performSelector:@selector(ddddGG)withObject:nil afterDelay:4.7];
                    [self performSelector:@selector(method3) withObject:nil afterDelay:5.2];
                    [self performSelector:@selector(method10) withObject:nil afterDelay:5.7];}}
        }else{
            NSLog(@"请输入数据!!");}}
}
#pragma mark----11.第一个输入框(再有小数点的情况下)
- (void)cc{
    NSString * str1 =[str substringWithRange:NSMakeRange(1, 1)];
    NSString * sttt = [NSString stringWithFormat:@"%@.mp3",str1];
    NSURL * urll = [[NSBundle mainBundle]URLForResource:sttt withExtension:nil];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(urll), &(_csSoundID));
    AudioServicesPlayAlertSound(_csSoundID);
}
- (void)yy{
    NSString * str2 =[str substringWithRange:NSMakeRange(2, 1)];
    NSString * sttt = [NSString stringWithFormat:@"%@.mp3",str2];
    NSURL * urll = [[NSBundle mainBundle]URLForResource:sttt withExtension:nil];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(urll), &(_csSoundID));
    AudioServicesPlayAlertSound(_csSoundID);
}
- (void)gg{
    NSString * str2 =[str substringWithRange:NSMakeRange(3, 1)];
    NSString * sttt = [NSString stringWithFormat:@"%@.mp3",str2];
    NSURL * urll = [[NSBundle mainBundle]URLForResource:sttt withExtension:nil];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(urll), &(_csSoundID));
    AudioServicesPlayAlertSound(_csSoundID);
}
- (void)aa{
    NSString * str3 =[str substringWithRange:NSMakeRange(4, 1)];
    NSString * sttt = [NSString stringWithFormat:@"%@.mp3",str3];
    NSURL * urll = [[NSBundle mainBundle]URLForResource:sttt withExtension:nil];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(urll), &(_csSoundID));
    AudioServicesPlayAlertSound(_csSoundID);
}
- (void)dd{
    NSString * str4 =[str substringWithRange:NSMakeRange(5, 1)];
    NSString * sttt = [NSString stringWithFormat:@"%@.mp3",str4];
    NSURL * urll = [[NSBundle mainBundle]URLForResource:sttt withExtension:nil];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(urll), &(_csSoundID));
    AudioServicesPlayAlertSound(_csSoundID);
}
- (void)hh{
    NSString * str5 =[str substringWithRange:NSMakeRange(6, 1)];
    NSString * sttt = [NSString stringWithFormat:@"%@.mp3",str5];
    NSURL * urll = [[NSBundle mainBundle]URLForResource:sttt withExtension:nil];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(urll), &(_csSoundID));
    AudioServicesPlayAlertSound(_csSoundID);
}
- (void)ww{
    NSString * str6 =[str substringWithRange:NSMakeRange(7, 1)];
    NSString * sttt = [NSString stringWithFormat:@"%@.mp3",str6];
    NSURL * urll = [[NSBundle mainBundle]URLForResource:sttt withExtension:nil];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(urll), &(_csSoundID));
    AudioServicesPlayAlertSound(_csSoundID);
}
#pragma mark---12.第二个输入框(再有小数点的情况下)
- (void)ccc{
    NSString * str1 =[timeStr substringWithRange:NSMakeRange(1, 1)];
    NSString * sttt = [NSString stringWithFormat:@"%@.mp3",str1];
    NSURL * urll = [[NSBundle mainBundle]URLForResource:sttt withExtension:nil];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(urll), &(_timeSoundID));
    AudioServicesPlayAlertSound(_timeSoundID);
}
- (void)yyy{
    NSString * str2 =[timeStr substringWithRange:NSMakeRange(2, 1)];
    NSString * sttt = [NSString stringWithFormat:@"%@.mp3",str2];
    NSURL * urll = [[NSBundle mainBundle]URLForResource:sttt withExtension:nil];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(urll), &(_timeSoundID));
    AudioServicesPlayAlertSound(_timeSoundID);
}
- (void)ggg{
    NSString * str2 =[timeStr substringWithRange:NSMakeRange(3, 1)];
    NSString * sttt = [NSString stringWithFormat:@"%@.mp3",str2];
    NSURL * urll = [[NSBundle mainBundle]URLForResource:sttt withExtension:nil];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(urll), &(_timeSoundID));
    AudioServicesPlayAlertSound(_timeSoundID);
}
- (void)aaa{
    NSString * str3 =[timeStr substringWithRange:NSMakeRange(4, 1)];
    NSString * sttt = [NSString stringWithFormat:@"%@.mp3",str3];
    NSURL * urll = [[NSBundle mainBundle]URLForResource:sttt withExtension:nil];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(urll), &(_timeSoundID));
    AudioServicesPlayAlertSound(_timeSoundID);
}
- (void)ddd{
    NSString * str4 =[timeStr substringWithRange:NSMakeRange(5, 1)];
    NSString * sttt = [NSString stringWithFormat:@"%@.mp3",str4];
    NSURL * urll = [[NSBundle mainBundle]URLForResource:sttt withExtension:nil];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(urll), &(_timeSoundID));
    AudioServicesPlayAlertSound(_timeSoundID);
}
- (void)dddGG{
    NSString * str5 =[timeStr substringWithRange:NSMakeRange(6, 1)];
    NSString * sttt = [NSString stringWithFormat:@"%@.mp3",str5];
    NSURL * urll = [[NSBundle mainBundle]URLForResource:sttt withExtension:nil];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(urll), &(_timeSoundID));
    AudioServicesPlayAlertSound(_timeSoundID);
}
#pragma mark---13.第三个输入框(有小数点的情况下)
- (void)cccc{
    NSString * str1 =[hsStr substringWithRange:NSMakeRange(1, 1)];
    NSString * sttt = [NSString stringWithFormat:@"%@.mp3",str1];
    NSURL * urll = [[NSBundle mainBundle]URLForResource:sttt withExtension:nil];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(urll), &(_hsSoundID));
    AudioServicesPlayAlertSound(_hsSoundID);
}
- (void)yyyy{
    NSString * str2 =[hsStr substringWithRange:NSMakeRange(2, 1)];
    NSString * sttt = [NSString stringWithFormat:@"%@.mp3",str2];
    NSURL * urll = [[NSBundle mainBundle]URLForResource:sttt withExtension:nil];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(urll), &(_hsSoundID));
    AudioServicesPlayAlertSound(_hsSoundID);
}
- (void)gggg{
    NSString * str2 =[hsStr substringWithRange:NSMakeRange(3, 1)];
    NSString * sttt = [NSString stringWithFormat:@"%@.mp3",str2];
    NSURL * urll = [[NSBundle mainBundle]URLForResource:sttt withExtension:nil];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(urll), &(_hsSoundID));
    AudioServicesPlayAlertSound(_hsSoundID);
}
- (void)aaaa{
    NSString * str3 =[hsStr substringWithRange:NSMakeRange(4, 1)];
    NSString * sttt = [NSString stringWithFormat:@"%@.mp3",str3];
    NSURL * urll = [[NSBundle mainBundle]URLForResource:sttt withExtension:nil];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(urll), &(_hsSoundID));
    AudioServicesPlayAlertSound(_hsSoundID);
}
- (void)dddd{
    NSString * str4 =[hsStr substringWithRange:NSMakeRange(5, 1)];
    NSString * sttt = [NSString stringWithFormat:@"%@.mp3",str4];
    NSURL * urll = [[NSBundle mainBundle]URLForResource:sttt withExtension:nil];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(urll), &(_hsSoundID));
    AudioServicesPlayAlertSound(_hsSoundID);
}
- (void)ddddGG{
    NSString * str5 =[hsStr substringWithRange:NSMakeRange(6, 1)];
    NSString * sttt = [NSString stringWithFormat:@"%@.mp3",str5];
    NSURL * urll = [[NSBundle mainBundle]URLForResource:sttt withExtension:nil];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(urll), &(_hsSoundID));
    AudioServicesPlayAlertSound(_hsSoundID);
}
#pragma mark ---14.播放各个音效的方法
- (void)method1{
    NSURL * url = [[NSBundle mainBundle]URLForResource:@"走了.mp3" withExtension:nil];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &(_zlSoundID));
    AudioServicesPlaySystemSound(self.zlSoundID);
}
- (void)paoleMethod{
    NSURL * url = [[NSBundle mainBundle]URLForResource:@"跑了.mp3" withExtension:nil];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &(_pbSoundID));
    AudioServicesPlaySystemSound(self.pbSoundID);
}
- (void)qileMethod{
    NSURL * url = [[NSBundle mainBundle]URLForResource:@"骑了.mp3" withExtension:nil];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &(_qxSoundID));
    AudioServicesPlaySystemSound(self.qxSoundID);
}
- (void)method3{
    NSURL * url = [[NSBundle mainBundle]URLForResource:@"公里.mp3" withExtension:nil];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &(_glSoundID));
    AudioServicesPlaySystemSound(self.glSoundID);
}
- (void)method4{
    NSURL * url = [[NSBundle mainBundle]URLForResource:@"平均配速.mp3" withExtension:nil];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &(_psSoundID));
    AudioServicesPlaySystemSound(self.psSoundID);
}
- (void)method6{
    NSURL * url = [[NSBundle mainBundle]URLForResource:@"小时.mp3" withExtension:nil];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &(_xsSoundID));
    AudioServicesPlaySystemSound(self.xsSoundID);
}
- (void)method7{
    NSURL * url = [[NSBundle mainBundle]URLForResource:@"每公里.mp3" withExtension:nil];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &(_mglSoundID));
    AudioServicesPlayAlertSound(self.mglSoundID);
}
- (void)method8{
    NSURL * url = [[NSBundle mainBundle]URLForResource:@"平均速度.mp3" withExtension:nil];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &(_sdSoundID));
    AudioServicesPlayAlertSound(self.sdSoundID);
}
- (void)method10{
    NSURL * url = [[NSBundle mainBundle]URLForResource:@"每小时.mp3" withExtension:nil];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &(_mxsSoundID));
    AudioServicesPlayAlertSound(self.mxsSoundID);
}
- (void)method11{
    NSURL * url = [[NSBundle mainBundle]URLForResource:@"分钟.mp3" withExtension:nil];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &(_fzSoundID));
    AudioServicesPlayAlertSound(self.fzSoundID);
}
- (void)method12{
    NSURL * url = [[NSBundle mainBundle]URLForResource:@"秒.mp3" withExtension:nil];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &(_minSoundID));
    AudioServicesPlayAlertSound(self.minSoundID);
}
- (void)method13{
    NSURL * url = [[NSBundle mainBundle]URLForResource:@"放松一下吧.mp3" withExtension:nil];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &(_fsSoundID));
    AudioServicesPlayAlertSound(self.fsSoundID);
}
#pragma mark--15.第一个输入框的长度
- (void)method15{
    NSString * str2 =[str substringWithRange:NSMakeRange(1, 1)];
    NSString * sttr = [NSString stringWithFormat:@"%@.mp3",str2];
    NSURL * url = [[NSBundle mainBundle]URLForResource:sttr withExtension:nil];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &(_csSoundID));
    AudioServicesPlayAlertSound(_csSoundID);
}
- (void)method16{
    NSString * str3 =[str substringWithRange:NSMakeRange(2, 1)];
    NSString * sttr = [NSString stringWithFormat:@"%@.mp3",str3];
    NSURL * url = [[NSBundle mainBundle]URLForResource:sttr withExtension:nil];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &(_csSoundID));
    AudioServicesPlayAlertSound(_csSoundID);
}
- (void)method17{
    NSString * str4 =[str substringWithRange:NSMakeRange(3, 1)];
    NSString * sttr = [NSString stringWithFormat:@"%@.mp3",str4];
    NSURL * url = [[NSBundle mainBundle]URLForResource:sttr withExtension:nil];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &(_csSoundID));
    AudioServicesPlayAlertSound(_csSoundID);
}
- (void)method17GG{
    NSString * str5 =[str substringWithRange:NSMakeRange(4, 1)];
    NSString * sttr = [NSString stringWithFormat:@"%@.mp3",str5];
    NSURL * url = [[NSBundle mainBundle]URLForResource:sttr withExtension:nil];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &(_csSoundID));
    AudioServicesPlayAlertSound(_csSoundID);
}
#pragma mark--16.第二个输入框的长度
- (void)method18{
    NSString * str2 =[timeStr substringWithRange:NSMakeRange(1, 1)];
    NSString * sttr = [NSString stringWithFormat:@"%@.mp3",str2];
    NSURL * url = [[NSBundle mainBundle]URLForResource:sttr withExtension:nil];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &(_timeSoundID));
    AudioServicesPlayAlertSound(_timeSoundID);
}
- (void)method19{
    NSString * str3 =[timeStr substringWithRange:NSMakeRange(2, 1)];
    NSString * sttr = [NSString stringWithFormat:@"%@.mp3",str3];
    NSURL * url = [[NSBundle mainBundle]URLForResource:sttr withExtension:nil];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &(_timeSoundID));
    AudioServicesPlayAlertSound(_timeSoundID);
}
- (void)method20{
    NSString * str4 =[timeStr substringWithRange:NSMakeRange(3, 1)];
    NSString * sttr = [NSString stringWithFormat:@"%@.mp3",str4];
    NSURL * url = [[NSBundle mainBundle]URLForResource:sttr withExtension:nil];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &(_timeSoundID));
    AudioServicesPlayAlertSound(_timeSoundID);
}
- (void)method20GG{
    NSString * str5 =[timeStr substringWithRange:NSMakeRange(4, 1)];
    NSString * sttr = [NSString stringWithFormat:@"%@.mp3",str5];
    NSURL * url = [[NSBundle mainBundle]URLForResource:sttr withExtension:nil];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &(_timeSoundID));
    AudioServicesPlayAlertSound(_timeSoundID);
}
#pragma mark--17.第三个输入框的长度
- (void)method21{
    NSString * str2 =[hsStr substringWithRange:NSMakeRange(1, 1)];
    NSString * sttr = [NSString stringWithFormat:@"%@.mp3",str2];
    NSURL * url = [[NSBundle mainBundle]URLForResource:sttr withExtension:nil];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &(_hsSoundID));
    AudioServicesPlayAlertSound(_hsSoundID);
}
- (void)method22{
    NSString * str3 =[hsStr substringWithRange:NSMakeRange(2, 1)];
    NSString * sttr = [NSString stringWithFormat:@"%@.mp3",str3];
    NSURL * url = [[NSBundle mainBundle]URLForResource:sttr withExtension:nil];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &(_hsSoundID));
    AudioServicesPlayAlertSound(_hsSoundID);
}
- (void)method23{
    NSString * str4 =[hsStr substringWithRange:NSMakeRange(3, 1)];
    NSString * sttr = [NSString stringWithFormat:@"%@.mp3",str4];
    NSURL * url = [[NSBundle mainBundle]URLForResource:sttr withExtension:nil];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &(_hsSoundID));
    AudioServicesPlayAlertSound(_hsSoundID);
}
- (void)method23GG{
    NSString * str5 =[hsStr substringWithRange:NSMakeRange(4, 1)];
    NSString * sttr = [NSString stringWithFormat:@"%@.mp3",str5];
    NSURL * url = [[NSBundle mainBundle]URLForResource:sttr withExtension:nil];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &(_hsSoundID));
    AudioServicesPlayAlertSound(_hsSoundID);
}
#pragma mark---18.符号音频
- (void)dianMethod{
    NSURL * shiurl = [[NSBundle mainBundle]URLForResource:@"点.mp3" withExtension:nil];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(shiurl), &(_shiSoundID));
    AudioServicesPlayAlertSound(_shiSoundID);
    AudioServicesPlayAlertSound(self.shiSoundID);
}
- (void)lingMethod{
    NSURL * shiurl = [[NSBundle mainBundle]URLForResource:@"0.mp3" withExtension:nil];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(shiurl), &(_shiSoundID));
    AudioServicesPlayAlertSound(_shiSoundID);
    AudioServicesPlayAlertSound(self.shiSoundID);
}
- (void)shiMethod{
    NSURL * shiurl = [[NSBundle mainBundle]URLForResource:@"十.mp3" withExtension:nil];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(shiurl), &(_shiSoundID));
    AudioServicesPlayAlertSound(_shiSoundID);
    AudioServicesPlayAlertSound(self.shiSoundID);
}
- (void)baiMethod{
    NSURL * shiurl = [[NSBundle mainBundle]URLForResource:@"百.mp3" withExtension:nil];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(shiurl), &(_shiSoundID));
    AudioServicesPlayAlertSound(_shiSoundID);
    AudioServicesPlayAlertSound(self.shiSoundID);
}
- (void)qianMethod{
    NSURL * shiurl = [[NSBundle mainBundle]URLForResource:@"千.mp3" withExtension:nil];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(shiurl), &(_shiSoundID));
    AudioServicesPlayAlertSound(_shiSoundID);
    AudioServicesPlayAlertSound(self.shiSoundID);
}
- (void)wanMethod{
    NSURL * shiurl = [[NSBundle mainBundle]URLForResource:@"万.mp3" withExtension:nil];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(shiurl), &(_shiSoundID));
    AudioServicesPlayAlertSound(_shiSoundID);
    AudioServicesPlayAlertSound(self.shiSoundID);
}
- (void)liangMethod{
    NSURL * lUrl = [[NSBundle mainBundle]URLForResource:@"两.mp3" withExtension:nil];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(lUrl), &(_shiSoundID));
    AudioServicesPlayAlertSound(_shiSoundID);
    AudioServicesPlayAlertSound(self.shiSoundID);
}



@end
