//
//  JSAttributeLabel.h
//  MiyueiOS
//
//  Created by Cary on 16/9/27.
//  Copyright © 2016年 com.myjhealth. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JSAttributeLabel : UILabel

@property(nonatomic, strong)NSString *labelText;
//文字对其方式
@property(nonatomic, assign)NSTextAlignment alignment;

- (instancetype)initWithFrame:(CGRect)frame labelFont:(UIFont *)labelFont lineSpace:(CGFloat)lineSpace maxWidth:(CGFloat)maxWidth;

- (CGSize)getLabelSize;

+ (CGSize)getLabelSizeWithText:(NSString *)labelText labelFont:(UIFont *)labelFont lineSpace:(CGFloat)lineSpace maxWidth:(CGFloat)maxWidth;

@end
