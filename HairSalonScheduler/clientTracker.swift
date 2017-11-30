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
import FirebaseDatabase


struct clientStruct {
    let address : String!
    let gender : String!
    let areaCode : String!
    let officePrefix : String!
    let lineNumber : String!
    let firstName : String!
    let lastName : String!
}

class clientTracker: UITableViewController{
    var ref : DatabaseReference!
    
    var clients = [clientStruct]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        
        ref = Database.database().reference()
        //ref.child("Clients").queryOrderedByKey().observe(.value, with: { DataSnapshot in
        
            
        ref.child("Clients").observe(.childAdded, with: { DataSnapshot in
            // store key value for each client
            //let key = DataSnapshot.key
            // put each client in a dictionary for array access.
            
            
            let client = DataSnapshot.value as! NSDictionary
            
            let areaCode = client["AreaCode"] as! String
            let firstName = client["First Name"] as! String
            let lastName = client["Last Name:"] as! String
            let gender = client["Gender"] as! String
            let lineNumber = client["Line Number"] as! String
            let officePrefix = client["Office Prefix"] as! String
            let address = client["Address"] as! String
            
            self.clients.append(clientStruct(address: address, gender: gender, areaCode: areaCode, officePrefix: officePrefix, lineNumber: lineNumber, firstName: firstName, lastName: lastName))
            
            self.tableView.reloadData()
            print("Number of Clients")
            print(self.clients.count)
            print(self.clients)
             
        })
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        // #warning Incomplete implementation, return the number of rows
        return clients.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell")
        
        let label1 = cell?.viewWithTag(1) as! UILabel
        label1.text = clients[indexPath.row].firstName + " " + clients[indexPath.row].lastName
        
        let label2 = cell?.viewWithTag(2) as! UILabel
        label2.text = "(" + clients[indexPath.row].areaCode + ")" + clients[indexPath.row].officePrefix + "-" + clients[indexPath.row].lineNumber
        
        let label3 = cell?.viewWithTag(3) as! UILabel
        label3.text = clients[indexPath.row].address
        
        let label4 = cell?.viewWithTag(4) as! UILabel
        label4.text = clients[indexPath.row].gender
        return cell!
    }

    //override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //    <#code#>
    //}
    
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
