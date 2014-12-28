//
//  JSQAniwaysMediaItem.m
//  JSQMessages
//
//  Created by Danny Shmueli on 12/28/14.
//  Copyright (c) 2014 Hexed Bits. All rights reserved.
//

#import "JSQAniwaysMediaItem.h"
#import "JSQMessagesMediaViewBubbleImageMasker.h"

#import "../../../Aniways/Aniways.framework/Headers/AWTextViewLabel.h"

@interface JSQAniwaysMediaItem ()

@property (strong, nonatomic) AWTextViewLabel *cachedAniwaysLabel;

@end

@implementation JSQAniwaysMediaItem

#pragma mark - Initialization

- (instancetype)initWithText:(NSString *)text
{
    self = [super init];
    if (self) {
        _messageText = text;
        _cachedAniwaysLabel = nil;
    }
    return self;
}

- (void)dealloc
{
    _messageText = nil;
    _cachedAniwaysLabel = nil;
}

#pragma mark - Setters

- (void)setMessageText:(NSString *)messageText
{
    _messageText = messageText;
    _cachedAniwaysLabel = nil;
}

- (void)setAppliesMediaViewMaskAsOutgoing:(BOOL)appliesMediaViewMaskAsOutgoing
{
    [super setAppliesMediaViewMaskAsOutgoing:appliesMediaViewMaskAsOutgoing];
    _cachedAniwaysLabel = nil;
}

#pragma mark - JSQMessageMediaData protocol

- (UIView *)mediaView
{
    if (self.messageText == nil) {
        return nil;
    }
    
    if (self.cachedAniwaysLabel == nil) {
        CGSize size = [self mediaViewDisplaySize];
        AWTextViewLabel *aniwaysLabel = [AWTextViewLabel new];
        aniwaysLabel.frame = CGRectMake(0.0f, 0.0f, size.width, size.height);
//        aniwaysLabel.contentMode = UIViewContentModeScaleAspectFill;
        aniwaysLabel.clipsToBounds = YES;
        [JSQMessagesMediaViewBubbleImageMasker applyBubbleImageMaskToMediaView:aniwaysLabel isOutgoing:self.appliesMediaViewMaskAsOutgoing];
        self.cachedAniwaysLabel = aniwaysLabel;
    }
    
    return self.cachedAniwaysLabel;
}

#pragma mark - NSObject

- (NSUInteger)hash
{
    return super.hash ^ self.messageText.hash;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: text=%@, appliesMediaViewMaskAsOutgoing=%@>",
            [self class], self.messageText, @(self.appliesMediaViewMaskAsOutgoing)];
}

#pragma mark - NSCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _messageText = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(messageText))];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:self.messageText forKey:NSStringFromSelector(@selector(messageText))];
}

#pragma mark - NSCopying

- (instancetype)copyWithZone:(NSZone *)zone
{
    JSQAniwaysMediaItem *copy = [[[self class] allocWithZone:zone] initWithText:self.messageText];
    copy.appliesMediaViewMaskAsOutgoing = self.appliesMediaViewMaskAsOutgoing;
    return copy;
}


@end
