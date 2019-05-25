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
    }
    
    @objc func clickAction(_ sender: UIView){
        print("any time")
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
            
                
                
            }
        }
    }


}

