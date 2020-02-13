//
//  HeartView.swift
//  DrawHeartDemo
//
//  Created by xiaoyouxinqing on 2/12/20.
//  Copyright © 2020 xiaoyouxinqing. All rights reserved.
//

import UIKit

private let kDrawScale: CGFloat = 1
private let kAnimationDuration = 2.0
private let kAnimationDelay = 0.5

protocol HeartViewDelegate: AnyObject {
    func heartViewAnimationDidFinish()
}

class HeartView: UIView {
    weak var delegate: HeartViewDelegate?
    
    private var imageView: UIImageView!
    private var imageMask: UIView!
    
    private var tipLabel: UILabel!
    
    private var shapeLayer: CAShapeLayer!
    private var shapeLeft: CAShapeLayer!
    private var shapeRight: CAShapeLayer!
    
    private var defaultShape: CAShapeLayer {
        let shape = CAShapeLayer()
        shape.frame = bounds
        shape.strokeColor = UIColor.red.cgColor
        shape.fillColor = UIColor.clear.cgColor
        return shape
    }
    
    init(frame: CGRect, image: UIImage?) {
        super.init(frame: frame)
        
        imageView = UIImageView(frame: bounds)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = image
        imageView.isHidden = true
        addSubview(imageView)
        
        imageMask = UIView(frame: bounds)
        addSubview(imageMask)
        
        
        tipLabel = UILabel(frame: bounds)
        tipLabel.font = .boldSystemFont(ofSize: 100)
        tipLabel.textAlignment = .center
        tipLabel.text = "?"
        addSubview(tipLabel)
        
        shapeLayer = defaultShape
        layer.addSublayer(shapeLayer)
        
        shapeLeft = defaultShape
        let pathLeft = UIBezierPath()
        pathLeft.addCircleLeft(originalRect: bounds, scale: kDrawScale, move: true)
        shapeLeft.path = pathLeft.cgPath
        layer.addSublayer(shapeLeft)
        
        shapeRight = defaultShape
        let pathRight = UIBezierPath()
        pathRight.addCircleRight(originalRect: bounds, scale: kDrawScale, move: true)
        shapeRight.path = pathRight.cgPath
        layer.addSublayer(shapeRight)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(onTap(_:)))
        addGestureRecognizer(tap)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func onTap(_ tap: UITapGestureRecognizer) {
        tap.isEnabled = false
        
        UIView.animate(withDuration: kAnimationDuration) {
            self.tipLabel.alpha = 0
        }
        
        CATransaction.begin()
        
        CATransaction.setCompletionBlock { [weak self] in
            guard let self = self else { return }
            self.strokeHeartAnimation()
        }
        
        let animationLeft = CABasicAnimation(keyPath: "strokeStart")
        animationLeft.fromValue = 0
        animationLeft.toValue = 1
        animationLeft.duration = kAnimationDuration
        animationLeft.isRemovedOnCompletion = false
        animationLeft.fillMode = .forwards
        shapeLeft.add(animationLeft, forKey: "")

        let animationRight = CABasicAnimation(keyPath: "strokeEnd")
        animationRight.fromValue = 1
        animationRight.toValue = 0
        animationRight.duration = kAnimationDuration
        animationRight.isRemovedOnCompletion = false
        animationRight.fillMode = .forwards
        shapeRight.add(animationRight, forKey: "")
        
        CATransaction.commit()
    }
    
    private func strokeHeartAnimation() {
        CATransaction.begin()
        
        CATransaction.setCompletionBlock { [weak self] in
            guard let self = self else { return }
            self.heartColorAnimation()
        }
        
        let pathLeft = UIBezierPath()
        pathLeft.addHeartLeft(originalRect: self.bounds, scale: kDrawScale, move: true)
        self.shapeLeft.path = pathLeft.cgPath
        
        let animationLeft = CABasicAnimation(keyPath: "strokeStart")
        animationLeft.fromValue = 1
        animationLeft.toValue = 0
        animationLeft.duration = kAnimationDuration
        animationLeft.isRemovedOnCompletion = false
        animationLeft.fillMode = .forwards
        animationLeft.beginTime = CACurrentMediaTime() + kAnimationDelay
        self.shapeLeft.add(animationLeft, forKey: "")
        
        let pathRight = UIBezierPath()
        pathRight.addHeartRight(originalRect: self.bounds, scale: kDrawScale, move: true)
        self.shapeRight.path = pathRight.cgPath
        
        let animationRight = CABasicAnimation(keyPath: "strokeEnd")
        animationRight.fromValue = 0
        animationRight.toValue = 1
        animationRight.duration = kAnimationDuration
        animationRight.isRemovedOnCompletion = false
        animationRight.fillMode = .forwards
        animationRight.beginTime = CACurrentMediaTime() + kAnimationDelay
        self.shapeRight.add(animationRight, forKey: "")
        
        CATransaction.commit()
    }
    
    private func heartColorAnimation() {
        CATransaction.begin()
        
        CATransaction.setCompletionBlock { [weak self] in
            guard let self = self else { return }
            
            self.shapeLeft.strokeColor = nil
            self.shapeRight.strokeColor = nil
            
            self.layer.mask = self.shapeLayer
            self.imageView.isHidden = false
            self.imageMask.backgroundColor = .red
            
            UIView.animate(withDuration: kAnimationDuration, delay: kAnimationDelay, options: .curveEaseInOut, animations: {
                self.imageMask.alpha = 0
            }) { _ in
                self.delegate?.heartViewAnimationDidFinish()
            }
            
            let animation = CABasicAnimation(keyPath: "strokeColor")
            animation.toValue = UIColor.clear.cgColor
            animation.duration = kAnimationDuration
            animation.isRemovedOnCompletion = false
            animation.fillMode = .forwards
            self.shapeLayer.add(animation, forKey: "")
        }
        
        let path = UIBezierPath()
        path.addHeart(originalRect: self.bounds, scale: kDrawScale)
        self.shapeLayer.path = path.cgPath
        
        let animation = CABasicAnimation(keyPath: "fillColor")
        animation.fromValue = UIColor.clear.cgColor
        animation.toValue = UIColor.red.cgColor
        animation.duration = kAnimationDuration
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards
        animation.beginTime = CACurrentMediaTime() + kAnimationDelay
        self.shapeLayer.add(animation, forKey: "")
        
        CATransaction.commit()
    }
}
