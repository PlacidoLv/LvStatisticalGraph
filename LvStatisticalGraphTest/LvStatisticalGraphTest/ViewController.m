//
//  ViewController.m
//  LvStatisticalGraphTest
//
//  Created by lv on 2016/11/11.
//  Copyright © 2016年 lv. All rights reserved.
//

#import "ViewController.h"
#import "LvCurvesView.h"
#import "LvPieView.h"

#define SIZE [UIScreen mainScreen].bounds.size
#define Random_Color(A) [UIColor colorWithRed:(arc4random()%255)/255.0f green:(arc4random()%255)/255.0f blue:(arc4random()%255)/255.0f alpha:A]

@interface ViewController ()<LvCurvesViewDelegate,UIWebViewDelegate>
{
    LvPieView *_showPie;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets=NO;
    //    NSArray *arrValues=@[@[@"100",@"213",@"150",@"80",@"150",@"80"],@[@"160",@"100",@"120",@"150",@"80",@"150"]];
    self.navigationController.navigationBar.hidden=YES;
    
    NSMutableArray *arrValue=[NSMutableArray arrayWithCapacity:0];//数值
    NSMutableArray *arrText=[NSMutableArray arrayWithCapacity:0];//说明
    NSMutableArray *arrPieValue=[NSMutableArray arrayWithCapacity:0];//数值
    NSMutableArray *arrTime=[NSMutableArray arrayWithCapacity:0];//时间
    NSMutableArray *arrLinesColors=[NSMutableArray arrayWithCapacity:0];//曲线颜色
    NSMutableArray *arrBgColor=[NSMutableArray arrayWithCapacity:0];//曲下覆盖层颜色
    
    NSMutableArray *arrPointWidth=[NSMutableArray arrayWithCapacity:0];//曲线顶点宽度
    NSMutableArray *arrPointValueFont=[NSMutableArray arrayWithCapacity:0];//曲线顶点字体
    NSMutableArray *arrPointBgColor=[NSMutableArray arrayWithCapacity:0];//曲线顶点背景颜色
    NSMutableArray *arrPointValueFontColor=[NSMutableArray arrayWithCapacity:0];//曲线顶点数值字体颜色
    
    
    for (NSInteger j=0; j<4; j++)
    {
        NSMutableArray *arrValue1=[NSMutableArray arrayWithCapacity:0];
        for (NSInteger i=0; i<50; i++)
        {
            [arrValue1 addObject:[NSString stringWithFormat:@"%zd",arc4random()%1000]];
            [arrTime addObject:[NSString stringWithFormat:@"时间%zd",i]];
        }
        [arrText addObject:[NSString stringWithFormat:@"标题%zd",j]];
        [arrPieValue addObject:[NSString stringWithFormat:@"%zd",arc4random()%100]];
        [arrValue addObject:arrValue1];
        [arrLinesColors addObject:Random_Color(1)];
        [arrBgColor addObject:@[Random_Color(0.5), Random_Color(0.5)]];
        [arrPointWidth addObject:[NSString stringWithFormat:@"%.1f",0.1*(arc4random()%10+10)+4]];
        [arrPointValueFont addObject:[UIFont systemFontOfSize:12]];
        [arrPointBgColor addObject:Random_Color(0.5)];
        [arrPointValueFontColor addObject:Random_Color(0.5)];
        
    }
    
    
    //曲线图，折线图
    CGRect rect=CGRectMake(10, 60, SIZE.width-20, 250);
    
    
    NSArray *arrLineWidth=@[@"0.5",@"1"];
    
    LvCurvesView *curves=[[LvCurvesView alloc]initWithArrSell:arrValue arrTime:arrTime frame:rect lineColor:arrLinesColors lineWidth:arrLineWidth bgColor:arrBgColor];
    curves.backgroundColor=[[UIColor blueColor] colorWithAlphaComponent:0.1];
    curves.delegate=self;
    //曲线定点设置
    curves.arrPointWidth=arrPointWidth;
    curves.arrPointBgColor=arrPointBgColor;
    curves.arrPointValueFont=arrPointValueFont;
    curves.arrPointValueFontColor=arrPointValueFontColor;
    
