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
class AddButtonViewController: UIViewController {
    
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
        
        // Do any additional setup after loading the view.
    }
    @IBAction func add(_ sender: Any) {
        
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
//                    self.Name = userResponse.data?.name
//                    self.Age = userResponse.data?.age
//                    self.Salary = userResponse.data?.salary
//                    self.ID = userResponse.data?.id
//                    self.Strid = "\(userResponse.data?.id ?? 0)"
//                    //self.viewModelEmployee.arrEmployees.app
//                    self.passData.append(datapopulate(Name: self.Name, Age: self.Age, Salary: self.Salary, ID: self.ID))
                    
                    DispatchQueue.main.async {
                        
                    }
                    
                }catch let err{
                    print(err.localizedDescription)
                    
                }
                
            }
        }
        
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    func customButtonDisplay(){
        addbtn.layer.cornerRadius = addbtn.frame.size.height/2
        addbtn.clipsToBounds = true
        
        
    }
}
