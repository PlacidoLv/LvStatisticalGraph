//
//  TableView.h
//  报表
//
//  Created by lv on 15/11/5.
//  Copyright © 2015年 lv. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LvCurvesLine;
@class LvCurvesFill;

@protocol LvCurvesLineDelegate <NSObject>

@optional
//-(void)LvCurvesFill:(LvCurvesFill *)LvCurvesFill clickFill:(NSInteger)tag;
-(void)LvCurvesLine:(LvCurvesLine *)lvCurvesLine clickLine:(NSInteger)line  clickPoint:(NSInteger )point value:(CGFloat)value;

@end

@interface LvCurvesLine : UIView
@property(nonatomic,retain)NSMutableArray *arrBtnPoint;

@property(nonatomic,retain)NSArray *arrBgColor; //背景填充颜色 没有则默认不显示背景填充色
@property(nonatomic,retain)NSArray *arrLineColor;//曲线颜色
@property(nonatomic,retain)NSArray *arrLineWidth;//曲线宽度 默认1px
@property(nonatomic,retain)NSMutableArray *arrSell;//值
@property(nonatomic,retain)NSMutableArray *arrTime;//时间

@property(nonatomic,assign)NSInteger rowNumber;//虚线条数
@property(nonatomic,assign)CGFloat distotion;//扭曲度
@property(nonatomic,assign)CGFloat columnWidth;//列宽
@property(nonatomic,assign)CGFloat maxSell;//最大值
@property(nonatomic,assign)CGFloat leftDistance;//距坐标系左边距
@property(nonatomic,assign)CGFloat rightDistance;//距坐标系右边距
@property(nonatomic,assign)CGFloat coordinateYOver;//Y轴超出最上面的分割线的距离

@property(nonatomic,retain)NSMutableArray *arrPointValueFont;//顶点值字体
@property(nonatomic,retain)NSMutableArray *arrPointValueFontColor;//顶点字体颜色
@property(nonatomic,retain)NSMutableArray *arrPointWidth;//顶点半径
@property(nonatomic,retain)NSMutableArray *arrPointBgColor;//定点背景颜色

@property(nonatomic,assign)BOOL isHiddenPoint;//是否隐藏顶点
@property(nonatomic,assign)BOOL isHiddenPointValue;//是否隐藏顶点值
@property(nonatomic,assign)BOOL isHiddenFillView;//是否隐藏填充层

@property(nonatomic,assign)id<LvCurvesLineDelegate>delegate;


-(void)setBtnPointShowWithIndex:(NSInteger)idx;
- (instancetype)initWithArrSell:(NSMutableArray *)arrSell arrTime:(NSMutableArray *)arrTime frame:(CGRect)frame lineColor:(NSArray *)arrLineColor lineWidth:(NSArray *)arrLineWidth bgColor:(NSArray *)arrBgColor;
//- (instancetype)initWithArrValues:(NSMutableArray *)arrValues arrTime:(NSMutableArray *)arrTime frame:(CGRect)frame lineColors:(NSArray *)arrLineColor lineWidths:(NSArray *)arrLineWidth bgColors:(NSArray *)arrBgColors;
@end
