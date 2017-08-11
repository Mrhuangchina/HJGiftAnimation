//
//  HJGiftDigitLabel.swift
//  HJGiftAnimation
//
//  Created by MrHuang on 17/8/10.
//  Copyright © 2017年 Mrhuang. All rights reserved.
//

import UIKit

class HJGiftDigitLabel: UILabel {

    override func drawText(in rect: CGRect) {
        
        // 1.获取当前上下文
        let content = UIGraphicsGetCurrentContext()
        
        content?.setLineJoin(.round)
        content?.setLineWidth(5.0)
        content?.setTextDrawingMode(.stroke)
        textColor = UIColor.orange
        
        super.drawText(in: rect)
        
        content?.setTextDrawingMode(.fill)
        textColor = UIColor.white
        
        super.drawText(in: rect)
        
        
    }
    
    func ShowDigitAnimation(_ complection: @escaping () -> ()) {
        
        UIView.animateKeyframes(withDuration: 0.25, delay: 0, options: [], animations: {
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5, animations: {
                
                self.transform = CGAffineTransform(scaleX: 3.0, y: 3.0)
                
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5, animations: {
                
                self.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
                
            })
            
        }) { (isFinished) in
            
            UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 10, options: [], animations: {
                
                self.transform = CGAffineTransform.identity
                
            }, completion: { (isFinifshed) in
                
                complection()
                
            })
            
            
        }
        
        
    }

    
    
}
