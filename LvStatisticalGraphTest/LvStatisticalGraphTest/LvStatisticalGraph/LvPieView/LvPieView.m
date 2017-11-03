//
//  LvCoverView.m
//  Statistics
//
//  Created by lv on 2016/11/11.
//  Copyright © 2016年 lv. All rights reserved.
//

#import "LvPieView.h"
#import "LvBezierPath.h"

@interface LvPieView ()
{
    NSMutableArray *_arrBezier;
    CGMutablePathRef pathRef;
    LvBezierPath *_bezier;
    BOOL _isOK;
    CGFloat _sumValue;
    NSInteger _selectTag;
 
}
@end

@implementation LvPieView

- (instancetype)initWithFrame:(CGRect)frame arrText:(NSMutableArray *)arrText arrValue:(NSMutableArray *)arrValue arrColor:(NSMutableArray *)arrColor
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _selectTag=-1;
        _sumValue=[[arrValue valueForKeyPath:@"@sum.floatValue"] floatValue];
        self.pieLineWidth=30;
        self.selectDistance=self.pieLineWidth/4;
        self.backgroundColor=[UIColor clearColor];
        
        
        _arrBezier=[NSMutableArray arrayWithCapacity:0];

        self.arrValue=arrValue;
        self.arrColor=arrColor;
        self.arrText=arrText;
        
        self.labText=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, 30)];
        self.labText.center=CGPointMake(frame.size.width/2, frame.size.height/2-10);
        self.labText.textAlignment=NSTextAlignmentCenter;
        self.labText.textColor=[[UIColor blackColor] colorWithAlphaComponent:0.8];
        [self addSubview:self.labText];
        
        self.labValue=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, 30)];
        self.labValue.center=CGPointMake(frame.size.width/2, frame.size.height/2+10);
        self.labValue.textAlignment=NSTextAlignmentCenter;
        self.labValue.font=[UIFont systemFontOfSize:13];
        self.labValue.textColor=[[UIColor blackColor] colorWithAlphaComponent:0.9];
        [self addSubview:self.labValue];
    }
    return self;
}

-(void)setPieLineWidth:(CGFloat)pieLineWidth
{
    if (pieLineWidth>0)
    {
        _pieLineWidth=pieLineWidth;
        
    }
}

-(void)setSelectIndex:(CGFloat)selectIndex
{
    if (selectIndex>=0)
    {
        _selectIndex=selectIndex;
        _selectTag=selectIndex;
    }
   
}

-(void)drawRect:(CGRect)rect
{
    __block CGFloat sum= [[self.arrValue valueForKeyPath:@"@sum.floatValue"] floatValue];
    __block CGFloat sumStart=0;
    [_arrBezier removeAllObjects];
    
    [self.arrValue enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIColor *colorSet=nil;
        if (self.arrColor.count>idx)
        {
            colorSet=self.arrColor[idx];
        }
        
        if (_selectTag==idx)
        {
            if (self.selectColor)
            {
                [self.selectColor set];
            }
            else
            {
                [colorSet set];
            }
            
        }
        else
        {
            [colorSet set];
        }
        NSNumber *num=obj;
        CGFloat angle=([num floatValue]/sum)*M_PI*2;
        
        CGFloat startAngle=sumStart+0.01;
        CGFloat endAngle=angle+sumStart-0.01;
        
        if (endAngle<startAngle)
        {
             endAngle=startAngle;
            startAngle=startAngle-0.001;
           
        }
        
    
        LvBezierPath *bezier=[[LvBezierPath alloc]init];
        bezier.myTag=100+idx;
        
        CGPoint pointCenter=CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        CGFloat r=self.frame.size.width>self.frame.size.height?self.frame.size.height/2:self.frame.size.width/2;
  
        CGFloat bR= r-self.pieLineWidth/2;
        bR=(idx==_selectTag?bR:(bR-self.selectDistance));
        bezier.startAngle=sumStart;
        bezier.myRadius=bR;
        bezier.myCenter=pointCenter;
        bezier.myStartAngle=startAngle ;
        bezier.myEndAngle=endAngle;
        bezier.myLineWidth=self.pieLineWidth;

        if (startAngle>M_PI*2)
        {
            startAngle=M_PI*2-0.001;
            endAngle=M_PI*2;
        }
        [bezier addArcWithCenter:pointCenter radius:bR startAngle:startAngle endAngle:endAngle clockwise:YES];
        bezier.lineWidth=self.pieLineWidth;
        bezier.lineCapStyle=kCGLineCapButt;
       
        
  
        [bezier stroke];
   
        [_arrBezier addObject:bezier];
        sumStart=sumStart+angle;
        
        if (_selectTag==idx)
        {
            bezier.isSelect=YES;
            _selectTag=-1;
            
            NSString *strText=@"";
            if (self.arrText.count>idx)
            {
                strText=self.arrText[idx];
            }
            
            self.labText.text=strText;
            self.labValue.text=[NSString stringWithFormat:@"%@ - %.2f%%",obj,([obj floatValue]/_sumValue)*100.0f];
        }
    }];
    

}

//所有的块变为非选中
-(void)setAllUnSelect
{
    self.labText.text=@"";
    self.labValue.text=@"";
    _selectTag=-1;
    [self setNeedsDisplay];
}


//回复到初始状态
-(void)pieViewReset
{
    
    _selectTag=_selectIndex;
    [self setNeedsDisplay];
}


-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    UITouch* touch = [touches anyObject];
    CGPoint point=[touch locationInView:self];
    
    __block BOOL isIn=NO;
    [_arrBezier enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        LvBezierPath *bezier=obj;
      
        if ([bezier isContainPoint:point])
        {
            isIn=YES;
            if ([self.delegate respondsToSelector:@selector(areaClick:)])
            {
                [self.delegate areaClick:bezier.myTag-100];
            }
            if (bezier.isSelect)
            {
                _selectTag=-1;
                self.labText.text=@"";
                self.labValue.text=@"";
            }
            else
            {
                _selectTag=bezier.myTag-100;
                
                NSString *strText=@"";
                if (self.arrText.count>idx)
                {
                    strText=self.arrText[idx];
                }
                
                self.labText.text=strText;
                self.labValue.text=[NSString stringWithFormat:@"%@ - %f%%",obj,([self.arrValue[idx] floatValue]/_sumValue)*100.0f];
            }
            
            [self setNeedsDisplay];
        }
    }];
    
    if (!isIn)
    {
        [self setAllUnSelect];
        
        if ([self.delegate respondsToSelector:@selector(outClick)])
        {
            [self.delegate outClick];
        }
    }
    

}
@end
