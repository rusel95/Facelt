//
//  BlinkingFaceViewController.swift
//  Facelt
//
//  Created by Admin on 09.06.17.
//  Copyright © 2017 rusel95. All rights reserved.
//

import UIKit

class BlinkingFaceViewController: FaceViewController {

    var blinking = false {
        didSet {
            blinkIfNeeded()
        }
    }
    
    private struct BlinkRate {
        static let closedDuration: TimeInterval = 0.4
        static let openDuration: TimeInterval = 2.5
    }
    
    
    
    private func blinkIfNeeded() {
        if blinking {
            faceView.eyesOpen = false
            Timer.scheduledTimer(withTimeInterval: BlinkRate.closedDuration, repeats: false) { timer in
                self.faceView.eyesOpen = true
                Timer.scheduledTimer(withTimeInterval: BlinkRate.openDuration, repeats: false) { timer in
                    self.blinkIfNeeded()
                }
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        blinking = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        blinking = false
    }
    
    
    
}
