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
        addNewClient()
    }
    //function to add info to database
    func addNewClient(){
        
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
        
        //let uploadTask = refStorage.putFile(from: imageView, metadata: nil) { metadata, error in
            //if let error = error {
                // Uh-oh, an error occurred!
            //} else {
                // Metadata contains file metadata such as size, content-type, and download URL.
                //let downloadURL = metadata!.downloadURL()
            //}
        
        
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

