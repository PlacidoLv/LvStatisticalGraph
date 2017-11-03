//
//  LvBezierPath.m
//  Statistics
//
//  Created by lv on 2016/11/11.
//  Copyright © 2016年 lv. All rights reserved.
//

#import "LvBezierPath.h"

@implementation LvBezierPath

+(instancetype)bezierPath
{
    return [super bezierPath];
}


-(BOOL)isContainPoint:(CGPoint)point
{
    CGFloat distance=sqrtf((point.x-self.myCenter.x)*(point.x-self.myCenter.x)+(point.y-self.myCenter.y)*(point.y-self.myCenter.y));
    CGFloat a=asinf((point.y-self.myCenter.y)/distance);
    if (point.x>self.myCenter.x&&point.y>self.myCenter.y)
    {
        a=asinf((point.y-self.myCenter.y)/distance);
    }
    if (point.x<self.myCenter.x&&point.y>self.myCenter.y)
    {
        a=M_PI-asinf((point.y-self.myCenter.y)/distance);
    }
    if (point.x<self.myCenter.x&&point.y<self.myCenter.y)
    {
        a=M_PI+asinf((self.myCenter.y-point.y)/distance);
    }
    if (point.x>self.myCenter.x&&point.y<self.myCenter.y)
    {
        a=M_PI*2-asinf((self.myCenter.y-point.y)/distance);
    }

    if (distance<self.myRadius+self.myLineWidth/2&&distance>self.myRadius-self.myLineWidth/2)
    {
        if (a>self.myStartAngle&&a<self.myEndAngle)
        {
            return YES;
        }
        
        if (a>self.myStartAngle&&a<self.myEndAngle)
        {
            return YES;
        }
    }
    else
    {
        
    }
    
    return NO;
}


-(void)setmyTag:(NSInteger)myTag
{
    _myTag=myTag;
}


@end
