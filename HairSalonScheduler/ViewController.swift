//
//  ViewController.swift
//  HairSalonScheduler
//
//  Created by Gregory Harston on 11/30/17.
//  Copyright © 2017 Paul Mason. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase

class ViewController: UIViewController {
    var ref : DatabaseReference!
    var passedArray = [clientStruct]()
    var client = [String: String]()
    var id : String!
    
    @IBOutlet var updateClient: UIButton!
    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    @IBOutlet var genderTextField: UITextField!
    @IBOutlet var areaCodeTextField: UITextField!
    @IBOutlet var officePrefixTextField: UITextField!
    @IBOutlet var lineNumberTextField: UITextField!
    @IBOutlet var addressTextField: UITextField!
    @IBOutlet var notesTextField: UITextView!
    
    override func viewDidLoad() {
        
        id = passedArray[0].id
        firstNameTextField.text =    passedArray[0].firstName
        lastNameTextField.text =     passedArray[0].lastName
        genderTextField.text =       passedArray[0].gender
        areaCodeTextField.text =     passedArray[0].areaCode
        officePrefixTextField.text = passedArray[0].officePrefix
        lineNumberTextField.text =   passedArray[0].lineNumber
        addressTextField.text =      passedArray[0].address
        notesTextField.text =        passedArray[0].notes
        
    }
    @IBAction func sendUpdate(_ sender: Any) {
        let ref = Database.database().reference().child("Clients").child((id)!)
        let client = ["First Name": firstNameTextField.text,
                      "Last Name:": lastNameTextField.text,
                      "Gender": genderTextField.text,
                      "AreaCode": areaCodeTextField.text,
                      "Office Prefix": officePrefixTextField.text,
                      "Line Number": lineNumberTextField.text,
                      "Address": addressTextField.text,
                      "Notes": notesTextField.text]
        ref.updateChildValues(client as Any as! [AnyHashable : Any])
        
        moveToClientTracker()
    }
    
    //navigate back to client tracker
    func moveToClientTracker() {
        _ = navigationController?.popToRootViewController(animated: true)
    }
    
}
