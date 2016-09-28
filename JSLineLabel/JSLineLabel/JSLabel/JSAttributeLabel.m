//
//  JSAttributeLabel.m
//  MiyueiOS
//
//  Created by Cary on 16/9/27.
//  Copyright © 2016年 com.myjhealth. All rights reserved.
//

#import "JSAttributeLabel.h"

@interface JSAttributeLabel ()

@property(nonatomic) UIFont *labelFont;
@property(nonatomic, assign)CGFloat lineSpace;
@property(nonatomic, assign)CGFloat maxWidth;

@end

@implementation JSAttributeLabel

- (instancetype)initWithFrame:(CGRect)frame labelFont:(UIFont *)labelFont lineSpace:(CGFloat)lineSpace maxWidth:(CGFloat)maxWidth{
    if (self = [super initWithFrame:frame]) {
        _labelFont = labelFont;
        _lineSpace = lineSpace;
        _maxWidth = maxWidth;
        _alignment = NSTextAlignmentJustified;
        self.numberOfLines = 0;
        self.font = labelFont;
    }
    return self;
}

- (void)setAlignment:(NSTextAlignment)alignment{
    _alignment = alignment;
    if (_labelText) {
        [self setLabelText:_labelText];
    }
}

- (void)setLabelText:(NSString *)labelText{
    _labelText = labelText;
    if (!_labelText) {
        return;
    }
    //设定内容样式
    NSMutableAttributedString * attributedString =
    [[NSMutableAttributedString alloc] initWithString:labelText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:self.lineSpace];
    paragraphStyle.alignment = _alignment;
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          paragraphStyle, NSParagraphStyleAttributeName ,
                          [NSNumber numberWithFloat:0],NSBaselineOffsetAttributeName,
                          nil];
    [attributedString addAttributes:dict range:NSMakeRange(0 , [attributedString length])];
    [self setAttributedText:attributedString];
    [self sizeToFit];
    attributedString = nil;
    paragraphStyle = nil;
    [self setNeedsDisplay];
}

-(void)drawTextInRect:(CGRect)requestedRect {
    CGRect actualRect = [self textRectForBounds:requestedRect limitedToNumberOfLines:self.numberOfLines];
    [super drawTextInRect:actualRect];
}
- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines {
    CGRect textRect = [super textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
    textRect.origin.y = bounds.origin.y;
    return textRect;
}

- (CGSize)getLabelSize{
    if (!_labelText) {
        return CGSizeZero;
    }
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:self.lineSpace];
    
    CGSize size = [_labelText boundingRectWithSize:CGSizeMake(_maxWidth, 0) options:NSStringDrawingUsesLineFragmentOrigin
                                        attributes:@{
                                                     NSFontAttributeName:_labelFont,
                                                     NSParagraphStyleAttributeName:paragraphStyle
                                                     }
                                           context:nil].size;
    paragraphStyle = nil;
    CGSize textSize = CGSizeMake(ceil(size.width),ceil(size.height));
    return textSize;
}

- (void)layoutSubviews{
    [super layoutSubviews];
}
- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
}

+ (CGSize)getLabelSizeWithText:(NSString *)labelText labelFont:(UIFont *)labelFont lineSpace:(CGFloat)lineSpace maxWidth:(CGFloat)maxWidth{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    CGSize size = [labelText boundingRectWithSize:CGSizeMake(maxWidth, 0) options:NSStringDrawingUsesLineFragmentOrigin
                                       attributes:@{
                                                    NSFontAttributeName:labelFont,
                                                    NSParagraphStyleAttributeName:paragraphStyle
                                                    }
                                          context:nil].size;
    paragraphStyle = nil;
    CGSize textSize = CGSizeMake(ceil(size.width),ceil(size.height));
    return textSize;
}

@end
