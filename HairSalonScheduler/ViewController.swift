//
//  ViewController.swift
//  HairSalonScheduler
//
//  Created by Gregory Harston on 11/30/17.
//  Copyright © 2017 Paul Mason. All rights reserved.
//

import Foundation
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    @IBOutlet var genderTextField: UITextField!
    @IBOutlet var areaCodeTextField: UITextField!
    @IBOutlet var officePrefixTextField: UITextField!
    @IBOutlet var lineNumberTextField: UITextField!
    @IBOutlet var addressTextField: UITextField!
    @IBOutlet var notesTextField: UITextView!
    
    @IBOutlet var updateButton: UIButton!
    
    var passedArray = [clientStruct]()
    
    override func viewDidLoad() {
        
        firstNameTextField.text =    passedArray[0].firstName
        lastNameTextField.text =     passedArray[0].lastName
        genderTextField.text =       passedArray[0].gender
        areaCodeTextField.text =     passedArray[0].areaCode
        officePrefixTextField.text = passedArray[0].officePrefix
        lineNumberTextField.text =   passedArray[0].lineNumber
        addressTextField.text =      passedArray[0].address
        notesTextField.text =        passedArray[0].notes
        
    }
}
