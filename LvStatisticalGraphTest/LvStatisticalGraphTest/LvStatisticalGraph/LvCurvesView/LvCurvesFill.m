//
//  LineGradientBg.m
//  PDF
//
//  Created by lv on 15/12/9.
//  Copyright © 2015年 lv. All rights reserved.
//

#import "LvCurvesFill.h"
#define RGBA(R,G,B,A) [UIColor colorWithRed:R/255.0f green:G/255.0f blue:B/255.0f alpha:A]

@implementation LvCurvesFill

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       // self.distotion=20.0;
        self.arrBtnPoint=[NSMutableArray arrayWithCapacity:0];
        self.backgroundColor=[UIColor clearColor];
    }
    return self;
}

-(void)setCoordinateYOver:(CGFloat)coordinateYOver
{
    if (coordinateYOver<=0)
    {
        _coordinateYOver=0.5*self.frame.size.height/(self.rowNumber+1);
    }
    else
    {
        _coordinateYOver=coordinateYOver;
    }
}

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    __block CGFloat curvesH=self.frame.size.height-self.coordinateYOver;
    __block UIButton *btnLayer=nil;

    CGMutablePathRef aPath=CGPathCreateMutable();
    [self.arrSell enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [[UIColor yellowColor] setStroke];
        CGPoint point =CGPointMake(idx*self.columnWidth+self.leftDistance, self.frame.size.height-curvesH*([obj floatValue])/self.maxSell);
        CGPoint startPoint=point;
        CGPoint endtPoint=CGPointZero;
        if(idx<(self.arrSell.count-1))
        {
            endtPoint=CGPointMake((idx+1)*self.columnWidth+self.leftDistance, self.frame.size.height-curvesH*([_arrSell[idx+1] floatValue])/self.maxSell);
        }
        else
        {
            endtPoint=startPoint;
        }
        
        CGPoint middlePoint=CGPointMake((startPoint.x+endtPoint.x)/2, (startPoint.y+endtPoint.y)/2);
        
        if (idx==0)
        {
            CGPathMoveToPoint(aPath, nil, startPoint.x, startPoint.y);
        }
        
        CGPathAddQuadCurveToPoint(aPath, 0, startPoint.x+self.distotion, startPoint.y, middlePoint.x, middlePoint.y);
        CGPathAddQuadCurveToPoint(aPath, 0, endtPoint.x-self.distotion, endtPoint.y, endtPoint.x, endtPoint.y);

    }];
    
    
    NSMutableArray *arrColor=[NSMutableArray arrayWithCapacity:0];
    [self.arrColors enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIColor *color=obj;
        [arrColor addObject:(id)(color.CGColor)];
    }];
    
    //渐变背景
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.position = CGPointMake(0, 0);
    layer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    layer.colors =arrColor;
    layer.startPoint = CGPointMake(0, 0);
    layer.endPoint  = CGPointMake(1, 1);
    
    
    CGPoint pointStart =CGPointMake(self.leftDistance, self.frame.size.height-curvesH*([_arrSell[0] floatValue])/self.maxSell);
    CGPoint pointEnd =CGPointMake((self.arrSell.count-1)*self.columnWidth+self.leftDistance, curvesH*([_arrSell[self.arrSell.count-1] floatValue])/self.maxSell);
    CGPathAddLineToPoint(aPath, nil, pointEnd.x, self.frame.size.height);
    CGPathAddLineToPoint(aPath, nil, pointStart.x, self.frame.size.height);
    CGPathAddLineToPoint(aPath, nil, pointStart.x,pointStart.y);
    
    CAShapeLayer * lay = [CAShapeLayer layer];
    lay.frame         = self.bounds;                // 与showView的frame一致
    lay.strokeColor   = [UIColor clearColor].CGColor;   // 边缘线的颜色
    lay.lineCap       = kCALineCapRound;               // 边缘线的类型
    lay.path          = aPath;                    // 从贝塞尔曲线获取到形状
    lay.lineWidth     = 3.5f;                           // 线条宽度
    lay.strokeStart   = 0.0f;
    lay.strokeEnd     = 1.0f;
    [self.layer insertSublayer:layer  below:btnLayer.layer];
    [self.layer setMask:lay];
}



@end
