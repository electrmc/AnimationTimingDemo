//
//  SecondViewController.swift
//  AnimationDemo
//
//  Created by MiaoChao on 16/6/23.
//  Copyright © 2016年 MiaoChao. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    var myLayer: CALayer?
    override func viewDidLoad() {
        super.viewDidLoad()
        myLayer = CALayer()
        myLayer?.frame = CGRectMake(10, 30, 300, 100)
        myLayer?.backgroundColor = UIColor.lightGrayColor().CGColor
        self.view.layer.addSublayer(myLayer!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func startAnimation(sender: AnyObject) {
        let changeColor: CABasicAnimation = CABasicAnimation(keyPath: "backgroundColor")
        changeColor.fromValue = UIColor.redColor().CGColor
        changeColor.toValue = UIColor.blackColor().CGColor
        changeColor.duration = 1.0
        self.myLayer?.speed = 0.0
        self.myLayer?.addAnimation(changeColor, forKey: "backgroundColor")
    }
    
    @IBAction func sliderForAnimation(sender: AnyObject) {
        let slider = sender as! UISlider
        print("slider value : \(slider.value)")
        self.myLayer?.timeOffset = Double(slider.value)
    }
}
