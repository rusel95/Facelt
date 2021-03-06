//
//  ViewController.swift
//  Facelt
//
//  Created by Admin on 18.04.17.
//  Copyright © 2017 rusel95. All rights reserved.
//

import UIKit

class FaceViewController: VCLLoggingViewController {

    @IBOutlet weak var faceView: FaceView! {
        didSet {
            
            let handler = #selector(FaceView.changeScale(byReactingTo:))
            let pinchRecognizer = UIPinchGestureRecognizer(target: faceView, action: handler)
            faceView.addGestureRecognizer(pinchRecognizer)
            
//            let tapRecognizer = UITapGestureRecognizer( target: self, action: #selector(toggleEyes(byReactiongTo:)) )
//            tapRecognizer.numberOfTapsRequired = 1
//            faceView.addGestureRecognizer(tapRecognizer)
            
            let swipeUpRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(increaseHappiness))
            swipeUpRecognizer.direction = .up
            let swipeDownRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(decreaseHappiness))
            swipeDownRecognizer.direction = .down
            faceView.addGestureRecognizer(swipeUpRecognizer)
            faceView.addGestureRecognizer(swipeDownRecognizer)
            
            updateUI()
        }
    }
    
    
    private struct HeadShake {
        static let angle = CGFloat.pi / 6
        static let segmentedDuration: TimeInterval = 0.5
    }
    
    private func rotateFace(by angle: CGFloat) {
        faceView.transform = faceView.transform.rotated(by: angle)
    }
    
    private func shakeHead() {
        UIView.animate(
            withDuration: HeadShake.segmentedDuration,
            animations: { self.rotateFace(by: HeadShake.angle) },
            completion: { finished in
                if finished {
                    UIView.animate(
                        withDuration: HeadShake.segmentedDuration,
                        animations: { self.rotateFace(by: -HeadShake.angle * 2) },
                        completion: { finished in
                                UIView.animate(
                                    withDuration: HeadShake.segmentedDuration,
                                    animations: { self.rotateFace(by: HeadShake.angle) } )
                        })
                }
            })
    }
    
    
    
    
    @IBAction func shakeHead(_ sender: UITapGestureRecognizer) {
        shakeHead()
    }
    func increaseHappiness() {
        expression = expression.happier
    }
    
    func decreaseHappiness() {
        expression = expression.sadder
    }

    func toggleEyes(byReactiongTo tapRecognizer: UITapGestureRecognizer) {
        if tapRecognizer.state == .ended {
            let eyes: FacialExpression.Eyes = (expression.eyes == .closed) ? .open : .closed
            expression = FacialExpression(eyes: eyes, mouth: expression.mouth)
        }
    }
    
    var expression = FacialExpression(eyes: .closed, mouth: .frown) {
        didSet {
            updateUI()
        }
    }
    
    func updateUI() {
        switch expression.eyes {
        case .open:
            faceView?.eyesOpen = true
        case .closed:
            faceView?.eyesOpen = false
        case .squinting:
//            faceView?.eyesOpen = false
                break
        }
        faceView?.mouthCurvature = mouthCurvature[expression.mouth] ?? 0
    }
    
    private let mouthCurvature = [ FacialExpression.Mouth.grin: 0.5, .frown: -1.0, .smile: 1.0, .neutral: 0.0, .smirk: -0.5 ]
    
}

