//
//  LvCurvesView.m
//  Statistics
//
//  Created by lv on 2016/11/8.
//  Copyright © 2016年 lv. All rights reserved.
//

#import "LvCurvesView.h"

@interface LvCurvesView ()<UIScrollViewDelegate,LvCurvesLineDelegate>
{
    NSMutableArray *_arrCoodinateValue;
    NSMutableArray *_arrCoodinateValueLabCopy;
    
}
@end

@implementation LvCurvesView

- (instancetype)initWithArrSell:(NSMutableArray *)arrSell arrTime:(NSMutableArray *)arrTime frame:(CGRect)frame lineColor:(NSArray *)arrLineColor lineWidth:(NSArray *)arrLineWidth bgColor:(NSArray *)arrBgColor;
{
    self = [super initWithFrame:frame];
    if (self) {
        self.arrSell=arrSell;
        self.arrBgColor=arrBgColor;
        self.arrTime=arrTime;
        self.arrLineWidth=arrLineWidth;
        self.arrLineColor=arrLineColor;
        self.maxSell=[self getMaxValues];

        self.cureToLeftDistance=0;
        self.cureToRightDistance=0;
        self.cureToTopDistance=0;
        self.cureToBottomDistance=0;
        
        self.leftDistance=15;
        self.rightDistance=15;
        self.layer.shouldRasterize = YES;
        self.backgroundColor=[UIColor clearColor];

        self.rowNumber=5;
        self.distotion=15;
        self.timeLabHight=30;
        _arrCoodinateValue=[NSMutableArray arrayWithCapacity:0];
        
    }
    return self;
}



-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    if (self.arrSell.count<=0)
    {
        return;
    }
    if (self.isCoordinateValueCanMove)
    {
        _arrCoodinateValueLabCopy=[NSMutableArray arrayWithCapacity:0];
    }

