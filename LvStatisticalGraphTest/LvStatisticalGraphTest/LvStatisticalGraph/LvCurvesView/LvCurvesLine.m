//
//  TableView.m
//  报表
//
//  Created by lv on 15/11/5.
//  Copyright © 2015年 lv. All rights reserved.
//

#import "LvCurvesLine.h"
#define RGBA(R,G,B,A) [UIColor colorWithRed:R/255.0f green:G/255.0f blue:B/255.0f alpha:A]
#import "LvCurvesFill.h"
#import "UIButton+Lv.h"
#define DEF_WIDTH 2.0f

@interface LvCurvesLine ()
{
    LvCurvesFill *_curvesFill;
    UIView *_topView;
}
@end

@implementation LvCurvesLine



- (instancetype)initWithArrSell:(NSMutableArray *)arrSell arrTime:(NSMutableArray *)arrTime frame:(CGRect)frame lineColor:(NSArray *)arrLineColor lineWidth:(NSArray *)arrLineWidth bgColor:(NSArray *)arrBgColor
{
    self = [super initWithFrame:frame];
    if (self) {
       
        if (!arrLineColor)
        {
            NSMutableArray *arrLineColor=[NSMutableArray arrayWithCapacity:0];
            [arrSell enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [arrLineColor addObject:[UIColor blackColor]];
            }];
            self.arrLineColor=arrLineColor;
        }
        else
        {
            self.arrLineColor=arrLineColor;
        }
        
        
        if (!arrBgColor)
        {
//            NSMutableArray *arrBgColor=[NSMutableArray arrayWithCapacity:0];
//            [arrSell enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                [arrBgColor addObject:@[[UIColor clearColor]]];
//            }];
//            self.arrBgColor=arrBgColor;
            
            self.isHiddenFillView=NO;
        }
        else
        {
            self.isHiddenFillView=YES;
            self.arrBgColor=arrBgColor;
        }
        

        self.arrLineWidth=arrLineWidth;
        
        self.arrSell=arrSell;
        self.arrTime=arrTime;
    
        self.backgroundColor=[UIColor clearColor];
   
        self.leftDistance=0;
        self.maxSell=[self getMaxValues];
        self.layer.shouldRasterize = YES;
        
        self.distotion=15;
        self.arrBtnPoint=[NSMutableArray arrayWithCapacity:0];
        
    }
    return self;
}

-(void)setColumnWidth:(CGFloat)columnWidth
{
    if (columnWidth<=0)
    {
        if (self.arrSell.count>0)
        {
            NSArray *arrS=self.arrSell[0];
            self.columnWidth=(self.frame.size.width-2*self.leftDistance)/(arrS.count-1);
        }
    }
    else
    {
        _columnWidth=columnWidth;
    }
}


//-(void)setCoordinateYOver:(CGFloat)coordinateYOver
//{
//    if (coordinateYOver<=0)
//    {
//        _coordinateYOver=0.5*self.frame.size.height/(self.rowNumber+1);
//    }
//    else
//    {
//        _coordinateYOver=coordinateYOver;
//    }
//}

-(void)tapClick:(UITapGestureRecognizer *)tap
{
//    if (tap.state==UIGestureRecognizerStateEnded)
//    {
//        if ([self.delegate respondsToSelector:@selector(LvCurvesFill:clickFill:)])
//        {
//            [self.delegate LvCurvesFill:(LvCurvesFill *)tap.view clickFill:tap.view.tag-10000];
//        }
//    }
}

