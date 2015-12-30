//
//  ViewController.swift
//  UserGuideViewDemo
//
//  Created by DamonDing on 15/12/29.
//  Copyright © 2015年 morenotepad. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var button: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        let image = UIImage(named: "meizi.jpg")
        let imageView = UIImageView(image: image)
        imageView.tag = 1234
        imageView.contentMode = .ScaleToFill
        
        self.view.addSubview(imageView)
        
        let item = UIBarButtonItem(title: "ABC", style: .Done, target: nil, action: nil)
        print(item)
        let item2 = UIBarButtonItem(title: "ABC3", style: .Done, target: nil, action: nil)
        print(item)
        
        self.navigationItem.leftBarButtonItem = item
        
        self.navigationController?.setToolbarHidden(false, animated: false)
        
        self.toolbarItems = [item, item2]
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.view.viewWithTag(1234)?.frame = self.view.bounds
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let c1 = UserGuideContent(text: "abc", rect: CGRectMake(100, 100, 50, 50))
        let c2 = UserGuideContent(text: "abc", rect: CGRectMake(200, 200, 50, 50))
        let c3 = UserGuideContent(text: "abc", rect: CGRectMake(300, 400, 100, 80))
        let c4 = UserGuideContent(text: "abc", rect: CGRectMake(300, 600, 150, 70))
        let c5 = UserGuideContent(text: "button", view: self.button)
        
        let v = UserGuideView(contents: [c1, c2, c3, c4, c5])
        v.show()
    }
    
    
}

