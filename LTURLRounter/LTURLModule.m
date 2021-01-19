//
//  LTURLModule.m
//  LTURLRounterDemo
//
//  Created by huanyu.li on 2021/1/19.
//  Copyright © 2021 huanyu.li. All rights reserved.
//

#import "LTURLModule.h"

@interface LTURLModule ()

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSMutableDictionary<NSString *, LTURLModule *> *subModules;

@end

@implementation LTURLModule

- (instancetype)initWithName:(NSString *)name {
    if (name.length == 0) {
        NSAssert(NO, @"注册的模块名字不能为空,请检测");
    }
    if (self = [self init]) {
        _name = [name copy];
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _subModules = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)registerModule:(LTURLModule *)module {
    if (module.name.length > 0) {
        if (_subModules[module.name]) {
            NSAssert(NO, @"注册的模块重复了,请检测");
        } else {
            _subModules[module.name] = module;
        }
    }
}

- (void)unregisterModuleWithName:(NSString *)moduleName {
    if (moduleName.length > 0) {
        _subModules[moduleName] = nil;
    } else {
        NSLog(@"这个需要取消注册的模块尚未注册或已经被移除,请检测");
    }
}

- (BOOL)canHandleURL:(NSURL *)url {
    if (self.canHandleURLBlock) {
        return self.canHandleURLBlock(url);
    }
    return NO;
}

- (BOOL)canModuleChainHandleURL:(NSURL *)url {
    return NO;
}

- (void)handleURL:(NSURL *)url {
    if (self.handleURLBlock) {
        self.handleURLBlock(url);
    }
}

- (void)moduleChainHandleURL:(NSURL *)url {
    
}

@end