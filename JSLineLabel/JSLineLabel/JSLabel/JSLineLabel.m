//
//  JSLineLabel.m
//  MiyueiOS
//
//  Created by Cary on 16/9/22.
//  Copyright © 2016年 com.myjhealth. All rights reserved.
//

#import "JSLineLabel.h"

@interface JSLineLabel ()

@property(nonatomic) UIFont *labelFont;
@property(nonatomic, assign)CGFloat lineHeight;
@property(nonatomic, assign)CGFloat maxWidth;

@property(nonatomic, assign)CGSize labelSize;

//base line
@property(nonatomic, assign)BOOL isDrawLine;
@property(nonatomic, strong)UIColor *baseLineColor;
@property(nonatomic, assign)CGFloat baseLineHeight;

@end

@implementation JSLineLabel

- (instancetype)initWithFrame:(CGRect)frame labelFont:(UIFont *)labelFont lineHeight:(CGFloat)lineHeight maxWidth:(CGFloat)maxWidth{
    if (self = [super initWithFrame:frame]) {
        _verticalAlignment = VerticalAlignmentMiddle;
        _labelFont = labelFont;
        _lineHeight = lineHeight;
        _maxWidth = maxWidth;
        self.numberOfLines = 0;
        self.font = labelFont;
    }
    return self;
}

- (void)setLabelText:(NSString *)labelText{
    _labelText = labelText;
    if (!_labelText) {
        return;
    }
    //设定内容样式
    NSMutableAttributedString * attributedString =
    [[NSMutableAttributedString alloc] initWithString:_labelText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    CGFloat lineSpace = _lineHeight - _labelFont.lineHeight;
    [paragraphStyle setLineSpacing:lineSpace];
    paragraphStyle.alignment = NSTextAlignmentJustified;
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          paragraphStyle, NSParagraphStyleAttributeName ,
                          [NSNumber numberWithFloat:0],NSBaselineOffsetAttributeName,
                          nil];
    [attributedString addAttributes:dict range:NSMakeRange(0 , [attributedString length])];
    [self setAttributedText:attributedString];
    [self sizeToFit];
    attributedString = nil;
    paragraphStyle = nil;
    [self getLines];
    [self setNeedsDisplay];
}

- (void)layoutSubviews{
    [super layoutSubviews];
}

- (void)setVerticalAlignment:(JSLineVerticalAlignment)verticalAlignment {
    _verticalAlignment = verticalAlignment;
    [self setNeedsDisplay];
}
- (void)setVerticalInsets:(JSLineVerticalEdgeInsets)verticalInsets{
    _verticalInsets = verticalInsets;
    [self setNeedsDisplay];
}

- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines {
    CGRect textRect = [super textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
    switch (self.verticalAlignment) {
        case VerticalAlignmentTop:
            textRect.origin.y = bounds.origin.y;
            break;
        case VerticalAlignmentBottom:
            textRect.origin.y = bounds.origin.y + bounds.size.height - textRect.size.height;
            break;
        case VerticalAlignmentCustom:
            textRect.origin.y = bounds.origin.y + _verticalInsets.top;
            break;
        case VerticalAlignmentMiddle:
            // Fall through.
        default:
            textRect.origin.y = bounds.origin.y + (bounds.size.height - textRect.size.height) / 2.0;
    }
    return textRect;
}

-(void)drawTextInRect:(CGRect)requestedRect {
    CGRect actualRect = [self textRectForBounds:requestedRect limitedToNumberOfLines:self.numberOfLines];
    [super drawTextInRect:actualRect];
}
- (void)setBaseLineWithColor:(UIColor *)color height:(CGFloat)height{
    self.isDrawLine = YES;
    self.baseLineColor = color;
    self.baseLineHeight = height;
    [self setNeedsDisplay];
}
- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    if (self.isDrawLine) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
        CGContextFillRect(context, rect);
        
        for (int i=0; i<[self getLines]; i++) {
            CGContextSetStrokeColorWithColor(context, self.baseLineColor.CGColor);
            CGContextStrokeRect(context, CGRectMake(0 , _lineHeight*(i+1)-1, rect.size.width, self.baseLineHeight));
        }
    }
}

- (CGSize)getLabelSize{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    CGFloat lineSpace = _lineHeight - _labelFont.lineHeight;
    [paragraphStyle setLineSpacing:lineSpace];
    
    CGSize size = [_labelText boundingRectWithSize:CGSizeMake(_maxWidth, 0) options:NSStringDrawingUsesLineFragmentOrigin
                                       attributes:@{
                                                    NSFontAttributeName:_labelFont,
                                                    NSParagraphStyleAttributeName:paragraphStyle
                                                    }
                                          context:nil].size;
    paragraphStyle = nil;
    if (size.height<=_lineHeight) {
        size.height = _lineHeight;
    }else{
        NSInteger lines = ceil(size.height/_lineHeight);
        size.height = _lineHeight*lines;
    }
    _labelSize = size;
    return size;
}
- (CGFloat)getLines{
    CGSize size = [self getLabelSize];
    NSInteger lines = (NSInteger)(size.height/_lineHeight);
    if (lines<=1) {
        _verticalAlignment = VerticalAlignmentMiddle;
    }
    return lines;
}

+ (CGSize)getLabelSizeWithText:(NSString *)labelText labelFont:(UIFont *)labelFont lineHeight:(CGFloat)lineHeight maxWidth:(CGFloat)maxWidth verticalEdgeInsets:(JSLineVerticalEdgeInsets)verticalEdgeInsets{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    CGFloat lineSpace = lineHeight - labelFont.lineHeight;
    [paragraphStyle setLineSpacing:lineSpace];
    
    CGSize size = [labelText boundingRectWithSize:CGSizeMake(maxWidth, 0) options:NSStringDrawingUsesLineFragmentOrigin
                                        attributes:@{
                                                     NSFontAttributeName:labelFont,
                                                     NSParagraphStyleAttributeName:paragraphStyle
                                                     }
                                           context:nil].size;
    paragraphStyle = nil;
    NSInteger lines = ceil(size.height/lineHeight);
    if (lines<=1) {
        return CGSizeMake(size.width, lineHeight);
    }
    return CGSizeMake(size.width, lineHeight*lines);
}

@end
