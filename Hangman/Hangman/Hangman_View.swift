//
//  Hangman_View.swift
//  Hangman
//
//  Created by Daniel Hjärtström on 2017-07-22.
//  Copyright © 2017 Daniel Hjärtström. All rights reserved.
//

import UIKit

class Hangman_View: UIView {

    var layers:[CAShapeLayer] = []
    var paths: [UIBezierPath] = []
    var viewLayer: CAShapeLayer? = nil
    var viewPath: UIBezierPath? = nil
    
    func animate(number: Int){

        viewPath = UIBezierPath()
        viewLayer = self.returnLayer()
        
        guard let myLayer = viewLayer, let path = viewPath else {
            return
        }
        
        myLayer.add(returnStrokeEndAnimation(), forKey: "myStroke")
    
        switch number {
        
        case 0: // Gallows
        
            // Bottom
            path.move(to: CGPoint(x: self.frame.width * 0.3, y: self.frame.height * 0.9))
            path.addLine(to: CGPoint(x: self.frame.width * 0.3, y: self.frame.height * 0.8))
            path.addLine(to: CGPoint(x: self.frame.width * 0.7, y: self.frame.height * 0.8))
            path.addLine(to: CGPoint(x: self.frame.width * 0.7, y: self.frame.height * 0.9))

            // Pole
            path.move(to: CGPoint(x: self.frame.width * 0.6, y: self.frame.height * 0.8))
            path.addLine(to: CGPoint(x: self.frame.width * 0.6, y: self.frame.height * 0.2))
            path.addLine(to: CGPoint(x: self.frame.width * 0.4, y: self.frame.height * 0.2))

            // Angle
            path.move(to: CGPoint(x: self.frame.width * 0.6, y: self.frame.height * 0.35))
            path.addLine(to: CGPoint(x: self.frame.width * 0.5, y: self.frame.height * 0.2))
            drawPath(index: number, path: path, myLayer: myLayer)
            
            break
        
        case 1: // Body
            
            path.move(to: CGPoint(x: self.frame.width * 0.4, y: self.frame.height * 0.45))
            path.addLine(to: CGPoint(x: self.frame.width * 0.4, y: self.frame.height * 0.6))
            drawPath(index: number, path: path, myLayer: myLayer)

            break
        
        case 2: // Right arm from view
            
            path.move(to: CGPoint(x: self.frame.width * 0.4, y: self.frame.height * 0.5))
            path.addLine(to: CGPoint(x: self.frame.width * 0.45, y: self.frame.height * 0.55))
            drawPath(index: number, path: path, myLayer: myLayer)

            break
       
        case 3: // Left arm (from view)
            
            path.move(to: CGPoint(x: self.frame.width * 0.4, y: self.frame.height * 0.5))
            path.addLine(to: CGPoint(x: self.frame.width * 0.35, y: self.frame.height * 0.55))
            drawPath(index: number, path: path, myLayer: myLayer)

            break
        
        case 4: // Right leg
            
            path.move(to: CGPoint(x: self.frame.width * 0.4, y: self.frame.height * 0.6))
            path.addLine(to: CGPoint(x: self.frame.width * 0.43, y: self.frame.height * 0.7))
            drawPath(index: number, path: path, myLayer: myLayer)

            break
        
        case 5: // Left leg
            
            path.move(to: CGPoint(x: self.frame.width * 0.4, y: self.frame.height * 0.6))
            path.addLine(to: CGPoint(x: self.frame.width * 0.37, y: self.frame.height * 0.7))
            drawPath(index: number, path: path, myLayer: myLayer)

            break
        
        case 6: // Head
            
            path.move(to: CGPoint(x: self.frame.width * 0.385, y: self.frame.height * 0.45))
            path.addArc(withCenter: CGPoint(x: self.frame.width * 0.4, y: self.frame.height * 0.4), radius: self.frame.width * 0.03, startAngle: CGFloat(Double.pi), endAngle: 360.0, clockwise: true)
            drawPath(index: number, path: path, myLayer: myLayer)

            break
        
        case 7: // Nuse
            
            let nusePath = UIBezierPath()
            
            nusePath.move(to: CGPoint(x: self.frame.width * 0.4, y: self.frame.height * 0.2))
            nusePath.addLine(to: CGPoint(x: self.frame.width * 0.4, y: self.frame.height * 0.35))
    
            myLayer.removeAllAnimations()
            myLayer.add(self.returnSwingAnimation(), forKey: "rotation")
            
            for i in (1..<self.layers.count).reversed() {
                
                nusePath.append(self.paths[i])
                self.layers[i].removeFromSuperlayer()
            }
            
            myLayer.path = nusePath.cgPath
            myLayer.anchorPoint = CGPoint(x: 0.39, y: 0.2)
            myLayer.frame = self.bounds
            drawPath(index: number, path: nusePath, myLayer: myLayer)
            
            break
        default:
            return
        }
    }
    
    func drawPath(index: Int, path: UIBezierPath, myLayer: CAShapeLayer){

        paths.append(path)
        myLayer.path = paths[index].cgPath
        layers.append(myLayer)
        self.layer.addSublayer(layers[index])
    
    }
    
    func returnLayer() -> CAShapeLayer {
    
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = self.bounds
        shapeLayer.lineWidth = 7.0
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.white.cgColor
        shapeLayer.lineCap = kCALineCapRound // Round edges of stroke
        return shapeLayer
    }
    
    func returnStrokeEndAnimation() -> CABasicAnimation {
    
        let strokeEndAnimation = CABasicAnimation(keyPath: "strokeEnd")
        strokeEndAnimation.fromValue = Float(0.0)
        strokeEndAnimation.toValue = Float(1.0)
        strokeEndAnimation.duration = 2.0
        
        return strokeEndAnimation
    }
    
    func returnSwingAnimation() -> CABasicAnimation {

        let swingAnimation = CABasicAnimation(keyPath: "transform.rotation")
        swingAnimation.fromValue = -0.15
        //swingAnimation.beginTime = CACurrentMediaTime() + 1.0
        swingAnimation.toValue = 0.15
        swingAnimation.duration = 2.0
        swingAnimation.autoreverses = true
        swingAnimation.repeatCount = .infinity
        swingAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
    
        return swingAnimation
    }
    
    func reset(){
    
        self.layers.removeAll()
        self.paths.removeAll()
        self.layer.sublayers?.removeAll()
    }
    
    func delay(_ delay: Double, closure: @escaping ()->()){
        let when = DispatchTime.now() + delay
        DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
    }
}
