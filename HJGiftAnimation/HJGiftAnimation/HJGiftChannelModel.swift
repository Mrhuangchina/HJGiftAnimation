//
//  HJGiftChinelModel.swift
//  HJGiftAnimation
//
//  Created by MrHuang on 17/8/10.
//  Copyright © 2017年 Mrhuang. All rights reserved.
//

import UIKit

class HJGiftChannelModel: NSObject {

    var senderName : String = ""
    var senderUrl : String = ""
    var GiftName : String = ""
    var GiftUrl : String = ""
    
    init(_ senderName : String,_ senderUrl : String,_ GiftName : String,_ GiftUrl : String) {
        
        self.senderName = senderName
        self.senderUrl = senderUrl
        self.GiftName = GiftName
        self.GiftUrl = GiftUrl
        
    }
    
    // 重写isEqual方法
    override func isEqual(_ object: Any?) -> Bool {
        
        guard let object = object as? HJGiftChannelModel  else {
            return false
        }
        
        guard object.senderName == senderName && object.GiftName == GiftName else {
            
            return false
        }
        
        return true
    }
    
}
