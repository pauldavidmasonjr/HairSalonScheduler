//
//  clientTracker.swift
//  HairSalonScheduler
//
//  Created by Gregory Harston on 11/28/17.
//  Copyright © 2017 Paul Mason. All rights reserved.
//

import UIKit
import Foundation
import Firebase

struct clientStruct {
    let AreaCode: String!
    let firstName: String!
    let lastName: String!
    let gender: String!
    let lineNumber: String!
    let officePrefix: String!
    let address: String!
}

class clientTracker: UITableViewController {
    var ref : DatabaseReference!
    
    var clients = [clientStruct]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        
        ref.child("Clients").observe(.childAdded, with: { DataSnapshot in
            // store key value for each client
            let key = DataSnapshot.key
            
            // put each client in a dictionary for array access.
            let client = DataSnapshot.value as! NSDictionary
            
            let areaCode = client["AreaCode"] as! String
            let firstName = client["First Name"] as! String
            let lastName = client["Last Name:"] as! String
            let gender = client["Gender"] as! String
            let lineNumber = client["Line Number"] as! String
            let officePrefix = client["Office Prefix"] as! String
            let address = client["Address"] as! String
            
            self.clients.append(clientStruct(AreaCode: areaCode, firstName: firstName, lastName: lastName, gender: gender, lineNumber: lineNumber, officePrefix: officePrefix, address: address))

            print("Number of Clients")
            print(self.clients.count)
            print(self.clients)
        })
        
        
        
    }
    
    func getClients()
    {
        
    
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
