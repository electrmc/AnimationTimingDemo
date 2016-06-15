//
//  ViewController.swift
//  AnimationDemo
//
//  Created by MiaoChao on 16/6/13.
//  Copyright © 2016年 MiaoChao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var displayLink: CADisplayLink?
    
    @IBOutlet weak var animatorView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.lightGrayColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: DisplayLink
    @IBAction func startDisplayLink(){
        if displayLink == nil {
            displayLink = CADisplayLink(target: self, selector: "handleDisplayLink:")
            displayLink?.frameInterval = 5 // 即每刷新5帧调用一次
            displayLink?.addToRunLoop(NSRunLoop.currentRunLoop(), forMode:NSRunLoopCommonModes)
        }
        displayLink?.paused = false
    }
    
    @IBAction func stopDisplayLink(){
        displayLink?.paused = true
        displayLink?.removeFromRunLoop(NSRunLoop.currentRunLoop(), forMode: NSRunLoopCommonModes)
        displayLink?.invalidate()
        displayLink = nil
    }
    
    func handleDisplayLink(displayLink: CADisplayLink) {
        print("displaylink last time : \(displayLink.timestamp)")
    }
    
    
    //MARK: CABasicAnimation
    @IBAction func startAnimation(sender: AnyObject) {
        let animation = CABasicAnimation(keyPath: "position")
        animation.delegate = self
        let fromPoint = CGPoint(x: self.animatorView.center.x, y: self.animatorView.center.y)
        let toPoint = CGPoint(x: 300.0, y: 300.0)
        animation.fromValue = NSValue(CGPoint: fromPoint)
        animation.toValue = NSValue(CGPoint: toPoint)
        animation.duration = 5.0
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        self.animatorView.layer.addAnimation(animation, forKey: "KVCkey")
//        self.animatorView.center = toPoint
    }
    
    @IBAction func endAnimation(sender: AnyObject) {
        print("end view : \(self.animatorView)")
        print("end view.layer : \(self.animatorView.layer.frame)")
    }
    
    // MARK: 这两个方法还不是协议，而是NSObject的扩展
    // 为什么动画都已经结束了才开始调用这个方法
    override func animationDidStart(anim: CAAnimation) {
        print("start view : \(self.animatorView)")
        print("start view.layer : \(self.animatorView.layer.frame)")
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        if anim is CABasicAnimation {
            let animTemp = anim as! CABasicAnimation
            let toValue = animTemp.toValue
            let toValueTemp: NSValue = toValue as! NSValue
            var point = CGPoint(x: 0, y: 0)
            toValueTemp.getValue(&point)
            //            var point = toValueTemp.CGPointValue()
            self.animatorView.center = point
        }
        
        print("end view : \(self.animatorView)")
        print("end view.layer : \(self.animatorView.layer.frame)")
    }
    
    // MARK: 使用CAMediaTiming暂停动画
    @IBAction func pauseLayerAnimation(sender: AnyObject) {
        self.pauseLayer(self.animatorView.layer)
    }

    @IBAction func resumeLayerAnimation(sender: AnyObject) {
        self.resumeLayer(self.animatorView.layer)
    }
    
    func pauseLayer(layer :CALayer){
        let pauseTime: CFTimeInterval = layer .convertTime(CACurrentMediaTime(), fromLayer: nil)
        layer.speed = 0.0
        layer.timeOffset = pauseTime
    }
    //MARK: 这个调用多次会出现什么问题
    func resumeLayer(layer :CALayer){
        let pauseTime = layer.timeOffset
        layer.speed = 1.0
        layer.timeOffset = 0.0
        layer.beginTime = 0.0
        let timeSincePause: CFTimeInterval = layer.convertTime(CACurrentMediaTime(), fromLayer: nil) - pauseTime
        layer.beginTime = timeSincePause
    }
    
    @IBAction func resetAnimationView(sender: AnyObject) {
        self.animatorView.center = CGPointMake(100, 100)
    }
}

