//
//  LvBezierPath.h
//  Statistics
//
//  Created by lv on 2016/11/11.
//  Copyright © 2016年 lv. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LvBezierPath : UIBezierPath
@property(nonatomic)CGPoint myCenter;
@property(nonatomic,assign)CGFloat myRadius;
@property(nonatomic,assign)CGFloat myStartAngle;
@property(nonatomic,assign)CGFloat myEndAngle;
@property(nonatomic,assign)CGFloat myLineWidth;
@property(nonatomic,assign)NSInteger myTag;
@property(nonatomic,assign)CGFloat startAngle;
@property(nonatomic,assign)BOOL isSelect;
-(BOOL)isContainPoint:(CGPoint)point;

@end
