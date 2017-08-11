//
//  HJGiftChinelView.swift
//  HJGiftAnimation
//
//  Created by MrHuang on 17/8/10.
//  Copyright © 2017年 Mrhuang. All rights reserved.
//

import UIKit

enum HJGiftChannelState {

    case idle  //闲置的
    case animating //正在执行动画
    case willEnd  //将要结束动画
    case endAnimating //已经结束动画
    
}


class HJGiftChannelView: UIView {

    var complectionCallback : ((HJGiftChannelView) -> Void)?
    
    // MARK: 控件属性
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var senderLabel: UILabel!
    @IBOutlet weak var giftDescLabel: UILabel!
    @IBOutlet weak var giftImageView: UIImageView!
    

    @IBOutlet weak var digitLabel: HJGiftDigitLabel!
    
    //当前礼物数
    var currentNumber : Int = 0
    //当前缓存数
    var currentCacheNumber : Int = 0
    
    var channelViewState : HJGiftChannelState = .idle
  
    var giftModel : HJGiftChannelModel? {
    
        didSet{
        
            // 1. 模型校验
            guard let giftModel = giftModel else {
                return
            }
            // 2. 设置基本信息
            iconImageView.image = UIImage(named: giftModel.senderUrl)
            senderLabel.text = giftModel.senderName
            giftDescLabel.text = "送出礼物:【\(giftModel.GiftName)】"
            giftImageView.image = UIImage(named: giftModel.GiftUrl)
            
            //3. 执行动画将ChanelView弹出
            channelViewState = .animating
            performAnimation()
        }
    
    }
    
}


// MARK:- 设置UI界面
extension HJGiftChannelView {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        bgView.layer.cornerRadius = frame.height * 0.5
        iconImageView.layer.cornerRadius = frame.height * 0.5
        bgView.layer.masksToBounds = true
        iconImageView.layer.masksToBounds = true
        iconImageView.layer.borderWidth = 1
        iconImageView.layer.borderColor = UIColor.green.cgColor
    }
}

extension HJGiftChannelView {
    //添加到缓存池
    func addOneToCache(){
        if channelViewState == .willEnd {
            
            performAnimation()
            // 取消延迟3秒
            NSObject.cancelPreviousPerformRequests(withTarget: self)
            
        } else {
        
            currentCacheNumber += 1
        }
        
    }
    
   class func loadFormNib() -> HJGiftChannelView {
    
        return Bundle.main.loadNibNamed("HJGiftChannelView", owner: nil, options: nil)?.first as! HJGiftChannelView
    }

   

}
//MARK: -执行动画
extension HJGiftChannelView {

    func performAnimation(){
        
        digitLabel.alpha = 1.0
        digitLabel.text = " x1 "
        
        UIView.animate(withDuration: 0.25, animations: {
            
            self.alpha = 1.0
            self.frame.origin.x = 0
            
        }) { (isFinished) in
            
            self.performDigitAnimation()
        }
    }
    
    func performDigitAnimation(){
    
        currentNumber += 1
        digitLabel.text = " x\(currentNumber) "
        
        digitLabel.ShowDigitAnimation {
        
            if self.currentCacheNumber > 0 {
            
                self.currentCacheNumber -= 1
            
                self.performDigitAnimation()
                
            }else {
            
                self.channelViewState = .willEnd
                self.perform(#selector(self.performEndAnimation), with: nil, afterDelay: 3.0)
            }
            
        }
        
        
    }
    
    @objc fileprivate func performEndAnimation() {
    
        channelViewState = .endAnimating
        UIView.animate(withDuration: 0.25, animations: { 
            
            self.frame.origin.x = UIScreen.main.bounds.width
            self.alpha = 0.0
            
        }, completion: { (isFinished) in
            
            self.currentNumber = 0
            self.currentCacheNumber = 0
            self.giftModel = nil
            self.frame.origin.x = -self.frame.width
            self.channelViewState = .idle
            self.digitLabel.alpha = 0
          
            if let complectionCallback = self.complectionCallback {
                
                complectionCallback(self)
                
            }
            
        })
    
    }
    
}
