//
//  ViewController.swift
//  HJGiftAnimation
//
//  Created by MrHuang on 17/8/9.
//  Copyright © 2017年 Mrhuang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    fileprivate lazy var containerView : HJGiftContainerView = HJGiftContainerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        containerView.frame = CGRect(x: 0, y: 100, width: 200, height: 90)
        containerView.backgroundColor = UIColor.lightGray
        
        view.addSubview(containerView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        
//        DigitLabel.ShowDigitAnimation { 
//            print("动画结束！")
//        }
//        
//    }

    @IBAction func Gift1() {
        
        let gift1 = HJGiftChannelModel( "小伙子1",  "icon4", "跑车", "prop_b")
        containerView.showModel(gift1)
        
    }
    @IBAction func Gift2() {
        
        let gift2 = HJGiftChannelModel( "小伙子2",  "icon2", "啤酒", "prop_f")
        containerView.showModel(gift2)

        
    }
    
    @IBAction func Gift3() {
        
        let gift3 = HJGiftChannelModel( "小伙子3",  "icon3", "蘑菇", "prop_g")
        containerView.showModel(gift3)

        
    }
}

