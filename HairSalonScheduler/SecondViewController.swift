//
//  SecondViewController.swift
//  HairSalonScheduler
//
//  Created by Paul Mason on 11/7/17.
//  Copyright © 2017 Paul Mason. All rights reserved.
//

import UIKit
import Firebase
// new client
class SecondViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate{
    var alertController: UIAlertController?
    var alertTimer: Timer?
    var remainingTime = 0
    var baseMessage: String?
    // image view for photo upload
    @IBOutlet var imageView: UIImageView!
    
    // variables
    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    @IBOutlet var genderTextField: UITextField!
    @IBOutlet var areaCodeTextField: UITextField!
    @IBOutlet var officePrefixTextField: UITextField!
    @IBOutlet var lineNumberTextField: UITextField!
    @IBOutlet var addressTextField: UITextField!
    @IBOutlet var notesTextField: UITextView!
    
    // gender array
    let gender = ["Male",
                  "Female"]
    
    // needed variable to save gender input
    var selectedGender: String?
    
    //firebase DATABASE variable
    var refDatabase: DatabaseReference!
    
    //firebase STORAGE variable
    //var refStorage: StorageReference!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Firebase DATABASE Connection Code
        FirebaseApp.configure()
        
        refDatabase = Database.database(url: "https://hairsalonscheduler.firebaseio.com/").reference(fromURL: "https://hairsalonscheduler.firebaseio.com/").child("Clients")
        
