# VHYun_SDK_VOD_Upload_iOS

微吼云 点播上传 SDK 及 Demo <br>

集成和调用方式，参见官方文档：http://www.vhallyun.com/docs/show/89.html中的点播上传 <br>


### APP工程集成SDK基本设置
1、关闭bitcode 设置<br>
2、plist 中 App Transport Security Settings -> Allow Arbitrary Loads 设置为YES<br>
3、注册`AppKey`  [VHLiveBase registerApp:`AppKey`]; <br>
4、检查工程 `Bundle ID` 是否与`AppKey`对应 <br>
5、plist中添加相机、麦克风权限 <br>
6、互动功能暂不支持模拟器 <br>

其他具体配置见Dmeo。

### 版本更新信息
#### 版本 v2.0.0 更新时间：2019.11.18
更新内容：<br>
1、视频上传<br>
2、生成点播<br>


