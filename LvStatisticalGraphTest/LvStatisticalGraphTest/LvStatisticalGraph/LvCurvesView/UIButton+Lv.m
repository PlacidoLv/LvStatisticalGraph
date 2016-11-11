//
//  UIButton+Lv.m
//  sjsd
//
//  Created by lv on 16/2/16.
//  Copyright © 2016年 lv. All rights reserved.
//

#import "UIButton+Lv.h"
#import <objc/runtime.h>


@implementation UIButton (Lv)


static char *linekey = "line";
static char *pointkey = "point";
static char *valuekey = "value";
static char *fontSizeValuekey = "fontSizeValue";
static char *btnPointkey = "btnPoint";

-(UIButton *)btnPoint
{
    return objc_getAssociatedObject(self, btnPointkey);
}

-(void)setBtnPoint:(UIButton *)btnPoint
{
    objc_setAssociatedObject(self, btnPointkey, btnPoint, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


-(NSInteger)line
{
    return [objc_getAssociatedObject(self, linekey) intValue];
}


-(void)setLine:(NSInteger)line
{
    NSNumber *number= [[NSNumber alloc] initWithInteger:line];
    objc_setAssociatedObject(self, linekey, number, OBJC_ASSOCIATION_COPY);
    
}

-(NSInteger)point
{
    return [objc_getAssociatedObject(self, pointkey) intValue];
}


-(void)setPoint:(NSInteger)point
{
    NSNumber *number= [[NSNumber alloc] initWithInteger:point];
    objc_setAssociatedObject(self, pointkey, number, OBJC_ASSOCIATION_COPY);
}

-(CGFloat)value
{
    return [objc_getAssociatedObject(self, valuekey) intValue];
}


-(void)setValue:(CGFloat)value
{
    NSNumber *number= [[NSNumber alloc] initWithInteger:value];
    objc_setAssociatedObject(self, valuekey, number, OBJC_ASSOCIATION_COPY);
    
}

-(CGFloat)fontSizeValue
{
    return [objc_getAssociatedObject(self, fontSizeValuekey) intValue];
}


-(void)setFontSizeValue:(CGFloat)fontSizeValue
{
    NSNumber *number= [[NSNumber alloc] initWithInteger:fontSizeValue];
    objc_setAssociatedObject(self, fontSizeValuekey, number, OBJC_ASSOCIATION_COPY);
    
}

@end