    //左侧分割线数值设置
    curves.leftValueFont=[UIFont systemFontOfSize:14];
    curves.leftValueFontColor=Random_Color(1);
    curves.leftValueOnFont=[UIFont systemFontOfSize:11];
    curves.leftValueOnFontColor=Random_Color(0.7);
    
    //列宽 不设置自动计算（平分当前绘图区域的宽度）
    curves.columnWidth=60;
    
    //下面时间lab设置
    curves.timeLabHight=30;
    curves.timeLabFont=[UIFont systemFontOfSize:12];
    curves.timeLabFontColor=Random_Color(1);
    
    //扭曲度 值越大越弯 为0则是折线图
    curves.distotion=10;
    curves.rowNumber=5;
    //    curves.maxSell=250;
    curves.coordinateYOver=20;
    //    curves.isHiddenPoint=YES;
    curves.isCoordinateValueCanMove=YES;
    curves.coordinateValueWidth=30;
    curves.isCoordinateLineCanMove=YES;
    
    //    curves.isHiddenFillView=YES;
    //    curves.isHiddenCoordinateLine=YES;
    //    curves.isHiddenCuttingLine=YES;
    //    curves.isHiddenCoordinateTime=YES;
    //    curves.isHiddenCoordinateValue=YES;
    //    curves.isHiddenPoint=YES;
    //    curves.isHiddenPointValue=YES;
    
    [self.view addSubview:curves];
    
    
    
    //饼状图
    _showPie=[[LvPieView alloc]initWithFrame:CGRectMake(0, 0, 200, 200) arrText:arrText arrValue:arrPieValue arrColor:arrPointBgColor];
    _showPie.center=CGPointMake(SIZE.width/2, SIZE.height-150);
    _showPie.pieLineWidth=40;
    _showPie.selectDistance=10;
    _showPie.selectIndex=0;
    //    _showPie.selectColor=[UIColor redColor];
    [self.view addSubview:_showPie];
    _showPie.backgroundColor=[[UIColor blueColor] colorWithAlphaComponent:0.1];
    
    UIButton *btnSet=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 30)];
    [btnSet setTitle:@"绘制" forState:UIControlStateNormal];
    [btnSet setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btnSet.center=CGPointMake(_showPie.center.x, _showPie.center.y-130);
    [btnSet addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnSet];
}

-(void)btnClick
{
    
    NSMutableArray *arrText=[NSMutableArray arrayWithCapacity:0];//数值
    NSMutableArray *arrPieValue=[NSMutableArray arrayWithCapacity:0];//数值
    NSMutableArray *arrPointBgColor=[NSMutableArray arrayWithCapacity:0];//曲线顶点背景颜色
    
    
    
    for (NSInteger j=0; j<8; j++)
    {
        [arrText addObject:[NSString stringWithFormat:@"标题%zd",j]];
        [arrPieValue addObject:[NSString stringWithFormat:@"%zd",arc4random()%100]];
        [arrPointBgColor addObject:Random_Color(0.5)];
        
        
    }
    [arrPieValue addObject:[NSString stringWithFormat:@"0.01"]];
    NSLog(@"value=%@",[arrPieValue componentsJoinedByString:@","]);
    [_showPie removeFromSuperview];
    _showPie=nil;
    _showPie=[[LvPieView alloc]initWithFrame:CGRectMake(0, 0, 200, 200) arrText:arrText arrValue:arrPieValue arrColor:arrPointBgColor];
    _showPie.center=CGPointMake(SIZE.width/2, SIZE.height-150);
    _showPie.pieLineWidth=10;
    //    _showPie.selectIndex=0;
    //    _showPie.selectColor=[UIColor redColor];
    [self.view addSubview:_showPie];
    _showPie.backgroundColor=[[UIColor blueColor] colorWithAlphaComponent:0.1];
}

-(void)LvCurvesView:(LvCurvesView *)LvCurvesView clickLine:(NSInteger)line clickPoint:(NSInteger)point value:(CGFloat)value
{
    NSLog(@"line=%zd point=%zd value=%f",line,point,value);
}

-(void)LvCurvesFill:(LvCurvesFill *)LvCurvesFill clickFill:(NSInteger)tag
{
    NSLog(@"LvCurvesFillt=%@ tag=%zd",LvCurvesFill,tag);
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"error=%@",error);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
