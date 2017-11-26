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
    
    var pulledData: UInt!

    override func viewDidLoad() {
        
        //Firebase DATABASE Connection Code
        FirebaseApp.configure()
        
        refDatabase = Database.database(url: "https://hairsalonscheduler.firebaseio.com/").reference(fromURL: "https://hairsalonscheduler.firebaseio.com/").child("Clients")
        
        //pulledData = refDatabase.observe(DataEventType.value, with: { (snapshot) in
          //  _ = snapshot.value as? [String : AnyObject] ?? [:]
            // ...
        //})
        //refHandle = refDatabase.observe(.value, with
                
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

