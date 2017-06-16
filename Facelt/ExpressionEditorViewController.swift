//
//  ExpressionEditorViewController.swift
//  Facelt
//
//  Created by Admin on 16.06.17.
//  Copyright © 2017 rusel95. All rights reserved.
//

import UIKit

class ExpressionEditorViewController: UITableViewController, UITextFieldDelegate {
    
    var name: String {
        return nameTextField.text ?? ""
    }
    
    private let eyeChoices = [FacialExpression.Eyes.open, .closed, .squinting]
    private let mouthChoices = [FacialExpression.Mouth.frown, .smirk, .neutral, .grin, .smile]
    
    var expression: FacialExpression {
        return FacialExpression(
            eyes: eyeChoices[ eyeControl.selectedSegmentIndex ],
            mouth: mouthChoices[ mouthControl.selectedSegmentIndex ]
        )
    }
    
    @IBAction func updateFace() {
        faceViewController?.expression = expression
    }
    @IBOutlet weak var eyeControl: UISegmentedControl!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var mouthControl: UISegmentedControl!
    
    
    private var faceViewController: BlinkingFaceViewController?
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Embed Face" {
            faceViewController = segue.destination as? BlinkingFaceViewController
            faceViewController?.expression = expression
        }
    }
    
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 1 {
            return tableView.bounds.size.width
        } else {
            return super.tableView(tableView, heightForRowAt: indexPath)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