-(void)drawRect:(CGRect)rect
{
    self.backgroundColor=[UIColor clearColor];;
    [[UIColor whiteColor] setStroke];
    __block CGFloat curvesH=self.frame.size.height-self.coordinateYOver;
    __block UIButton *btnLayer=nil;
 
    
    if (!self.isHiddenFillView)
    {
        //下面的填充层
        [self.arrSell enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            _curvesFill=[[LvCurvesFill alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width,self.frame.size.height)];
            _curvesFill.userInteractionEnabled=YES;
            _curvesFill.arrSell=obj;
            _curvesFill.distotion=self.distotion;
            _curvesFill.columnWidth=self.columnWidth;
            _curvesFill.arrColors=self.arrBgColor[idx];
            _curvesFill.maxSell=self.maxSell;
            _curvesFill.rowNumber=self.rowNumber;
            _curvesFill.coordinateYOver=self.coordinateYOver;
            _curvesFill.leftDistance=self.leftDistance;
            _curvesFill.backgroundColor=[UIColor clearColor];
            _curvesFill.tag=10000+idx;
            [self insertSubview:_curvesFill atIndex:idx];
            
//            UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
//            [_curvesFill addGestureRecognizer:tap];
        }];
    }


    //曲线
    [self.arrSell enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger jdx, BOOL * _Nonnull stop) {

        NSArray *arr=obj;
        __block NSInteger tag=10000*(jdx+1);
        UIColor *color=self.arrLineColor[jdx];
        if (!color) {
            color=[UIColor whiteColor];
        }
        [color setStroke];
        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

            CGPoint point =CGPointMake(idx*self.columnWidth+self.leftDistance, self.frame.size.height-curvesH*([obj floatValue])/self.maxSell);
            CGFloat floatPW=[self.arrPointWidth[jdx] floatValue];
            UIButton *btnV=nil;
            if(!self.isHiddenPointValue)
            {
                UIButton *btnValue=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.columnWidth, 20)];
                btnValue.center=CGPointMake(point.x, point.y-10-floatPW/2);
                [btnValue setTitle:obj forState:UIControlStateNormal];
                [btnValue setTitleColor:self.arrPointValueFontColor?self.arrPointValueFontColor[jdx]:[UIColor blackColor] forState:UIControlStateNormal];
                btnValue.titleLabel.font=self.arrPointValueFont?self.arrPointValueFont[jdx]:[UIFont systemFontOfSize:13];
                btnValue.clipsToBounds=YES;
                btnValue.line=jdx;
                btnValue.point=idx;
                btnValue.fontSizeValue=btnValue.titleLabel.font.pointSize;
                btnValue.value=[obj floatValue];
                [btnValue addTarget:self action:@selector(btnPointClick:) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:btnValue];
                btnV=btnValue;
            }

            
            if(!self.isHiddenPoint)
            {
                UIButton *btnPoint=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, floatPW,  floatPW)];
                btnPoint.backgroundColor=self.arrPointBgColor?self.arrPointBgColor[jdx]:[UIColor blueColor];
                btnPoint.layer.cornerRadius= floatPW/2;
                btnPoint.center=point;
                btnPoint.tag=tag+idx;
                btnPoint.line=jdx;
                btnPoint.point=idx;
                btnPoint.value=[obj floatValue];
                btnPoint.btnPoint=btnV;
                btnPoint.fontSizeValue=btnV.titleLabel.font.pointSize;
                btnPoint.titleLabel.font=btnV.titleLabel.font;
                btnPoint.clipsToBounds=YES;
                [btnPoint addTarget:self action:@selector(btnPointClick:) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:btnPoint];
                [self.arrBtnPoint addObject:btnPoint];
                
                btnLayer=btnPoint;
            }


            
            CGPoint startPoint=point;
            CGPoint endtPoint=CGPointZero;
            if(idx<(arr.count-1))
            {
                endtPoint=CGPointMake((idx+1)*self.columnWidth+self.leftDistance, self.frame.size.height-curvesH*([arr[idx+1] floatValue])/self.maxSell);
            }
            else
            {
                endtPoint=startPoint;
            }
            
            CGPoint middlePoint=CGPointMake((startPoint.x+endtPoint.x)/2, (startPoint.y+endtPoint.y)/2);
            
            //画线
            UIBezierPath *ber=[UIBezierPath bezierPath];
            if (jdx>(_arrLineWidth.count-1))
            {
                 [ber setLineWidth:DEF_WIDTH];
                
            }
            else
            {
                 [ber setLineWidth:[self.arrLineWidth[jdx] floatValue]];
            }
           
            [ber moveToPoint:startPoint];
            [ber addQuadCurveToPoint:middlePoint controlPoint:CGPointMake(startPoint.x+self.distotion, startPoint.y)];
            [ber addQuadCurveToPoint:endtPoint controlPoint:CGPointMake(endtPoint.x-self.distotion, endtPoint.y)];
          
            [ber stroke];

        }];
    }];
}

-(void)btnPointClick:(UIButton *)sender
{
    if (sender.btnPoint)
    {
        sender.btnPoint.titleLabel.font=[UIFont systemFontOfSize:sender.btnPoint.titleLabel.font.pointSize==sender.fontSizeValue?(sender.titleLabel.font.pointSize+2):sender.fontSizeValue];
    }
    else
    {
       sender.titleLabel.font=[UIFont systemFontOfSize:sender.titleLabel.font.pointSize==sender.fontSizeValue?(sender.titleLabel.font.pointSize+2):sender.fontSizeValue];
    }
    
    if ([self.delegate respondsToSelector:@selector(LvCurvesLine:clickLine:clickPoint:value:)])
    {
        [self.delegate LvCurvesLine:self clickLine:sender.line clickPoint:sender.point value:sender.value];
    }
}

-(void)setBtnPointShowWithIndex:(NSInteger)index
{
    [self.arrBtnPoint enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn=obj;
        btn.hidden=YES;
        NSLog(@"btn.tag=%zd idx=%zd",btn.tag,index);
        if (btn.tag==(10000+index)||btn.tag==(20000+index))
        {
             btn.hidden=NO;
        }
    }];
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
