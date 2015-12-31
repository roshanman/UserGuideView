//
//  UserGuideView
//
//  Created by DamonDing on 15/12/29.
//  Copyright © 2015年 morenotepad. All rights reserved.
//

import Foundation
import UIKit

public enum UserGuideViewMode : Int {
    case Rect
    case RoundRect
    case Oval
}

@objc
protocol UserGuideViewProtocol {
    
}

class UserGuideContent : NSObject {
    private var toolBarItem:UIBarButtonItem?
    private var naviBarItem:UIBarButtonItem?
    private var view:UIView?
    private var rect:CGRect?
    private var guideText:String!
    private var barItemIndex:Int?
    
    var vc:UIViewController? // don't set this param youself, i need this to computer baritem position
    
    var guideRect:CGRect {
        get {
            let rt1 = rectOfBarItem
            let rt2 = rectOfView
            let rt3 = rect
            
            return (rt1 != CGRectZero) ? (rt1) : (rt2 != CGRectZero ? rt2 : (rt3 ?? CGRectZero))
        }
    }
    
    var text:String! {
        get {
            return guideText
        }
    }
    
    private var rectOfBarItem:CGRect {
        get {
            guard let v = vc else { return CGRectZero }
            
            if let nav = v.navigationController {
                if let item = toolBarItem {
                    if !nav.toolbarHidden {
                        let bar = nav.toolbar
                        if let i = getToolBarItemIndex(bar, barItem: item) {
                            if let views = getToolBarbuttons(bar) {
                                if i >= views.count { return CGRectZero }
                                
                                let aView = views[i]
                                return aView.convertRect(aView.bounds, toView: nil)
                            }
                        }
                    }
                }
                
                if !nav.navigationBarHidden {
                    if let item = naviBarItem {
                        let bar = nav.navigationBar
                        if let i = getNaviBarItemIndex(bar, barItem: item) {
                            if let views = getNaviBarButtons(bar) {
                                if i >= views.count { return CGRectZero }
                                
                                let aView = views[i]
                                return aView.convertRect(aView.bounds, toView: nil)
                            }
                        }
                    }
                }
            }
            
            return CGRectZero
        }
    }
    
    private var rectOfView:CGRect {
        get {
            guard let v = self.view else { return CGRectZero }
            
            return v.convertRect(v.bounds, toView: nil)
        }
    }
    
    private init(text:String!, tooBarItem:UIBarButtonItem!, naviBarItem:UIBarButtonItem!, view:UIView!, rect:CGRect!, index:Int?) {
        self.toolBarItem = tooBarItem
        self.naviBarItem = naviBarItem
        self.barItemIndex = index
        self.rect = rect
        self.view = view
        self.guideText = text
        
        super.init()
    }
    
    convenience init(text:String!, toolBarItem:UIBarButtonItem!, itemIndex:Int) {
        self.init(text: text, tooBarItem:toolBarItem, naviBarItem:nil, view:nil, rect:nil, index:itemIndex)
    }
    
    convenience init(text:String!, naviBarItem:UIBarButtonItem!, itemIndex:Int) {
        self.init(text: text, tooBarItem:nil, naviBarItem:naviBarItem, view:nil, rect:nil, index:itemIndex)
    }
    
    convenience init(text:String!, view:UIView!) {
        self.init(text: text, tooBarItem:nil, naviBarItem:nil, view:view, rect:nil, index:nil)
    }

    convenience init(text:String!, rect:CGRect!) {
        self.init(text: text, tooBarItem:nil, naviBarItem:nil, view:nil, rect:rect, index:nil)
    }
}

extension UserGuideContent {
    func getNaviBarItemIndex(bar:UINavigationBar, barItem:UIBarButtonItem) -> Int? {
        return barItemIndex
//        guard let items = bar.topItem else { return nil }
//        for (index, item) in ((items.leftBarButtonItems ?? []) + (items.rightBarButtonItems ?? [])).enumerate() {
//            if item === barItem {
//                return index
//            }
//        }
//        
//        return nil
    }
    
    func getToolBarItemIndex(bar:UIToolbar, barItem:UIBarButtonItem) -> Int? {
        return barItemIndex
//        guard let items = bar.items else { return nil }
//        
//        for (index, item) in items.enumerate() {
//            if item === barItem {
//                return index
//            }
//        }
//        
//        return nil
    }
    
    func getNaviBarButtons(bar:UINavigationBar) -> [UIView]? {
        let naviButtonClass:AnyClass? = NSClassFromString("UINavigationButton")
        var array = [UIView]()
        
        for button in bar.subviews {
            if button.isKindOfClass(naviButtonClass!) {
                array.append(button)
            }
        }
        
        return array.count == 0 ? nil : array
    }
    
    func getToolBarbuttons(bar:UIToolbar) -> [UIView]? {
        let toolButtonClass1:AnyClass? = NSClassFromString("UIToolbarButton")
        let toolButtonClass2:AnyClass? = NSClassFromString("UIToolbarTextButton")
        
        var array = [UIView]()
        
        for button in bar.subviews {
            if button.isKindOfClass(toolButtonClass1!) || button.isKindOfClass(toolButtonClass2!) {
                array.append(button)
            }
        }
        
        return array.count == 0 ? nil : array
    }
}

