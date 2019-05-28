//
//  ViewController.swift
//  SadSpot
//
//  Created by asep abdaz on 25/05/19.
//  Copyright © 2019 Asep Abdaz. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    let layerGradient = CAGradientLayer()
    var motion = CMMotionManager()
    
    @IBOutlet weak var tapImageUIView: UIView!
    @IBOutlet weak var gradientUIView: UIView!
    @IBOutlet weak var emotionImageView: UIImageView!
    @IBOutlet weak var downArrowImageView: UIImageView!
    @IBOutlet weak var upArrowImageView: UIImageView!
    
    
    @IBOutlet weak var thridFactorImageView: UIImageView!
    @IBOutlet weak var secondFactorImageView: UIImageView!
    @IBOutlet weak var firstFactorImageVew: UIImageView!
    var status = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        layerGradient.frame = view.bounds
        layerGradient.colors = [UIColor.init(displayP3Red: 0.00, green: 0.00, blue: 0.22  , alpha: 1).cgColor, UIColor.init(displayP3Red: 0.27, green: 0.63, blue: 1.00 , alpha: 1).cgColor]
        
        gradientUIView.layer.addSublayer(layerGradient)
        
        accelerator()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(clickAction(_:)))
        tapGesture.delegate = self as? UIGestureRecognizerDelegate
        
//        emotionImageView.addGestureRecognizer(tapGesture)
        tapImageUIView.addGestureRecognizer(tapGesture)
        
        upArrowImageView.alpha = 0
        downArrowImageView.alpha = 0
        emotionImageView.alpha = 0
        firstFactorImageVew.alpha = 0
        secondFactorImageView.alpha = 0
        thridFactorImageView.alpha = 0
    }
    
    @objc func clickAction(_ sender: UIView){
        if status == true{
            trueAnimate()
            status = false
        }else{
            falseAnimate()
            status = true
        }
        
    }
    func trueAnimate() {
        UIView.animate(withDuration: 2, animations: {
            
        }) { (isFinished) in
            UIView.animate(withDuration: 1, animations: {
                self.firstFactorImageVew.alpha = 1
                self.secondFactorImageView.alpha = 1
                self.thridFactorImageView.alpha = 1
                self.emotionImageView.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
                
            })
        }
    }
    func falseAnimate() {
        UIView.animate(withDuration: 1, animations: {
            
        }) { (isFinished) in
            UIView.animate(withDuration: 2, animations: {
                self.firstFactorImageVew.alpha = 0
                self.secondFactorImageView.alpha = 0
                self.thridFactorImageView.alpha = 0
                self.emotionImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
            })
        }
    }
    func accelerator() {
        motion.accelerometerUpdateInterval = 0.1
        motion.startAccelerometerUpdates(to: OperationQueue.current!){ (data, error) in
            if let trueData = data {
                self.view.reloadInputViews()
                let x = trueData.acceleration.x
                let y = trueData.acceleration.y
                let z = trueData.acceleration.z
                
                self.layerGradient.startPoint = CGPoint(x: Double(0.5), y: Double(z))
                self.layerGradient.endPoint = CGPoint(x: Double(0.5), y: Double(z)+1.00000)
            
                if z >= 0.3{
                    UIView.animate(withDuration: 2, animations: {
                        sad()
                    })
                    
                    self.upArrowImageView.layer .removeAllAnimations()
                    self.downArrowImageView.layer .removeAllAnimations()

                }else if z >= -0.7 {
                    self.upArrowImageView.layer.animation
                    UIView.animate(withDuration: 4, delay: 0, options: .repeat, animations: {
                        arrow()
                    }, completion: { (isFinished) in
                        movementArrow()
                    })
                    
                }else{
                    UIView.animate(withDuration: 2, animations: {
                        happy()
                    })
                    self.upArrowImageView.layer.removeAllAnimations()
                    self.downArrowImageView.layer .removeAllAnimations()

                }
                
            }
        }
        
        func sad(){
            self.emotionImageView.alpha = 1
            self.emotionImageView.image = UIImage(named: "sad")
            self.upArrowImageView.alpha = 0
            self.downArrowImageView.alpha = 0
            self.firstFactorImageVew.image = UIImage(named: "couses1")
            self.secondFactorImageView.image = UIImage(named: "couses2")
            self.thridFactorImageView.image = UIImage(named: "couses3")
            self.downArrowImageView.center.y = 504
            self.upArrowImageView.center.y = 448.5
        }
        func happy(){
            self.emotionImageView.alpha = 1
            self.emotionImageView.image = UIImage(named: "joy")
            self.upArrowImageView.alpha = 0
            self.downArrowImageView.alpha = 0
            self.firstFactorImageVew.image = UIImage(named: "time")
            self.secondFactorImageView.image = UIImage(named: "family")
            self.thridFactorImageView.image = UIImage(named: "friend")
            self.downArrowImageView.center.y = 504
            self.upArrowImageView.center.y = 448.5

        }
//
        func arrow(){
            self.upArrowImageView.alpha = 1
            self.downArrowImageView.alpha = 1
            self.downArrowImageView.center.y = 504 + 150
            self.upArrowImageView.center.y = 448.5 - 150
//            print( self.upArrowImageView.center.y)
        }
        func movementArrow(){
            self.emotionImageView.alpha = 0
            self.firstFactorImageVew.alpha = 0
            self.secondFactorImageView.alpha = 0
            self.thridFactorImageView.alpha = 0
            status = true
            self.emotionImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
            
        }
    }


}

