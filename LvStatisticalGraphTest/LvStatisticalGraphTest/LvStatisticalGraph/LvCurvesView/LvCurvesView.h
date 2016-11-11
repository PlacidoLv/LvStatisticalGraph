//
//  LvCurvesView.h
//  Statistics
//
//  Created by lv on 2016/11/8.
//  Copyright © 2016年 lv. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LvCurvesLine.h"
#import "LvCoordinateLine.h"


@class LvCurvesView;

@protocol LvCurvesViewDelegate <NSObject>

@optional


//-(void)LvCurvesFill:(LvCurvesFill *)LvCurvesFill clickFill:(NSInteger)tag;

//曲线定点和定点值点击事件
-(void)LvCurvesView:(LvCurvesView *)LvCurvesView clickLine:(NSInteger)line  clickPoint:(NSInteger )point value:(CGFloat)value;

@end


@interface LvCurvesView : UIView


@property(nonatomic,assign)id<LvCurvesViewDelegate>delegate;

@property(nonatomic,retain)LvCurvesLine *curvesLine;//曲线图部分
@property(nonatomic,retain)LvCoordinateLine *coordinateLine;//坐标线部分

@property(nonatomic,retain)NSArray *arrBgColor; //背景填充颜色 没有则默认不显示背景填充色
@property(nonatomic,retain)NSArray *arrLineColor;//曲线颜色
@property(nonatomic,retain)NSArray *arrLineWidth;//曲线宽度 默认1px
@property(nonatomic,retain)NSMutableArray *arrSell;//值
@property(nonatomic,retain)NSMutableArray *arrTime;//时间

//曲线定点设置
@property(nonatomic,retain)NSMutableArray *arrPointValueFont;//顶点值字体
@property(nonatomic,retain)NSMutableArray *arrPointValueFontColor;//顶点字体颜色
@property(nonatomic,retain)NSMutableArray *arrPointWidth;//顶点半径
@property(nonatomic,retain)NSMutableArray *arrPointBgColor;//定点背景颜色

//左侧分割线数值设置
@property(nonatomic,retain)UIColor *leftValueFontColor;//左侧数值字体颜色
@property(nonatomic,retain)UIFont *leftValueFont;//左侧数值字体
@property(nonatomic,retain)UIFont *leftValueOnFont;//左侧数值在横线上时字体
@property(nonatomic,retain)UIColor *leftValueOnFontColor;//左侧数值在横线上时字体颜色


@property(nonatomic,assign)CGFloat cureToTopDistance;//绘图部分距离顶部的距离，
@property(nonatomic,assign)CGFloat cureToLeftDistance;//绘图部分距离顶部的距离，
@property(nonatomic,assign)CGFloat cureToRightDistance;//绘图部分距离顶部的距离，
@property(nonatomic,assign)CGFloat cureToBottomDistance;//绘图部分距离顶部的距离，

//下面时间lab设置
@property(nonatomic,assign)CGFloat timeLabHight;//下面时间的高度
@property(nonatomic,retain)UIColor *timeLabFontColor;//下面时间字体颜色
@property(nonatomic,retain)UIFont *timeLabFont;//下面时间字体


@property(nonatomic,assign)CGFloat distotion;//扭曲度扭曲度 值越大越弯 为0则是折线图
@property(nonatomic,assign)CGFloat columnWidth;//列宽
@property(nonatomic,assign)NSInteger rowNumber;//虚线条数 
@property(nonatomic,assign)CGFloat maxSell;//Y轴最大值

@property(nonatomic,assign)CGFloat leftDistance;//曲线图距离左坐标线边距
@property(nonatomic,assign)CGFloat rightDistance;//曲线图距离右坐标线边距
//@property(nonatomic,assign)CGFloat buttomToCoordinateXDistance;//曲线图距离X坐标线距离

//分割线设置
@property(nonatomic,assign)CGFloat cuttingLineWidth;//分割线宽度
@property(nonatomic,retain)UIColor *cuttingLineColor;//分割线颜色

//坐标线设置
@property(nonatomic,assign)CGFloat coordinateLineWidth;//坐标线宽度
@property(nonatomic,retain)UIColor *coordinateLineColor;//坐标线颜色
@property(nonatomic,assign)CGFloat coordinateYOver;//Y轴超出最上面的分割线的距离
@property(nonatomic,assign)CGFloat coordinateValueWidth;//左边数值label宽度



@property(nonatomic,assign)BOOL isCoordinateValueCanMove;//左边数值是否可以跟随统计图移动
@property(nonatomic,assign)BOOL isCoordinateLineCanMove;//左边线是否可以跟随统计图移动
@property(nonatomic,assign)BOOL isHiddenPoint;//是否隐藏顶点
@property(nonatomic,assign)BOOL isHiddenPointValue;//是否隐藏顶点值
@property(nonatomic,assign)BOOL isHiddenFillView;//是否隐藏填充层
@property(nonatomic,assign)BOOL isHiddenCuttingLine;//是否隐藏分割线
@property(nonatomic,assign)BOOL isHiddenCoordinateLine;//是否隐藏坐标线
@property(nonatomic,assign)BOOL isHiddenCoordinateValue;//是否隐藏坐标值
@property(nonatomic,assign)BOOL isHiddenCoordinateTime;//是否隐藏坐标时间
@property(nonatomic,retain)UIScrollView *scrollView;//

- (instancetype)initWithArrSell:(NSMutableArray *)arrSell arrTime:(NSMutableArray *)arrTime frame:(CGRect)frame lineColor:(NSArray *)arrLineColor lineWidth:(NSArray *)arrLineWidth bgColor:(NSArray *)arrBgColor;
@end