class UserGuideView : UIView {
    var guideContents = [UserGuideContent]()
    var mode:UserGuideViewMode = .RoundRect

    private var viewController:UIViewController?
    
    private lazy var label:UILabel = {
        let l = UILabel(frame:CGRectZero)
        l.font = UIFont.systemFontOfSize(16)
        l.textColor = UIColor.lightTextColor()
        l.textAlignment = .Center
        return l
    }()
    
    private lazy var imageView:UIImageView = {
       let iv = UIImageView(frame: CGRectZero)
        iv.contentMode = .Center
        return iv
    }()

    private var index = 0
    
    var currentIndex:Int {
        get {
            return index
        }
    }
    
    private var screenRect:CGRect {
        get {
            return UIScreen.mainScreen().bounds
        }
    }

    private var rootWindow:UIWindow! {
        get {
            return UIApplication.sharedApplication().keyWindow
        }
    }

    private let maskColor = UIColor(colorLiteralRed: 0, green: 0, blue: 0, alpha: 0.68)

    init(contents:[UserGuideContent]) {
        guideContents = contents
        super.init(frame:CGRectZero)
        
        commonInit()
    }
    
    convenience init() {
        self.init(contents:[])
        
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    private func commonInit() {
        self.backgroundColor = maskColor
        self.addSubview(label)
        self.addSubview(imageView)
    }
    
    func showInViewController(vc:UIViewController!) {
        self.viewController = vc
        self.show()
    }
    
    private func show() {
        self.frame = screenRect
        self.removeFromSuperview()
        rootWindow?.addSubview(self)
        showGuideContent()
    }
    
    func hide() {
        self.removeFromSuperview()
        index = 0
    }

    private func setImageOfContent(content:UserGuideContent) {
        let rt = content.guideRect
        let midY = CGRectGetMidY(rt)
        let mid  = CGRectGetMidY(screenRect)
        
        if mid > midY {
            imageView.image = UIImage(named: "UserGuideView.bundle/fx_my_attention_guide_arrow")
        } else {
            imageView.image = UIImage(named: "UserGuideView.bundle/fx_guide_arrow_down")
        }
        
        imageView.frame.size = imageView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize)
    }
    
    private func setLabelText(content:UserGuideContent) {
        label.text = content.text
        let size = label.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize)
        label.frame.size = size
    }
    
    private func pathWithContent(content:UserGuideContent) -> UIBezierPath {
        var path:UIBezierPath!
        
        switch mode {
        case .Oval:
            path = UIBezierPath(ovalInRect: content.guideRect)
        case .Rect:
            path = UIBezierPath(rect: content.guideRect)
        case .RoundRect:
            path = UIBezierPath(roundedRect: content.guideRect, cornerRadius: 4)
        }
        
        return path
    }
    
    private func placeViews(content:UserGuideContent) {
        let rt = content.guideRect
        let midY = CGRectGetMidY(rt)
        let mid  = CGRectGetMidY(screenRect)

        if mid > midY {
            imageView.center = rt.center.offSetBy(-10, dy:  (rt.height + imageView.h + 8) / 2.0)
            label.center = imageView.center.offSetBy(-imageView.w / 2.0, dy: imageView.h / 2.0 + 10)
        } else {
            imageView.center = rt.center.offSetBy(-10, dy: -(rt.height + imageView.h + 8) / 2.0)
            label.center = imageView.center.offSetBy(-imageView.w / 2.0, dy: -imageView.h / 2.0 - 10)
        }
        
        if CGRectGetMinX(label.frame) < 0 {
            label.frame.origin.x = 2
        } else if CGRectGetMaxX(label.frame) > CGRectGetMaxX(screenRect) {
            label.frame.origin.x = (label.frame.origin.x + CGRectGetMaxX(screenRect) - CGRectGetMaxX(label.frame))
        }
    }
    
    private func setMask(content:UserGuideContent) {
        let full_path = UIBezierPath(rect: screenRect)
        let rect_path = pathWithContent(content)
        
        full_path.appendPath(rect_path.bezierPathByReversingPath())
        
        let layer = CAShapeLayer()
        layer.path = full_path.CGPath
        
        self.layer.mask = layer
    }
    
    private func showGuideContent() {
        if index >= guideContents.count {
            hide()
            return
        }
        
        let content = guideContents[index++]
        content.vc = viewController

        setImageOfContent(content)
        setLabelText(content)
        placeViews(content)
        setMask(content)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        
        showGuideContent()
    }
}

extension CGRect {
    var center:CGPoint {
        get {
            return CGPointMake(CGRectGetMidX(self), CGRectGetMidY(self))
        }
    }
}

extension CGPoint {
    func offSetBy(dx:CGFloat, dy:CGFloat) -> CGPoint {
        return CGPointMake(self.x + dx, self.y + dy)
    }
}

extension UIView {
    var w:CGFloat {
        get {
            return  CGRectGetWidth(self.bounds)
        }
    }
    
    var h:CGFloat {
        get {
            return  CGRectGetHeight(self.bounds)
        }
    }
}

extension UserGuideView {
    
}
