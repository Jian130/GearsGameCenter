//
//  GCDSingleton.h
//  agnes
//
//  Created by LJ-Jian on 12/28/2013.
//  Copyright (c) 2013 BlissPlatform. All rights reserved.
//

#ifndef agnes_GCDSingleton_h
#define agnes_GCDSingleton_h

#define DEFINE_SHARED_INSTANCE_USING_BLOCK(block) \
static dispatch_once_t pred = 0; \
__strong static id _sharedObject = nil; \
dispatch_once(&pred, ^{ \
_sharedObject = block(); \
}); \
return _sharedObject; \

#endif
