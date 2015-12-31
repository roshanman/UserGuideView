# UserGuideView
iOS user guide view

## Demo
<img src="https://github.com/Jameson-zxm/UserGuideView/blob/master/demo.gif" />

## Installation

```ruby
pod 'UserGuideView', :git => 'https://github.com/Jameson-zxm/UserGuideView.git'
```
## How to use
```
    @IBOutlet var titleView: UISegmentedControl!
    @IBOutlet var helloBarItem: UIBarButtonItem!
    @IBOutlet var 点赞: UIButton!
    @IBOutlet var 吐槽: UIButton!
    @IBOutlet var 描述框: UITextView!
    @IBOutlet var item1: UIBarButtonItem!
    @IBOutlet var item2: UIBarButtonItem!
    @IBOutlet var item3: UIBarButtonItem!
    
    let i1 = UIBarButtonItem(barButtonSystemItem: .Refresh, target: nil, action: nil)
    let i2 = UIBarButtonItem(barButtonSystemItem: .Stop, target: nil, action: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItems = [
            i1,
            UIBarButtonItem(barButtonSystemItem: .FixedSpace, target: nil, action: nil),
            i2
        ]
    }

    override func viewWillAppear(animated: Bool) {
        let c1 = UserGuideContent(text: "这是我们的标题", view:titleView)
        let c2 = UserGuideContent(text: "给我打个招呼吧", naviBarItem: helloBarItem, itemIndex: 2)
        let c3 = UserGuideContent(text: "给我一个赞吧😄", view: 点赞)
        let c4 = UserGuideContent(text: "手下留情,我不喜欢被吐槽", view: 吐槽)
        let c5 = UserGuideContent(text: "这里是我的描述,亲可以看看", view: 描述框)
        let c6 = UserGuideContent(text: "这是item1", toolBarItem: item1, itemIndex: 0)
        let c7 = UserGuideContent(text: "这是item2", toolBarItem: item2, itemIndex: 1)
        let c8 = UserGuideContent(text: "这是item3", toolBarItem: item3, itemIndex: 2)
        let c9 = UserGuideContent(text: "自定义矩形区域", rect: CGRectMake(200, 200, 60, 60))
        let c10 = UserGuideContent(text: "这是刷新按钮", naviBarItem: i1, itemIndex: 0)
        let c11 = UserGuideContent(text: "停止按钮在这里", naviBarItem: i2, itemIndex: 1)
        
        let guide = UserGuideView(contents: [c1, c2, c9, c3, c4, c5, c6, c7, c8, c10, c11])
        //guide.mode = .Oval
        guide.showInViewController(self)
    }

```

## How to calc baritem index
<img src="https://github.com/Jameson-zxm/UserGuideView/blob/master/1.jpg" />

<img src="https://github.com/Jameson-zxm/UserGuideView/blob/master/2.jpg" />


## Contact me
mail: morenotepad@163.com

## License
(The MIT License)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the 'Software'), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
