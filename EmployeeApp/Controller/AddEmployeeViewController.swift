//
//  AddEmployeeViewController.swift
//  EmployeeApp
//
//  Created by IT on 11/3/20.
//  Copyright © 2020 IT. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class AddEmployeeViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var empName: UITextField!
    @IBOutlet weak var empAge: UITextField!
    @IBOutlet weak var empSalary: UITextField!
    @IBOutlet weak var btn_Add: UIButton!
    @IBOutlet weak var btn_Update: UIButton!
    @IBOutlet weak var messageLabel: UILabel!
    
    // MARK: Variables
    var Name: String?
    var Age: String?
    var Salary: String?
    var ID: Int?
    var arrResponse = [data]()
    //  var arrResponse = [EmployeeDataModel]()
    var postReposne: PostResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customButtonDisplay()
        btn_Update.isHidden = true
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func AddEmployee(_ sender: UIButton) {
        
        let params : Parameters  = [
            "name" : empName.text ?? "",
            "age" : empAge.text ?? "",
            "salary" : empSalary.text ?? ""
        ]
        
        AF.request(URL(string: "http://dummy.restapiexample.com/api/v1/create")!, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil, interceptor: nil, requestModifier: nil).response { response in
            if let data = response.data{
                do{
                    let str = String(decoding: data, as: UTF8.self)
                    print(str)
                    //Parsing
                    let userResponse = try JSONDecoder().decode(PostResponse.self, from: data)
                    self.Name = userResponse.data?.name
                    self.Age = userResponse.data?.age
                    self.Salary = userResponse.data?.salary
                    self.ID = userResponse.data?.id
                    DispatchQueue.main.async {
                        self.messageLabel.text = userResponse.message ?? ""
                        self.btn_Update.isHidden = false
                        self.btn_Add.isHidden = true
                    }
                    
                }catch let err{
                    print(err.localizedDescription)
                    
                }
                
            }
        }
    }
    
    @IBAction func UpdateEmployee(_ sender: UIButton) {
        
        let params : Parameters  = [
            "name" : empName.text ?? "",
            "age" : empAge.text ?? "",
            "salary" : empSalary.text ?? ""
        ]
        AF.request(URL(string: "http://dummy.restapiexample.com/api/v1/delete/\(ID ?? 0)")!, method: .put, parameters: params, encoding: JSONEncoding.default, headers: nil, interceptor: nil, requestModifier: nil).response { response in
            if let data = response.data{
                do{
                    let str = String(decoding: data, as: UTF8.self)
                    print("This is \(self.ID ?? 0)")
                    print(str)
                    
                }
            }
        }
        
    }
    
    
    func customButtonDisplay(){
        btn_Add.layer.cornerRadius = btn_Add.frame.size.height/2
        btn_Add.clipsToBounds = true
        btn_Update.layer.cornerRadius = btn_Update.frame.size.height/2
        btn_Update.clipsToBounds = true
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
