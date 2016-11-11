//
//  LvCoordinateLine.h
//  Statistics
//
//  Created by lv on 2016/11/8.
//  Copyright © 2016年 lv. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LvCoordinateLine : UIView

@property(nonatomic,assign)CGFloat coordinateYOver;//Y轴超出最上面的分割线的距离
@property(nonatomic,assign)NSInteger rowNumber;//虚线条数
@property(nonatomic,retain)NSMutableArray *arrSell;
@property(nonatomic,retain)NSMutableArray *arrTime;
@property(nonatomic,retain)NSMutableArray *arrBtnPoint;
@property(nonatomic,retain)NSArray *arrColors;
@property(nonatomic,retain)NSArray *arrLineColors;

@property(nonatomic,assign)CGFloat cuttingLineWidth;//分割线宽度
@property(nonatomic,retain)UIColor *cuttingLineColor;//分割线颜色

@property(nonatomic,assign)CGFloat coordinateLineWidth;//坐标线宽度
@property(nonatomic,retain)UIColor *coordinateLineColor;//坐标线颜色

@property(nonatomic,assign)CGFloat maxSell;

@property(nonatomic,assign)CGFloat distotion;//扭曲度
@property(nonatomic,assign)CGFloat columnWidth;
@property(nonatomic,assign)CGFloat leftDistance;
@property(nonatomic,assign)CGFloat rightDistanceBg;
@property(nonatomic,assign)BOOL isShowLeftValue;
@property(nonatomic,assign)CGFloat leftDistanceBg;

@property(nonatomic,assign)BOOL isHiddenAllBtn;
@property(nonatomic,assign)BOOL isHiddenCuttingLine;//是否隐藏分割线
@property(nonatomic,assign)BOOL isHiddenCoordinateLine;//是否隐藏坐标

@end
