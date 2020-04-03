//
//  DetailVC.swift
//  JSONCrud
//
//  Created by cihanbas on 3.04.2020.
//  Copyright © 2020 cihanbas. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {
    var selectID = ""
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var imageVC: UIImageView!
    @IBOutlet weak var addressLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("selectID",selectID)
        
        if selectID != ""{
            let url = URL(string: "https://randomuser.me/api/?id="+selectID)
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
                                        self.nameLabel.text = full_name
                                    }
                                    if let phone = item["phone"] as? String {
                                        
                                        self.phoneLabel.text = phone
                                    }
                                    if let email = item["email"] as? String {
                                        
                                        self.emailLabel.text = email
                                    }
                                    if let location = item["location"] as? [String:String] {
                                        
                                        self.addressLabel.text = location["city"]
                                    }
                                    if let image = item["picture"] as? [String:String]{
                                        let imageURL = image["large"]
                                        let url = URL(string:imageURL!)
                                        let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                                        
                                        self.imageVC.image = UIImage(data:data! )
                                    }
                                }
                                
                            }
                        }
                    } catch  {
                        print("error")
                    }
                }
                
                
            }
            task.resume()
        }
        // Do any additional setup after loading the view.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
