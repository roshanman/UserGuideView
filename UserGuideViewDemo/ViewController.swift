//
//  ViewController.swift
//  UserGuideViewDemo
//
//  Created by DamonDing on 15/12/29.
//  Copyright © 2015年 morenotepad. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var titleView: UISegmentedControl!
    @IBOutlet var helloBarItem: UIBarButtonItem!
    @IBOutlet var 点赞: UIButton!
    @IBOutlet var 吐槽: UIButton!
    @IBOutlet var 描述框: UITextView!
    @IBOutlet var item1: UIBarButtonItem!
    @IBOutlet var item2: UIBarButtonItem!
    @IBOutlet var item3: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let i = UIBarButtonItem(barButtonSystemItem: .Refresh, target: nil, action: nil)
        
        print(i)
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let c1 = UserGuideContent(text: "这是我们的标题", view:titleView)
        let c2 = UserGuideContent(text: "给我打个招呼吧", barItem: helloBarItem)
        let c3 = UserGuideContent(text: "给我一个赞吧😄", view: 点赞)
        let c4 = UserGuideContent(text: "手下留情,我不喜欢被吐槽", view: 吐槽)
        let c5 = UserGuideContent(text: "这里是我的描述,亲可以看看", view: 描述框)
        let c6 = UserGuideContent(text: "这是item1", barItem: item1)
        let c7 = UserGuideContent(text: "这是item2", barItem: item2)
        let c8 = UserGuideContent(text: "这是item3", barItem: item3)
        let c9 = UserGuideContent(text: "自定义矩形区域", rect: CGRectMake(40, 200, 60, 60))
        
        let guide = UserGuideView(contents: [c1, c2, c9, c3, c4, c5, c6, c7, c8])
        guide.showInViewController(self)
    }
    
    
}

