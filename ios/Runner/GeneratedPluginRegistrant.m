//
//  Generated file. Do not edit.
//

#import "GeneratedPluginRegistrant.h"

#if __has_include(<flutter_youtube_view/FlutterYoutubeViewPlugin.h>)
#import <flutter_youtube_view/FlutterYoutubeViewPlugin.h>
#else
@import flutter_youtube_view;
#endif

#if __has_include(<path_provider/PathProviderPlugin.h>)
#import <path_provider/PathProviderPlugin.h>
#else
@import path_provider;
#endif

#if __has_include(<sqflite/SqflitePlugin.h>)
#import <sqflite/SqflitePlugin.h>
#else
@import sqflite;
#endif

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [FlutterYoutubeViewPlugin registerWithRegistrar:[registry registrarForPlugin:@"FlutterYoutubeViewPlugin"]];
  [FLTPathProviderPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTPathProviderPlugin"]];
  [SqflitePlugin registerWithRegistrar:[registry registrarForPlugin:@"SqflitePlugin"]];
}

@end
