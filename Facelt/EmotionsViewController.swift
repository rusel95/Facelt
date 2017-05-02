//
//  EmotionsViewController.swift
//  Facelt
//
//  Created by Admin on 02.05.17.
//  Copyright © 2017 rusel95. All rights reserved.
//

import UIKit

class EmotionsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var destinationController = segue.destination
        
        //if we have a navigationController receiver instead of just ViewController
        if let navigationController = destinationController as? UINavigationController {
            //shows visible cart in stack of controller
            destinationController = navigationController.visibleViewController ?? destinationController
        }
        
        if let faceViewController = destinationController as? FaceViewController,
            let identifier = segue.identifier,
            let expression = emotionalFaces[identifier] {
                faceViewController.expression = expression
                faceViewController.navigationItem.title = (sender as? UIButton)?.currentTitle
        }
    }
    
    private let emotionalFaces: Dictionary<String,FacialExpression> = [
        "sad" : FacialExpression(eyes: .closed, mouth: .frown),
        "happy" : FacialExpression(eyes: .open, mouth: .smile),
        "worried" : FacialExpression(eyes: .open, mouth: .smirk)
    ]
}
