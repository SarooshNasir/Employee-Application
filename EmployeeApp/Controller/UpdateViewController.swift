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

class UpdateViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var updateName: UITextField!
    @IBOutlet weak var updateAge: UITextField!
    @IBOutlet weak var updateSalary: UITextField!
    @IBOutlet weak var updateButton: UIButton!
    // MARK: Variables
    private var barButtonItem: UIBarButtonItem?
    var strName: String?
    var strAge: String?
    var strSalary: String?
    var strID: String?
    var editbarButton: UIBarButtonItem?
    var savebarButton: UIBarButtonItem?
    override func viewDidLoad() {
        updateButton.isHidden = true
        updateName.text = strName
        updateAge.text = strAge
        updateSalary.text = strSalary
        print(strID!)
        CustomButton()
        updateName.delegate = self
        updateAge.delegate = self
        updateSalary.delegate = self
        // MARK: Disable editing
        updateName.isUserInteractionEnabled = false
        updateAge.isUserInteractionEnabled = false
        updateSalary.isUserInteractionEnabled = false
        // MARK: BarButton Actions
        self.title = "Update"
        self.editbarButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editTapped))
        self.savebarButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(SaveTapped))
        self.navigationItem.rightBarButtonItems = [editbarButton!]
        super.viewDidLoad()
    }
    @objc func editTapped(){
        updateName.isUserInteractionEnabled = true
        updateAge.isUserInteractionEnabled = true
        updateSalary.isUserInteractionEnabled = true
        self.navigationItem.rightBarButtonItems = [savebarButton!]
    }
    @objc func SaveTapped(){
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
                    print(userResponse.status ?? "")
                    print(userResponse.data?.name ?? "")
                    if userResponse.status == "success"{
                        DispatchQueue.main.async {
                            // MARK: ALERT Functionality
                            let alert = UIAlertController(title: "", message: "\(userResponse.message ?? "")", preferredStyle: UIAlertController.Style.alert)
                            // add an action (button)
                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                            // show the alert
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                    else{
                        let alert = UIAlertController(title: "", message: "Failed to update", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }catch let err{
                    let alert = UIAlertController(title: "", message: "Failed to update", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    print(err.localizedDescription)
                }
            }
        }
        updateName.isUserInteractionEnabled = false
        updateAge.isUserInteractionEnabled = false
        updateAge.isUserInteractionEnabled = false
        self.navigationItem.rightBarButtonItems = [editbarButton!]
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        updateName.resignFirstResponder()
        updateAge.resignFirstResponder()
        updateSalary.resignFirstResponder()
        return true
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
                    print(userResponse.status ?? "")
                    print(userResponse.data?.name ?? "")
                    if userResponse.status == "success"{
                        DispatchQueue.main.async {
                            // MARK: ALERT Functionality
                            let alert = UIAlertController(title: "", message: "\(userResponse.message ?? "")", preferredStyle: UIAlertController.Style.alert)
                            // add an action (button)
                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                            // show the alert
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                    else{
                        let alert = UIAlertController(title: "", message: "Failed to update", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }catch let err{
                    let alert = UIAlertController(title: "", message: "Failed to update", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    print(err.localizedDescription)
                }
            }
        }
    }
    
    func CustomButton(){
        updateButton.layer.cornerRadius = updateButton.frame.size.height/5
        updateButton.clipsToBounds = true
    }
}
