//
//  ViewController.swift
//  DrawHeartDemo
//
//  Created by xiaoyouxinqing on 2/12/20.
//  Copyright © 2020 xiaoyouxinqing. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private var gravityLayer: CAEmitterLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let width = view.bounds.width - 20
        let y = (view.bounds.height - width) / 2
        let heart = HeartView(frame: CGRect(x: 10, y: y, width: width, height: width),
                              image: UIImage(named: "test.jpg"))
        heart.delegate = self
        view.addSubview(heart)
        
        setupGravityLayer()
    }

    func setupGravityLayer() {
        gravityLayer = CAEmitterLayer()
        gravityLayer.renderMode = CAEmitterLayerRenderMode.oldestFirst
        gravityLayer.emitterPosition = CGPoint(x: view.bounds.width / 2, y: view.bounds.maxY)
        gravityLayer.birthRate = 0
        
        let rect = CGRect(x: 0, y: 0, width: 40, height: 40)
        UIGraphicsBeginImageContext(rect.size)
        
        UIColor.red.setFill()
        
        let path = UIBezierPath()
        path.addHeart(originalRect: rect, scale: 1)
        path.fill()
        
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
        
        let cell = CAEmitterCell()
        cell.contents = image.cgImage
        cell.scale = 0.5
        cell.lifetime = 10
        cell.alphaSpeed = -0.1
        cell.birthRate = 10
        cell.velocity = 180
        cell.yAcceleration = 20
        cell.emissionLongitude = -CGFloat.pi / 2
        cell.emissionRange = CGFloat.pi / 4
        cell.spin = 0 // default value
        cell.spinRange = CGFloat.pi * 2
        
        gravityLayer.emitterCells = [cell]
        view.layer.addSublayer(gravityLayer)
    }
}

extension ViewController: HeartViewDelegate {
    func heartViewAnimationDidFinish() {
        gravityLayer.beginTime = CACurrentMediaTime() + 0.5
        gravityLayer.birthRate = 1
    }
}
