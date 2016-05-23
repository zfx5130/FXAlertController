# FXAlertController

    由于系统的UIAlertController的actionSheet样式的弹出框和自己需要作的actionSheet相差有一定区别，所以就想办法封装了一个，效果和系统效果一直，不过在原有基础上修改了弹出框的样式，及button可以添加图片。具体事例可下载Demo,代码语言Swift。

###效果如下

![](https://github.com/zfx5130/FXAlertController/blob/master/demo4.gif)
![](https://github.com/zfx5130/FXAlertController/blob/master/demo5.gif)



## 使用方式

```
        
        let alertController = FXAlertController(title: "测试代码", message: nil)
        let cancleAction = FXAlertAction(title: "取消", style: .Cancel, leftImage: nil) {
            print("取消 按钮")
        }
        let reportAction = FXAlertAction(title: "举报", style: .Destructive, leftImage: nil) {
            print("举报")
        }
        let blackAction = FXAlertAction(title: "拉黑TA", style: .Destructive, leftImage: nil) {
            print("拉黑TA")
        }
        let shareAction = FXAlertAction(title: "分享到", style: .Destructive, leftImage: nil) {
            print("分享到")
        }
        alertController.addAction(cancleAction)
        alertController.addAction(reportAction)
        alertController.addAction(blackAction)
        alertController.addAction(shareAction)
        
        presentViewController(alertController, animated: true, completion: nil)

```

ps: 在实现自定义AlertController前，先对系统的UIAlertController进行了一番的研究，通过KVC的方式获取相应属性，对系统控件进行修改，例如字体大小，颜色，背景等，但是有一些并不能修改，但是一些简单的还是可以实现修改的，如果想对UIAlertController详细了解可跳转此[Demo](https://github.com/zfx5130/UIAlertController)


