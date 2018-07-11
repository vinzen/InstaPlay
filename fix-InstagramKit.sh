#!/bin/sh

##
# Fix this crash
##
# 2018-07-11 21:49:23.407882+0200 InstaPlay[2549:2942165] *** Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: '*** -[NSPlaceholderString initWithString:]: nil argument'
# *** First throw call stack:
# (
#     0   CoreFoundation                      0x000000010614d1e6 __exceptionPreprocess + 294
#     1   libobjc.A.dylib                     0x000000010172f031 objc_exception_throw + 48
#     2   CoreFoundation                      0x00000001061c2975 +[NSException raise:format:] + 197
#     3   Foundation                          0x00000001011805d9 -[NSPlaceholderString initWithString:] + 123
#     4   InstagramKit                        0x00000001010e4bb5 -[InstagramUser updateDetailsWithInfo:] + 341
#     5   InstagramKit                        0x00000001010e4a1f -[InstagramUser initWithInfo:] + 351
#     6   InstagramKit                        0x00000001010e6b33 -[UserInPhoto initWithInfo:] + 723
#     7   InstagramKit                        0x00000001010dcb07 -[InstagramMedia initWithInfo:] + 3639
#     8   InstagramKit                        0x00000001010d6762 __77-[InstagramEngine getPaginatedPath:parameters:responseModel:success:failure:]_block_invoke_3 + 114
#     9   CoreFoundation                      0x00000001060db553 -[__NSArrayI enumerateObjectsWithOptions:usingBlock:] + 163
#     10  InstagramKit                        0x00000001010d65b8 __77-[InstagramEngine getPaginatedPath:parameters:responseModel:success:failure:]_block_invoke_2 + 152
#     11  libdispatch.dylib                   0x00000001072967ab _dispatch_call_block_and_release + 12
#     12  libdispatch.dylib                   0x00000001072977ec _dispatch_client_callout + 8
#     13  libdispatch.dylib                   0x000000010729c619 _dispatch_queue_override_invoke + 1451
#     14  libdispatch.dylib                   0x00000001072a336c _dispatch_root_queue_drain + 664
#     15  libdispatch.dylib                   0x00000001072a3076 _dispatch_worker_thread3 + 132
#     16  libsystem_pthread.dylib             0x00000001077c2169 _pthread_wqthread + 1387
#     17  libsystem_pthread.dylib             0x00000001077c1be9 start_wqthread + 13
# )
# libc++abi.dylib: terminating with uncaught exception of type NSException
# (lldb)

sed -i -e 's/\[\[NSString\ alloc\]\ initWithString:info\[kFullName\]\]/(IKNotNull(info[kFullName])) ? [[NSString alloc] initWithString:info[kFullName]] : @""/g' Pods/InstagramKit/InstagramKit/Models/InstagramUser.m
