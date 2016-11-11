//
//  LvCoordinateLine.m
//  Statistics
//
//  Created by lv on 2016/11/8.
//  Copyright © 2016年 lv. All rights reserved.
//

#import "LvCoordinateLine.h"
#define CUTTINGLINT_WIDTH 1.0f //分割线默认宽度
#define COORDINATELINE_WIDTH 1.0f //坐标线默认宽度
#define CUTTINGLINT_COLOR [UIColor redColor] //分割线默认颜色
#define COORDINATELINE_COLOR [UIColor redColor] //坐标线默认探颜色
@implementation LvCoordinateLine

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
        self.coordinateLineWidth=1;
        self.coordinateLineColor=[UIColor whiteColor];
        
        self.cuttingLineWidth=1;
        self.cuttingLineColor=[UIColor whiteColor];
    }
    return self;
}

-(void)setCuttingLineColor:(UIColor *)cuttingLineColor
{
    if(_cuttingLineColor!=cuttingLineColor)
    {
        if (cuttingLineColor)
        {
            _cuttingLineColor=cuttingLineColor;
        }
        else
        {
            _cuttingLineColor=CUTTINGLINT_COLOR;
        }
    }
}

-(void)setCoordinateLineColor:(UIColor *)coordinateLineColor
{
    if (_coordinateLineColor!=coordinateLineColor)
    {
        if (coordinateLineColor)
        {
            _coordinateLineColor=coordinateLineColor;
        }
        else
        {
            _coordinateLineColor=COORDINATELINE_COLOR;
        }
    }
}

-(void)setCoordinateLineWidth:(CGFloat)coordinateLineWidth
{
    if (coordinateLineWidth<=0)
    {
        _coordinateLineWidth=COORDINATELINE_WIDTH;
    }
}

-(void)setCuttingLineWidth:(CGFloat)cuttingLineWidth
{
    if (cuttingLineWidth<=0)
    {
        _cuttingLineWidth=CUTTINGLINT_WIDTH;
    }
}

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    self.backgroundColor=[UIColor clearColor];
    
    [self.cuttingLineColor setStroke];
    
    __block CGFloat rowH=(self.frame.size.height-self.coordinateYOver)/(self.rowNumber);
    if (!self.isHiddenCuttingLine)
    {
        for (int i=0; i<(self.rowNumber); i++)
        {
            //虚线
            UIBezierPath *berLine=[UIBezierPath bezierPath];
            CGFloat dashArray[3];
            dashArray[0] = 8;
            dashArray[1] = 8;
            dashArray[2] = 8;
            [berLine setLineWidth:self.cuttingLineWidth];
            [berLine setLineDash:dashArray count:3 phase:1];
            [berLine setLineWidth:0.5];
            [berLine moveToPoint:CGPointMake(self.leftDistanceBg, rowH*i+self.coordinateYOver)];
            [berLine addLineToPoint:CGPointMake(self.frame.size.width-self.rightDistanceBg, rowH*i+self.coordinateYOver)];
            [berLine stroke];

        }
    }

    
    if (!self.isHiddenCoordinateLine)
    {
        //  x，y轴
        [self.coordinateLineColor set];
        
        UIBezierPath *berLine=[UIBezierPath bezierPath];
        [berLine moveToPoint:CGPointMake(self.leftDistance, self.frame.size.height)];
        [berLine addLineToPoint:CGPointMake(0, 0)];
        [berLine moveToPoint:CGPointMake(self.leftDistance, self.frame.size.height)];
        [berLine addLineToPoint:CGPointMake(self.frame.size.width-self.rightDistanceBg, self.frame.size.height)];
        [berLine setLineWidth:self.coordinateLineWidth];
        
        [berLine stroke];
    }


}

@end
