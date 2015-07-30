ZJWallPaperDemo:
=====
`无需越狱`,使用苹果的`私有Api动态改变壁纸`和类似`home键`(appStore可用)的小功能的例子,有用赏个小星星吧
 
如何使用:
=====
1.  /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/System/Library/PrivateFrameworks/PhotoLibrary 加入到 build phases -> link binary with libs
2. #import "UIImage+ZJWallPaper.h"
3. 使用一个存在的image实例调用   "UIImage+ZJWallPaper.h" 的方法就行了

例如:
=====
> [wallPaperImage zj_saveAsHomeScreen];//设为主屏幕壁纸
   
> [wallPaperImage zj_saveAsLockScreen];//设为锁屏壁纸
            
> [wallPaperImage zj_saveAsHomeScreenAndLockScreen];//同时设置为锁屏和主屏幕壁纸

例子:
=====
![](https://github.com/yoimhere/ZJWallPaperDemo/blob/master/ZJWallPaperDemo/ZJWallPaperDemo/demo.gif)
