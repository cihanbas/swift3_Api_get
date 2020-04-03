//
//  ViewController.swift
//  JSONCrud
//
//  Created by cihanbas on 2.04.2020.
//  Copyright © 2020 cihanbas. All rights reserved.
//
/*
 1-) Request & Session
 2-) Response & Data
 1-) Parsing & JSON Serialization
 
 */
import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var liste = [String]()
    var identifierList = [String]()
    let person : Person? = nil
    var selectedItem = ""
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return liste.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = liste[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedItem = self.identifierList[indexPath.row]
        performSegue(withIdentifier: "toDetail", sender: nil)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail"{
            let destination = segue.destination as? DetailVC
            destination?.selectID = self.selectedItem
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "https://randomuser.me/api/?results=50")
        let session = URLSession.shared
        let task = session.dataTask(with: url!) { (data, response, error) in
            if error != nil{
                let alert = UIAlertController(title: "Error", message: error!.localizedDescription, preferredStyle:   UIAlertController.Style.alert)
                let alertButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default
                    , handler: nil)
                alert.addAction(alertButton)
                self.present(alert,animated: true,completion: nil)
            }
            if data != nil{
                do {
                    let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String,Any>
                    DispatchQueue.main.async {
                        //ßprint(jsonResponse["results"])
                        if let results = jsonResponse["results"] as? [[String:Any]]  {
                            for item in results   {
                                if let name = item["name"] as? [String:String] {
                                    let full_name = name["title"]! + " " + name["first"]! + " " + name["last"]!
                                    self.liste.append(full_name)
                                }
                                if let id = item["id"] as? [String:String] {
                                    let idValue = id["value"]!
                                    self.identifierList.append(idValue)
                                }
                                
                            }
                            self.tableView.reloadData()
                            
                        }
                    }
                } catch  {
                    print("error")
                }
            }
            
            
        }
        task.resume()
        tableView.dataSource = self
        tableView.delegate = self
        
        
    }
    
}

