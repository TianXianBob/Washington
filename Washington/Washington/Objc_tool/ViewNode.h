//
//  ViewNode.h
//  Washington
//
//  Created by bob on 2021/5/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ViewNode : NSObject
@property (nonatomic, copy) NSString *ClsName;
@property (nonatomic, assign) NSInteger tag;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, assign) Rect frame;
@end

NS_ASSUME_NONNULL_END
