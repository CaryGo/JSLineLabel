//
//  JSLineLabel.h
//  MiyueiOS
//
//  Created by Cary on 16/9/22.
//  Copyright © 2016年 com.myjhealth. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef struct JSLineVerticalEdgeInsets {
    CGFloat top, bottom;
} JSLineVerticalEdgeInsets;
static inline JSLineVerticalEdgeInsets JSLineVerticalEdgeInsetsMake (CGFloat top, CGFloat bottom) {
    JSLineVerticalEdgeInsets edgeInsets = {top, bottom};
    return edgeInsets;
}

/**
 枚举
 */
typedef enum
{
    VerticalAlignmentTop = 0, // 上方default
    VerticalAlignmentMiddle,//中间
    VerticalAlignmentBottom,//垂直在底部
    VerticalAlignmentCustom//自定义  结合 JSLineVerticalEdgeInsets属性使用
} JSLineVerticalAlignment;


@interface JSLineLabel : UILabel
{
@private
    JSLineVerticalAlignment _verticalAlignment;
}

@property (nonatomic) JSLineVerticalAlignment verticalAlignment;
@property (nonatomic, readwrite) JSLineVerticalEdgeInsets verticalInsets;
@property(nonatomic, strong)NSString *labelText;

- (CGSize)getLabelSize;
- (CGFloat)getLines;

- (instancetype)initWithFrame:(CGRect)frame labelFont:(UIFont *)labelFont lineHeight:(CGFloat)lineHeight maxWidth:(CGFloat)maxWidth;


- (void)setBaseLineWithColor:(UIColor *)color height:(CGFloat)height;

/**
 计算富文本的高度
 
 @param labelText          文本
 @param labelFont          文本的字体大小
 @param lineHeight         每一行的高度
 @param maxWidth           每一行的最大宽度
 @param verticalEdgeInsets 设置垂直方向上label的偏移（由于使用boundingRectWithSize:方法计算出的size是纯文字的size 所以需要设置该属性，注意使用该属性）

 @return 计算后的大小
 */
+ (CGSize)getLabelSizeWithText:(NSString *)labelText labelFont:(UIFont *)labelFont lineHeight:(CGFloat)lineHeight maxWidth:(CGFloat)maxWidth verticalEdgeInsets:(JSLineVerticalEdgeInsets)verticalEdgeInsets;

@end