//    
//    if (self.columnWidth<=0)
//    {
//        self.columnWidth=(self.frame.size.width-self.cureToTopDistance-self.leftDistance);
//    }
    
    NSArray *arrS=self.arrSell[0];
    CGFloat floatW=self.frame.size.width-self.cureToLeftDistance-self.cureToRightDistance;
    if (self.columnWidth>0)
    {
        floatW=self.columnWidth*(arrS.count-1)+self.leftDistance+self.rightDistance;
    }
    else
    {
        if (self.arrSell.count>0)
        {
            NSArray *arrS=self.arrSell[0];
            
            self.columnWidth=(self.frame.size.width-self.leftDistance-self.rightDistance-self.cureToLeftDistance-self.cureToRightDistance)/(arrS.count-1);
        }
    }
   
    
    CGRect rectCoordinateLine=CGRectMake(self.cureToLeftDistance+(self.isCoordinateValueCanMove?self.coordinateValueWidth:0), self.cureToTopDistance, self.frame.size.width-self.cureToLeftDistance-self.cureToRightDistance, self.frame.size.height-self.cureToTopDistance-self.cureToBottomDistance-self.timeLabHight);
    if (self.isCoordinateLineCanMove)
    {
        rectCoordinateLine=CGRectMake((self.isCoordinateValueCanMove?self.coordinateValueWidth:0), 0, floatW, self.frame.size.height-self.cureToTopDistance-self.cureToBottomDistance-self.timeLabHight);
    }
    self.coordinateLine=[[LvCoordinateLine alloc]initWithFrame:rectCoordinateLine];
    self.coordinateLine.arrSell=self.arrSell;
    self.coordinateLine.arrTime=self.arrTime;
    self.coordinateLine.maxSell=self.curvesLine.maxSell;
    self.coordinateLine.cuttingLineColor=self.cuttingLineColor;
    self.coordinateLine.cuttingLineWidth=self.cuttingLineWidth;
    self.coordinateLine.rowNumber=self.rowNumber;
    self.coordinateLine.maxSell=self.maxSell;
    self.coordinateLine.coordinateLineColor=self.coordinateLineColor;
    self.coordinateLine.coordinateLineWidth=self.coordinateLineWidth;
    self.coordinateLine.isHiddenCuttingLine=self.isHiddenCuttingLine;
    self.coordinateLine.coordinateYOver=self.coordinateYOver;
    self.coordinateLine.isHiddenCoordinateLine=self.isHiddenCoordinateLine;
    
    if (!self.isCoordinateLineCanMove)
    {
        [self addSubview:self.coordinateLine];
        [self sendSubviewToBack:self.coordinateLine];
    }
   
    CGRect rectScroll=CGRectMake(self.cureToLeftDistance, self.cureToTopDistance, self.frame.size.width-self.cureToLeftDistance-self.cureToRightDistance, self.frame.size.height-self.cureToTopDistance-self.cureToBottomDistance);

    
    self.scrollView=[[UIScrollView alloc]initWithFrame:rectScroll];
    self.scrollView.backgroundColor=[UIColor clearColor];
    self.scrollView.contentSize=CGSizeMake(self.isCoordinateValueCanMove?(floatW+self.coordinateValueWidth):floatW, 0);
    self.scrollView.showsVerticalScrollIndicator=NO;
    self.scrollView.showsHorizontalScrollIndicator=NO;
    self.scrollView.clipsToBounds=YES;
    self.scrollView.delegate=self;
    [self addSubview:self.scrollView];
    if (self.isCoordinateLineCanMove)
    {
        [self.scrollView addSubview:self.coordinateLine];
      
        [self.scrollView sendSubviewToBack:self.coordinateLine];
    }
    

    
    CGRect rectCureLine=CGRectMake(self.coordinateLine.coordinateLineWidth+(self.isCoordinateValueCanMove?self.coordinateValueWidth:0), 0, floatW, self.scrollView.frame.size.height-self.coordinateLine.coordinateLineWidth-self.timeLabHight);
    

    
    self.curvesLine=[[LvCurvesLine alloc]initWithArrSell:self.arrSell arrTime:self.arrTime frame:rectCureLine lineColor:self.arrLineColor lineWidth:self.arrLineWidth bgColor:self.arrBgColor];
    self.curvesLine.delegate=self;
    self.curvesLine.backgroundColor=[UIColor clearColor];
    self.curvesLine.isHiddenPoint=self.isHiddenPoint;
    self.curvesLine.isHiddenPointValue=self.isHiddenPointValue;
    self.curvesLine.isHiddenFillView=self.isHiddenFillView;
    self.curvesLine.distotion=self.distotion;
    self.curvesLine.columnWidth=self.columnWidth;
    self.curvesLine.leftDistance=self.leftDistance;
    self.curvesLine.rowNumber=self.rowNumber;
    self.curvesLine.arrPointWidth=self.arrPointWidth;
    self.curvesLine.arrLineWidth=self.arrLineWidth;
    self.curvesLine.arrPointBgColor=self.arrPointBgColor;
    self.curvesLine.arrPointValueFont=self.arrPointValueFont;
    self.curvesLine.arrPointValueFontColor=self.arrPointValueFontColor;
    self.curvesLine.maxSell=self.maxSell;
    self.curvesLine.rightDistance=self.rightDistance;
    self.curvesLine.coordinateYOver=self.coordinateYOver;
    [self.scrollView addSubview:self.curvesLine];
    
    [self.arrTime enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
    }];
    
    if(!self.isHiddenCoordinateValue)
    {
        CGFloat rowH=(self.frame.size.height-self.cureToTopDistance-self.cureToBottomDistance-self.coordinateYOver)/(self.rowNumber+1);
        
        for (NSInteger i=0; i<(self.rowNumber); i++)
        {
            
            UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.isCoordinateValueCanMove?self.coordinateValueWidth:(self.cureToLeftDistance-5), 30)];
            lab.textColor=[UIColor whiteColor];
            lab.font=self.leftValueFont?self.leftValueFont:[UIFont systemFontOfSize:13];
            lab.textAlignment=NSTextAlignmentRight;
            lab.textColor=self.leftValueFontColor?self.leftValueFontColor:[UIColor blackColor];
            lab.center=self.isCoordinateValueCanMove?CGPointMake((self.coordinateValueWidth-6)/2, self.coordinateYOver+i*rowH):CGPointMake(lab.frame.size.width/2, self.cureToTopDistance+self.coordinateYOver+i*rowH);
            lab.text=[NSString stringWithFormat:@"%.0f",(self.maxSell/(self.rowNumber))*(self.rowNumber-i)];
            if(self.isCoordinateValueCanMove)
            {
                [_scrollView addSubview:lab];
            }
            else
            {
                [self addSubview:lab];
            }
            
            [_arrCoodinateValue addObject:lab];
            //左边数值
        }
        
    }
    
    if(!self.isHiddenCoordinateTime)
    {
        
        [self.arrTime enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.columnWidth, 30)];
            lab.textColor=[UIColor whiteColor];
            //            lab.backgroundColor=[UIColor redColor];
            lab.font=self.timeLabFont?self.timeLabFont:[UIFont systemFontOfSize:13];
            lab.textAlignment=NSTextAlignmentCenter;
            lab.textColor=self.timeLabFontColor?self.timeLabFontColor:[UIColor blackColor];
            lab.center=CGPointMake((self.isCoordinateValueCanMove?self.coordinateValueWidth:0)+self.leftDistance+idx*self.columnWidth, _curvesLine.frame.size.height+_curvesLine.frame.origin.y+self.timeLabHight/2);
           
            lab.text=[NSString stringWithFormat:@"%@",obj];
            [self.scrollView addSubview:lab];
            
        }];
    }
}

