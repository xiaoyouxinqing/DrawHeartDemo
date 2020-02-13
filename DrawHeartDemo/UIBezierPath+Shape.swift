//
//  UIBezierPath+Shape.swift
//  DrawHeartDemo
//
//  Created by xiaoyouxinqing on 2/12/20.
//  Copyright © 2020 xiaoyouxinqing. All rights reserved.
//

import UIKit

extension UIBezierPath  {
    func drawableRect(originalRect: CGRect, scale: CGFloat) -> CGRect {
        let scaledWidth = originalRect.width * scale
        let scaledXValue = (originalRect.width - scaledWidth) / 2
        let scaledHeight = originalRect.height * scale
        let scaledYValue = (originalRect.height - scaledHeight) / 2
        return CGRect(x: scaledXValue, y: scaledYValue, width: scaledWidth, height: scaledHeight)
    }
    
    func addHeart(originalRect: CGRect, scale: CGFloat) {
        addHeartLeftBottom(originalRect: originalRect, scale: scale, move: true)
        addHeartLeftTop(originalRect: originalRect, scale: scale)
        addHeartRightTop(originalRect: originalRect, scale: scale)
        addHeartRightBottom(originalRect: originalRect, scale: scale)
        self.close()
    }
    
    func addHeartLeft(originalRect: CGRect, scale: CGFloat, move: Bool = false) {
        addHeartLeftBottom(originalRect: originalRect, scale: scale, move: move)
        addHeartLeftTop(originalRect: originalRect, scale: scale, move: move)
    }
    
    func addHeartRight(originalRect: CGRect, scale: CGFloat, move: Bool = false) {
        addHeartRightTop(originalRect: originalRect, scale: scale, move: move)
        addHeartRightBottom(originalRect: originalRect, scale: scale, move: move)
    }
    
    func addHeartLeftBottom(originalRect: CGRect, scale: CGFloat, move: Bool = false) {
        let scaledRect = drawableRect(originalRect: originalRect, scale: scale)
        
        if move {
            self.move(to: CGPoint(x: originalRect.width / 2, y: scaledRect.origin.y + scaledRect.height))
        }
        
        self.addCurve(to: CGPoint(x: scaledRect.origin.x,
                                  y: scaledRect.origin.y + (scaledRect.height / 4)),
                      controlPoint1: CGPoint(x: scaledRect.origin.x + scaledRect.width / 2,
                                             y: scaledRect.origin.y + scaledRect.height * 3 / 4) ,
                      controlPoint2: CGPoint(x: scaledRect.origin.x,
                                             y: scaledRect.origin.y + scaledRect.height / 2))
    }
    
    func addHeartLeftTop(originalRect: CGRect, scale: CGFloat, move: Bool = false) {
        let scaledRect = drawableRect(originalRect: originalRect, scale: scale)
        
        if move {
            self.move(to: CGPoint(x: scaledRect.origin.x, y: scaledRect.origin.y + scaledRect.height / 4))
        }
        
        self.addArc(withCenter: CGPoint(x: scaledRect.origin.x + scaledRect.width / 4,
                                        y: scaledRect.origin.y + scaledRect.height / 4),
                    radius: scaledRect.width / 4,
                    startAngle: .pi,
                    endAngle: 0,
                    clockwise: true)
    }
    
    func addHeartRightTop(originalRect: CGRect, scale: CGFloat, move: Bool = false) {
        let scaledRect = drawableRect(originalRect: originalRect, scale: scale)
        
        if move {
            self.move(to: CGPoint(x: originalRect.width / 2, y: scaledRect.origin.y + scaledRect.height / 4))
        }
        
        self.addArc(withCenter: CGPoint(x: scaledRect.origin.x + scaledRect.width * 3 / 4,
                                        y: scaledRect.origin.y + scaledRect.height / 4),
                    radius: scaledRect.width / 4,
                    startAngle: .pi,
                    endAngle: 0,
                    clockwise: true)
    }
    
    func addHeartRightBottom(originalRect: CGRect, scale: CGFloat, move: Bool = false) {
        let scaledRect = drawableRect(originalRect: originalRect, scale: scale)
        
        if move {
            self.move(to: CGPoint(x: scaledRect.maxX, y: scaledRect.origin.y + scaledRect.height / 4))
        }
        
        self.addCurve(to: CGPoint(x: originalRect.width / 2,
                                  y: scaledRect.origin.y + scaledRect.height),
                      controlPoint1: CGPoint(x: scaledRect.origin.x + scaledRect.width,
                                             y: scaledRect.origin.y + scaledRect.height / 2),
                      controlPoint2: CGPoint(x: scaledRect.origin.x + scaledRect.width / 2,
                                             y: scaledRect.origin.y + scaledRect.height * 3 / 4))
    }
    
