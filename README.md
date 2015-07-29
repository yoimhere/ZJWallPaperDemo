ZJWallPaperDemo:
=====
这是一个使用苹果的`私有Api动态改变壁纸`和类似`home键`的小功能的例子
 
如何使用:
=====
1.  /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/System/Library/PrivateFrameworks/PhotoLibrary 加入到 build phases -> link binary with libs
2. #import "UIImage+ZJWallPaper.h"
3. 使用一个存在的image实例调用   "UIImage+ZJWallPaper.h" 的方法就行了

例如:
=====
> [willSetWallPaperImage zj_saveAsHomeScreen];//设为主屏幕壁纸
   
> [willSetWallPaperImage zj_saveAsLockScreen];//设为锁屏壁纸
            
> [willSetWallPaperImage zj_saveAsHomeScreenAndLockScreen];//同时设置为锁屏和主屏幕壁纸

例子:
=====
![](https://github.com/yoimhere/ZJWallPaperDemo/blob/master/ZJWallPaperDemo/ZJWallPaperDemo/demo.gif)
