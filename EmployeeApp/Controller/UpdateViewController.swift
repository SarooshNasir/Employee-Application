//
//  UpdateViewController.swift
//  EmployeeApp
//
//  Created by IT on 11/5/20.
//  Copyright © 2020 IT. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class UpdateViewController: UIViewController {
    
    @IBOutlet weak var updateName: UITextField!
    @IBOutlet weak var updateAge: UITextField!
    @IBOutlet weak var updateSalary: UITextField!
    @IBOutlet weak var updateButton: UIButton!
    // MARK: Variables
    var strName: String?
    var strAge: String?
    var strSalary: String?
    var strID: String?
    override func viewDidLoad() {
        updateName.text = strName
        updateAge.text = strAge
        updateSalary.text = strSalary
        print(strID!)
        super.viewDidLoad()
        CustomButton()
        // Do any additional setup after loading the view.
    }
    @IBAction func UpdatePress(_ sender: Any) {
        
        let params : Parameters  = [
            "name" : updateName.text ?? "",
            "age" : updateAge.text ?? "",
            "salary" :updateSalary.text ?? ""
        ]
        AF.request(URL(string: "http://dummy.restapiexample.com/api/v1/update/\(strID ?? "")")!, method: .put, parameters: params, encoding: JSONEncoding.default, headers: nil, interceptor: nil, requestModifier: nil).response { response in
            if let data = response.data{
                do{
                    let str = String(decoding: data, as: UTF8.self)
                    print(str)
                    //Parsing
                    let userResponse = try JSONDecoder().decode(PostResponse.self, from: data)
                    print(userResponse.message ?? "")
                    DispatchQueue.main.async {
                        // MARK: ALERT Functionality
                        let alert = UIAlertController(title: "", message: "\(userResponse.message ?? "")", preferredStyle: UIAlertController.Style.alert)
                        // add an action (button)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                        
                        // show the alert
                        self.present(alert, animated: true, completion: nil)
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
    
    func CustomButton(){
        updateButton.layer.cornerRadius = updateButton.frame.size.height/5
        updateButton.clipsToBounds = true
        
        
    }
}
