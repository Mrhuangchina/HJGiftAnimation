//
//  HJGiftContainerView.swift
//  HJGiftAnimation
//
//  Created by MrHuang on 17/8/10.
//  Copyright © 2017年 Mrhuang. All rights reserved.
//

import UIKit

private let kChannelCount = 2
private let kChannelViewH : CGFloat = 40
private let kChannelMargin : CGFloat = 10

class HJGiftContainerView: UIView {

    fileprivate lazy var channelViews : [HJGiftChannelView] = [HJGiftChannelView]()
    fileprivate lazy var cacheGiftModels : [HJGiftChannelModel] = [HJGiftChannelModel]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


//MARK: -设置UI
extension HJGiftContainerView {
    
   fileprivate func setupUI(){
    
        let w : CGFloat = frame.width
        let h : CGFloat = kChannelViewH
        let x : CGFloat = 0
        
        for i in 0..<kChannelCount {
            let  y : CGFloat = (h + kChannelMargin) * CGFloat(i)
            
           let channelView = HJGiftChannelView.loadFormNib()
            channelView.frame = CGRect(x: x, y: y, width:w, height: h)
            channelView.alpha = 0
            addSubview(channelView)
            
            channelViews.append(channelView)
            
            channelView.complectionCallback = { channelView in
            
                // 1.取出缓存中的模型
                guard self.cacheGiftModels.count != 0 else {
                    return
                }
                
                // 2.取出缓存中的第一个模型数据
                let firstModel = self.cacheGiftModels.first!
                self.cacheGiftModels.removeFirst()
               
                // 3.让闲置的channelView执行动画
                channelView.giftModel = firstModel
                
                 // 4.将数组中剩余有和firstModel相同的模型放入到ChanelView缓存中
                for i in (0..<self.cacheGiftModels.count).reversed() {
                    
                    let giftModel = self.cacheGiftModels[i]
                  
                    if giftModel .isEqual(firstModel) {
                        
                        channelView.addOneToCache()
                        
                        self.cacheGiftModels.remove(at: i)
                    }
                }
                
            }
        }
        
    
    }

    
}

extension HJGiftContainerView {
   
    func showModel(_ giftModel : HJGiftChannelModel){
    
        // 1.判断正在忙的ChanelView和赠送的新礼物的(username/giftname)
        if let channelView = checkUsingChanelView(giftModel) {
            
            channelView.addOneToCache()
            return
        }
        
    
        // 2. 判断有没有闲置的channelView
        if let channelView = checkIdleChannelView(){
        
            channelView.giftModel = giftModel
            
            return
        }
        
        // 3. 将数据加入缓存中
        cacheGiftModels.append(giftModel)
        
    }
    
   //检查正在使用的channelView
    private func checkUsingChanelView(_ giftModel : HJGiftChannelModel) -> HJGiftChannelView? {
        
        for channelView in channelViews {
            
            if giftModel.isEqual(channelView.giftModel)
              && channelView.channelViewState != .endAnimating {
                
                return channelView
            }
        }
        
        return nil
    }
    
    //检查有没有闲置的channel
    private func checkIdleChannelView() -> HJGiftChannelView? {
        
        for channelView in channelViews {
            
            if channelView.channelViewState == .idle {
                return channelView
            }
            
        }
        
        return nil
    }

}