        //Firebase STORAGE Connection Code
        //refStorage = Storage.storage(url: "https//hairsalonscheduler.appspot.com").reference(forURL: "https//hairsalonscheduler.appspot.com").child("Profile Images")
        
        
        // Do any additional setup after loading the view, typically from a nib.
        createGenderPicker()
        createToolBar()
        self.areaCodeTextField.delegate = self
        self.officePrefixTextField.delegate = self
        self.lineNumberTextField.delegate = self
    }
    
    @IBAction func createClient(_ sender: Any) {
        if !hasErrors(){
            
            addNewClient()
            
            moveToFirstViewController()
        }
    }
    
    func moveToFirstViewController() {
        self.tabBarController?.selectedIndex = 1
    }
    
    func hasErrors() -> Bool{
        var errors = false
        let title = "ERROR"
        var message = ""
        //check first name field
        if firstNameTextField.text!.isEmpty {
            errors = true
            message += "First Name is Empty\nPlease fill in all fields"
            alertWithTitle(title: title, message: message, SecondViewController: self, toFocus: firstNameTextField)
        }
        //check last name field
        else if lastNameTextField.text!.isEmpty {
            errors = true
            message += "Last Name is Empty\nPlease fill in all fields"
            alertWithTitle(title: title, message: message, SecondViewController: self, toFocus: lastNameTextField)
        }
        //check gender field
        else if genderTextField.text!.isEmpty {
            errors = true
            message += "Gender is Empty\nPlease fill in all fields"
            alertWithTitle(title: title, message: message, SecondViewController: self, toFocus: genderTextField)
        }
        //check phone number fields
        else if areaCodeTextField.text!.isEmpty {
            errors = true
            message += "Area Code is Empty\nPlease fill in all fields"
            alertWithTitle(title: title, message: message, SecondViewController: self, toFocus: areaCodeTextField)
        }
        else if officePrefixTextField.text!.isEmpty {
            errors = true
            message += "Office Prefix is Empty\nPlease fill in all fields"
            alertWithTitle(title: title, message: message, SecondViewController: self, toFocus: officePrefixTextField)
        }
        else if lineNumberTextField.text!.isEmpty {
            errors = true
            message += "Line Number is Empty\nPlease Fill in all fields"
            alertWithTitle(title: title, message: message, SecondViewController: self, toFocus: lineNumberTextField)
        }
        //check address field
        else if addressTextField.text!.isEmpty {
            errors = true
            message += "Address is Empty\nPlease Fill in all fields"
            alertWithTitle(title: title, message: message, SecondViewController: self, toFocus: addressTextField)
        }
        //check notes field
        else if notesTextField.text.isEmpty {
            errors = true
            message += "Notes is Empty\nPlease Fill in all fields"
            viewAlertWithTitle(title: title, message: message, SecondViewController: self, toFocus: notesTextField)
        }
        return errors
    }
    
    func alertWithTitle(title: String!, message: String, SecondViewController: UIViewController, toFocus:UITextField) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel,handler: {_ in
            toFocus.becomeFirstResponder()
        });
        alert.addAction(action)
        SecondViewController.present(alert, animated: true, completion:nil)
    }
    func viewAlertWithTitle(title: String!, message: String, SecondViewController: UIViewController, toFocus:UITextView) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel,handler: {_ in
            toFocus.becomeFirstResponder()
        });
        alert.addAction(action)
        SecondViewController.present(alert, animated: true, completion:nil)
    }
    
    //function to add info to database
    func addNewClient(){
        print("adding new client to the database")
        
        let key = refDatabase.childByAutoId().key
        
        let client = ["id": key,
                    "First Name": firstNameTextField.text! as String,
                    "Last Name:": lastNameTextField.text! as String,
                    "Gender": genderTextField.text! as String,
                    "AreaCode": areaCodeTextField.text! as String,
                    "Office Prefix": officePrefixTextField.text! as String,
                    "Line Number": lineNumberTextField.text! as String,
                    "Address": addressTextField.text! as String,
                    "Notes": notesTextField.text! as String];
        
        refDatabase.child(key).setValue(client)
        
        self.showAlertMsg(title: "Success", message: "New Client Created", time: 3)
        
        //let uploadTask = refStorage.putFile(from: imageView, metadata: nil) { metadata, error in
            //if let error = error {
                // Uh-oh, an error occurred!
            //} else {
                // Metadata contains file metadata such as size, content-type, and download URL.
                //let downloadURL = metadata!.downloadURL()
            //}
        
        
    }
    
    func showAlertMsg(title: String, message: String, time: Int) {
        
        guard (self.alertController == nil) else {
            print("Alert already displayed")
            return
        }
        
        self.baseMessage = message
        self.remainingTime = time
        
        self.alertController = UIAlertController(title: title, message: self.alertMessage(), preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            print("Alert was cancelled")
            self.alertController=nil;
            self.alertTimer?.invalidate()
            self.alertTimer=nil
        }
        
        self.alertController!.addAction(cancelAction)
        
        self.alertTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(SecondViewController.countDown), userInfo: nil, repeats: true)
        
        self.present(self.alertController!, animated: true, completion: nil)
    }
    func countDown() {
        
        self.remainingTime -= 1
        if (self.remainingTime < 0) {
            self.alertTimer?.invalidate()
            self.alertTimer = nil
            self.alertController!.dismiss(animated: true, completion: {
                self.alertController = nil
            })
        } else {
            self.alertController!.message = self.alertMessage()
        }
        
    }
    
    func alertMessage() -> String {
        var message=""
        if let baseMessage=self.baseMessage {
            message=baseMessage+" "
        }
        return(message+"\(self.remainingTime)")
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String)-> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        
        return allowedCharacters.isSuperset(of: characterSet)
    }

    @IBAction func takePhoto(_ sender: Any) {
        let image = UIImagePickerController()
        image.delegate = self
        
        image.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        image.allowsEditing = false
        
        self.present(image, animated: true, completion: nil)
    }
    
    func createGenderPicker() {
        let genderPicker = UIPickerView()
        genderPicker.delegate = self
        
        genderTextField.inputView = genderPicker
    }
    
    func createToolBar() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(SecondViewController.dismissKeyboard))
        
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        genderTextField.inputAccessoryView = toolBar
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    // function for picking the image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            imageView.image = image
        }
        else
        {
            // error message
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
extension SecondViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return gender.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return gender[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedGender = gender[row]
        genderTextField.text = selectedGender
    }
}

