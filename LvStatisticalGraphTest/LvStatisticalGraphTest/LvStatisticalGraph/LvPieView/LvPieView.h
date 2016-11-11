//
//  LvCoverView.h
//  Statistics
//
//  Created by lv on 2016/11/11.
//  Copyright © 2016年 lv. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PieLineClickDelegate <NSObject>

@optional
-(void)areaClick:(NSInteger)tag;
-(void)outClick;
@end


@interface LvPieView : UIView

@property(nonatomic,assign)CGFloat pieLineWidth;//饼图的圈宽度

@property(nonatomic,retain)NSMutableArray *arrValue;
@property(nonatomic,retain)NSMutableArray *arrText;
@property(nonatomic,retain)NSMutableArray *arrColor;
@property(nonatomic,assign)CGFloat selectIndex;
@property(nonatomic,assign)CGFloat selectDistance;
@property(nonatomic,retain)UIColor *selectColor;

@property(nonatomic,retain)UILabel *labText;
@property(nonatomic,retain)UILabel *labValue;
@property(nonatomic,assign)id<PieLineClickDelegate>delegate;

- (instancetype)initWithFrame:(CGRect)frame arrText:(NSMutableArray *)arrText arrValue:(NSMutableArray *)arrValue arrColor:(NSMutableArray *)arrColor;

@end
