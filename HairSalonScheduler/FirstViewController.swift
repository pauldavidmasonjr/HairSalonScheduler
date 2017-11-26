//
//  FirstViewController.swift
//  HairSalonScheduler
//
//  Created by Paul Mason on 11/7/17.
//  Copyright © 2017 Paul Mason. All rights reserved.
//

import UIKit
import Firebase


class FirstViewController: UIViewController {
    
    //firebase DATABASE variable
    var refDatabase: DatabaseReference!

    override func viewDidLoad() {
        
        
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Firebase DATABASE Connection Code
        FirebaseApp.configure()
        
        refDatabase = Database.database(url: "https://hairsalonscheduler.firebaseio.com/").reference(fromURL: "https://hairsalonscheduler.firebaseio.com/").child("Clients")
        
        print("Hello 1")
        
        //createDataSource()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidAppear(_ animated: Bool)
    {
        
        //let userId:String = UserDefaults.standard.value(forKey: "UserId") as! String
        
        let clientDatabase = Database.database(url: "https://hairsalonscheduler.firebaseio.com/").reference(fromURL: "https://hairsalonscheduler.firebaseio.com/").child("Clients")
        
        clientDatabase.observe(.value, with: { snapshot in
            var i = 0
            //self.books.removeAll()
            for element in snapshot.children
            {
                i = i + 1
                
                let item:DataSnapshot = element as! DataSnapshot;
                let postDict = item.value as! [String : AnyObject];
                let key = item.key;
                
                let clientRef = Database.database(url: "https://hairsalonscheduler.firebaseio.com/").reference(fromURL: "https://hairsalonscheduler.firebaseio.com/").child("Clients")
                clientRef.observe(.value, with: { snapshot in
                    
                    let client = (snapshot ).value as! [String : AnyObject]
                    let id = clientRef.key
                    print(id)
                    let record = [client["First Name"] as! String, client["Last Name"] as! String]
                    
                    let firstname = client["First Name"] as! String
                    
                    let item = [firstname]
                    
                    print("HHHHHHHHEEEEEEEELLLLLLLLLOOOOOOOOOOOOOOO     :   ", item)
                })
                
            }
            
        })
        
    }


}

