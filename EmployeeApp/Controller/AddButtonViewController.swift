//
//  AddButtonViewController.swift
//  EmployeeApp
//
//  Created by IT on 11/5/20.
//  Copyright © 2020 IT. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
protocol DataPass {
    func dataPassing(response : PostResponse)
}
class AddButtonViewController: UIViewController ,UITextFieldDelegate {
    
    @IBOutlet weak var nameAdd: UITextField!
    @IBOutlet weak var ageAdd: UITextField!
    @IBOutlet weak var salaryAdd: UITextField!
    @IBOutlet weak var addbtn: UIButton!
    var viewModelEmployee = EmployeeViewModel()
    var Name: String?
    var Age: String?
    var Salary: String?
    var ID: Int?
    var Strid :String?
    var delegate: DataPass!
    override func viewDidLoad() {
        super.viewDidLoad()
        customButtonDisplay()
        self.nameAdd.delegate = self
        self.ageAdd.delegate = self
        self.salaryAdd.delegate = self
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameAdd.resignFirstResponder()
        ageAdd.resignFirstResponder()
        salaryAdd.resignFirstResponder()
        return true
    }
    @IBAction func add(_ sender: Any) {
        if(nameAdd.text?.isEmpty)!{
            let alert = UIAlertController(title: "", message: "Fill the Fields", preferredStyle: UIAlertController.Style.alert)
                                   // add an action (button)
                                   alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                                   // show the alert
                                   self.present(alert, animated: true, completion: nil)
        }
        else{
            
        
        let params : Parameters  = [
            "name" : nameAdd.text ?? "",
            "age" : ageAdd.text ?? "",
            "salary" : salaryAdd.text ?? ""
        ]
        AF.request(URL(string: "http://dummy.restapiexample.com/api/v1/create")!, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil, interceptor: nil, requestModifier: nil).response { response in
            if let data = response.data{
                do{
                    let str = String(decoding: data, as: UTF8.self)
                    print(str)
                    //Parsing
                    let userResponse = try JSONDecoder().decode(PostResponse.self, from: data)
                    self.delegate?.dataPassing(response: userResponse)
                    print(userResponse.status ?? "")
                    if userResponse.status == "success"{
                        self.navigationController?.popViewController(animated: true)
                    }
                    else{
                        let alert = UIAlertController(title: "", message: "Failed to Add", preferredStyle: UIAlertController.Style.alert)
                        // add an action (button)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                        // show the alert
                        self.present(alert, animated: true, completion: nil)
                    }
                    //                    self.Name = userResponse.data?.name
                    //                    self.Age = userResponse.data?.age
                    //                    self.Salary = userResponse.data?.salary
                    //                    self.ID = userResponse.data?.id
                    //                    self.Strid = "\(userResponse.data?.id ?? 0)"
                    //                    //self.viewModelEmployee.arrEmployees.app
                    //                    self.passData.append(datapopulate(Name: self.Name, Age: self.Age, Salary: self.Salary, ID: self.ID))
                    
                    
                    
                }catch let err{
                    let alert = UIAlertController(title: "", message: "Failed to Add", preferredStyle: UIAlertController.Style.alert)
                    // add an action (button)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    // show the alert
                    self.present(alert, animated: true, completion: nil)
                    print(err.localizedDescription)
                    DispatchQueue.main.async {                    }
                    
                }
                
            }
        }
        }
        
    }
    func customButtonDisplay(){
        addbtn.layer.cornerRadius = addbtn.frame.size.height/2
        addbtn.clipsToBounds = true
        
        
    }
}
