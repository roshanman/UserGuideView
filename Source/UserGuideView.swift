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
    private var placeOfBarItem:UIBarButtonItem?
    private var placeOfView:UIView?
    private var placeOfRect:CGRect?
    private var guideText:String!
    
    var rect:CGRect {
        get {
            return (rectOfBarItem != CGRectZero) ? (rectOfBarItem) :
                (rectOfView != CGRectZero ? rectOfView : (placeOfRect ?? CGRectZero))
        }
    }
    
    private var rectOfBarItem:CGRect {
        get {
            return CGRectZero
        }
    }
    
    private var rectOfView:CGRect {
        get {
            guard let v = self.placeOfView else { return CGRectZero }
            
            return v.convertRect(v.bounds, toView: nil)
        }
    }
    
    private init(text:String!, barItem:UIBarButtonItem!, view:UIView!, rect:CGRect!) {
        self.placeOfBarItem = barItem
        self.placeOfRect = rect
        self.placeOfView = view
        self.guideText = text
        
        super.init()
    }
    
    convenience init(text:String!, barItem:UIBarButtonItem!) {
        self.init(text: text, barItem:barItem, view:nil, rect:CGRectZero)
    }
    
    convenience init(text:String!, view:UIView!) {
        self.init(text: text, barItem:nil, view:view, rect:CGRectZero)
    }

    convenience init(text:String!, rect:CGRect!) {
        self.init(text: text, barItem:nil, view:nil, rect:rect)
    }

}

class UserGuideView : UIView {
    var guideContents = [UserGuideContent]()
    var mode:UserGuideViewMode = .Oval
    
    private var index = 0
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
    }
    
    func show() {
        self.frame = screenRect
        self.removeFromSuperview()
        rootWindow?.addSubview(self)
        showGuideContent()
    }
    
    private func pathWithContent(content:UserGuideContent) -> UIBezierPath {
        var path:UIBezierPath!
        
        switch mode {
        case .Oval:
            path = UIBezierPath(ovalInRect: content.rect)
        case .Rect:
            path = UIBezierPath(rect: content.rect)
        case .RoundRect:
            path = UIBezierPath(roundedRect: content.rect, cornerRadius: 4)
        }
        
        return path
    }
    
    func hide() {
        self.removeFromSuperview()
        index = 0
    }
    
    private func showGuideContent() {
        if index >= guideContents.count {
            hide()
            return
        }
        
        let content = guideContents[index++]
        let full_path = UIBezierPath(rect: screenRect)
        let rect_path = pathWithContent(content)
        
        full_path.appendPath(rect_path.bezierPathByReversingPath())
        
        let layer = CAShapeLayer()
        layer.path = full_path.CGPath
        
        self.layer.mask = layer
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        
        showGuideContent()
    }
}

