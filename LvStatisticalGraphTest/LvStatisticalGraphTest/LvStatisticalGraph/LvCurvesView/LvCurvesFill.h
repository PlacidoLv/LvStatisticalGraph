//
//  LineGradientBg.h
//  PDF
//
//  Created by lv on 15/12/9.
//  Copyright © 2015年 lv. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LvCurvesFill : UIView

@property(nonatomic,retain)NSMutableArray *arrColors;
@property(nonatomic,retain)NSMutableArray *arrBtnPoint;
@property(nonatomic,retain)NSArray *arrSell;
@property(nonatomic,retain)NSMutableArray *arrTime;
@property(nonatomic,assign)CGFloat coordinateYOver;//Y轴超出最上面的分割线的距离
@property(nonatomic,assign)NSInteger rowNumber;//虚线条数
@property(nonatomic,assign)CGFloat distotion;//扭曲度
@property(nonatomic,assign)CGFloat columnWidth;
@property(nonatomic,assign)CGFloat maxSell;
@property(nonatomic,assign)CGFloat leftDistance;
@end