-(void)LvCurvesLine:(LvCurvesLine *)lvCurvesLine clickLine:(NSInteger)line clickPoint:(NSInteger)point value:(CGFloat)value
{
    if ([self.delegate respondsToSelector:@selector(LvCurvesView:clickLine:clickPoint:value:)])
    {
        [self.delegate LvCurvesView:self clickLine:line clickPoint:point value:value];
    }
}

//-(void)LvCurvesFill:(LvCurvesFill *)LvCurvesFill clickFill:(NSInteger)tag
//{
//    if ([self.delegate respondsToSelector:@selector(LvCurvesFill:clickFill:)])
//    {
//        [self.delegate LvCurvesFill:LvCurvesFill clickFill:tag];
//    }
//}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.isCoordinateValueCanMove)
    {
        CGFloat rowH=(self.frame.size.height-self.cureToTopDistance-self.cureToBottomDistance-self.coordinateYOver)/(self.rowNumber+1);
        if (scrollView.contentOffset.x>self.coordinateValueWidth)
        {
            if (_arrCoodinateValueLabCopy.count==0)
            {
                [_arrCoodinateValue enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    UILabel *lab=obj;
                    UILabel *labNew=[[UILabel alloc]initWithFrame:CGRectMake(self.cureToLeftDistance, self.cureToTopDistance+ self.coordinateYOver+idx*rowH-20, 80, 20)];
                    labNew.font=self.leftValueOnFont?self.leftValueOnFont:[UIFont systemFontOfSize:10];
                    labNew.textColor=self.leftValueOnFontColor?self.leftValueOnFontColor:[UIColor colorWithWhite:0.1 alpha:0.5];
                    labNew.text=lab.text;
                    labNew.alpha=0.6;
                    [self addSubview:labNew];
                    [_arrCoodinateValueLabCopy addObject:labNew];
                }];
            }

        }
        else
        {
            [_arrCoodinateValueLabCopy enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                UILabel *lab=obj;
                [lab removeFromSuperview];
            }];
            [_arrCoodinateValueLabCopy removeAllObjects];
        }
    }
}

-(CGFloat)getMaxValues
{
    NSMutableArray *arrMaxs=[NSMutableArray arrayWithCapacity:0];
    [self.arrSell enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat max = [[obj valueForKeyPath:@"@max.intValue"] integerValue];
        [arrMaxs addObject:[NSString stringWithFormat:@"%f",max]];
    }];
    
    return  [[arrMaxs valueForKeyPath:@"@max.intValue"] integerValue];
}


@end