    func addCircle(originalRect: CGRect, scale: CGFloat) {
        let scaledRect = drawableRect(originalRect: originalRect, scale: scale)
        let center = CGPoint(x: originalRect.width / 2, y: originalRect.height / 2)
        let radius = scaledRect.width / 2
        
        self.move(to: CGPoint(x: originalRect.width / 2, y: scaledRect.origin.y + scaledRect.height))
        
        self.addArc(withCenter: center,
                    radius: radius,
                    startAngle: .pi / 2,
                    endAngle: .pi,
                    clockwise: true)
        
        self.addArc(withCenter: center,
                    radius: radius,
                    startAngle: .pi,
                    endAngle: .pi * 3 / 2,
                    clockwise: true)
        
        self.addArc(withCenter: center,
                    radius: radius,
                    startAngle: .pi * 3 / 2,
                    endAngle: 0,
                    clockwise: true)
        
        self.addArc(withCenter: center,
                    radius: radius,
                    startAngle: 0,
                    endAngle: .pi / 2,
                    clockwise: true)
        
        self.close()
    }
    
    func addCircleLeft(originalRect: CGRect, scale: CGFloat, move: Bool = false) {
        addCircleLeftBottom(originalRect: originalRect, scale: scale, move: move)
        addCircleLeftTop(originalRect: originalRect, scale: scale, move: move)
    }
    
    func addCircleRight(originalRect: CGRect, scale: CGFloat, move: Bool = false) {
        addCircleRightTop(originalRect: originalRect, scale: scale, move: move)
        addCircleRightBottom(originalRect: originalRect, scale: scale, move: move)
    }
    
    func addCircleLeftBottom(originalRect: CGRect, scale: CGFloat, move: Bool = false) {
        let scaledRect = drawableRect(originalRect: originalRect, scale: scale)
        let center = CGPoint(x: originalRect.width / 2, y: originalRect.height / 2)
        let radius = scaledRect.width / 2
        
        if move {
            self.move(to: CGPoint(x: originalRect.width / 2, y: scaledRect.origin.y + scaledRect.height))
        }
        
        self.addArc(withCenter: center,
                    radius: radius,
                    startAngle: .pi / 2,
                    endAngle: .pi,
                    clockwise: true)
    }
    
    func addCircleLeftTop(originalRect: CGRect, scale: CGFloat, move: Bool = false) {
        let scaledRect = drawableRect(originalRect: originalRect, scale: scale)
        let center = CGPoint(x: originalRect.width / 2, y: originalRect.height / 2)
        let radius = scaledRect.width / 2
        
        if move {
            self.move(to: CGPoint(x: scaledRect.origin.x, y: scaledRect.origin.y + scaledRect.height / 2))
        }
        
        self.addArc(withCenter: center,
                    radius: radius,
                    startAngle: .pi,
                    endAngle: .pi * 3 / 2,
                    clockwise: true)
    }
    
    func addCircleRightTop(originalRect: CGRect, scale: CGFloat, move: Bool = false) {
        let scaledRect = drawableRect(originalRect: originalRect, scale: scale)
        let center = CGPoint(x: originalRect.width / 2, y: originalRect.height / 2)
        let radius = scaledRect.width / 2
        
        if move {
            self.move(to: CGPoint(x: scaledRect.midX, y: scaledRect.origin.y))
        }
        
        self.addArc(withCenter: center,
                    radius: radius,
                    startAngle: .pi * 3 / 2,
                    endAngle: 0,
                    clockwise: true)
    }
    
    func addCircleRightBottom(originalRect: CGRect, scale: CGFloat, move: Bool = false) {
        let scaledRect = drawableRect(originalRect: originalRect, scale: scale)
        let center = CGPoint(x: originalRect.width / 2, y: originalRect.height / 2)
        let radius = scaledRect.width / 2
        
        if move {
            self.move(to: CGPoint(x: scaledRect.maxX, y: scaledRect.midY))
        }
        
        self.addArc(withCenter: center,
                    radius: radius,
                    startAngle: 0,
                    endAngle: .pi / 2,
                    clockwise: true)
    }
}
