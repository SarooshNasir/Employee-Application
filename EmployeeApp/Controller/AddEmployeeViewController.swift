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
    
    // MARK: Variables
    var Name: String?
    var Age: String?
    var Salary: String?
    var arrResponse = [EmployeeDataModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customButtonDisplay()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func AddEmployee(_ sender: UIButton) {
        
        Name = empName.text ?? ""
        Age = empAge.text ?? ""
        Salary = empSalary.text ?? ""
        
        let params : Parameters  = [
            "name" : empName.text ?? "",
            "age" : empAge.text ?? "",
            "salary" : empSalary.text ?? ""
        ]
    
        
       // let add = Adding(MName: Name!, MAge: Age!, MSalary: Salary!)
        
        AF.request(URL(string: "http://dummy.restapiexample.com/api/v1/create")!, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil, interceptor: nil, requestModifier: nil).response { response in
                    if let data = response.data{
                        do{
                            let str = String(decoding: data, as: UTF8.self)
                            print(str)
                            //Parsing
                            let userResponse = try JSONDecoder().decode(PostResponse.self, from: data)
                            print(userResponse)

                        }catch let err{
                            print(err.localizedDescription)

                        }

                    }
            //debugPrint(response)
                    // print(response)
                    
        }
        
//        AF.request("http://dummy.restapiexample.com/api/v1/create",
//                   method: .post,
//                   parameters: params,
//                   encoder: JSONEncoding).response { response in
//                    if let data = response.data{
//                        do{
//                            //Parsing
//                            let userResponse = try JSONDecoder().decode(PostResponse.self, from: data)
//                            print(userResponse.message ?? "")
//
//                        }catch let err{
//                            print(err.localizedDescription)
//
//                        }
//
//                    }
//                    //debugPrint(response)
//                    // print(response)
//
//        }
    }
    
    
    
    
    
    
    
    func customButtonDisplay(){
        btn_Add.layer.cornerRadius = btn_Add.frame.size.height/2
        btn_Add.clipsToBounds = true
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
