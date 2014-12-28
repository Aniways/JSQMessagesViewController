//
//  JSQAniwaysMediaItem.h
//  JSQMessages
//
//  Created by Danny Shmueli on 12/28/14.
//  Copyright (c) 2014 Hexed Bits. All rights reserved.
//

#import "JSQMediaItem.h"

@interface JSQAniwaysMediaItem : JSQMediaItem <JSQMessageMediaData, NSCoding, NSCopying>

@property (copy, nonatomic) NSString *messageText;


- (instancetype)initWithText:(NSString *)text;
@end
