//
//  ViewController.swift
//  EmployeeApp
//
//  Created by IT on 11/2/20.
//  Copyright © 2020 IT. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController,DataPass {
    
    @IBOutlet weak var tblView: UITableView!
    // MARK: Variables
    var viewModelEmployee = EmployeeViewModel()
    var Name: String?
    var Age: String?
    var Salary: String?
    var ID: Int?
    var Strid :String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModelEmployee.vc = self
        viewModelEmployee.getAllUserDataAF()
        tblView.addSubview(refhrea)
        tblView.reloadData()
        // Do any additional setup after loading the view.
    }
    func dataPassing(response: PostResponse) {
        Name = response.data?.name
        Age = response.data?.age
        Salary = response.data?.salary
        Strid = "\(response.data?.id ?? 0)"
        let employeedata = EmployeeDataModel(id: Strid, employee_name: Name, employee_salary: Salary, employee_age: Age, profile_image: "")
        //employeedata.employee_age
        viewModelEmployee.arrEmployees.insert(employeedata, at: 0)
        DispatchQueue.main.async {
            self.tblView.reloadData()
        }
    }
    // MARK: AddButton Functionality
    @IBAction func addButton(_ sender: UIBarButtonItem) {
        let addButtonVC = self.storyboard?.instantiateViewController(withIdentifier: "AddButtonViewController") as! AddButtonViewController
        addButtonVC.delegate = self
        self.navigationController?.pushViewController(addButtonVC, animated: true)
    }
    
}
extension ViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModelEmployee.arrEmployees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! EmployeeCell
        cell.lblName.text = viewModelEmployee.arrEmployees[indexPath.row].employee_name
        cell.lblAge.text = viewModelEmployee.arrEmployees[indexPath.row].employee_age
        cell.lblSalary.text = viewModelEmployee.arrEmployees[indexPath.row].employee_salary
        //cell.ImageView.image = UIImage(contentsOfFile: viewModelEmployee.arrEmployees[indexPath.row].profile_image ?? "")
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let UpdateVC :UpdateViewController = self.storyboard?.instantiateViewController(withIdentifier: "UpdateViewController") as! UpdateViewController
        UpdateVC.strName = viewModelEmployee.arrEmployees[indexPath.row].employee_name
        UpdateVC.strAge = viewModelEmployee.arrEmployees[indexPath.row].employee_age
        UpdateVC.strID = viewModelEmployee.arrEmployees[indexPath.row].id
        UpdateVC.strSalary = viewModelEmployee.arrEmployees[indexPath.row].employee_salary
        self.navigationController?.pushViewController(UpdateVC, animated: true)
    }
    
    // MARK: Delete Functionality
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let contextItem = UIContextualAction(style: .destructive, title: "delete") {  (contextualAction, view, boolValue) in
            let urlDelete = "http://dummy.restapiexample.com/api/v1/delete/\(self.viewModelEmployee.arrEmployees[indexPath.row].id ?? "")"
            AF.request(urlDelete, method: .delete).response {response in
                if let data = response.data{
                    
                    let str = String(decoding: data, as: UTF8.self)
                    print(str)
                    print(" This is \(response)")
                }
            }
            print("Delete tapped")
        }
        let swipeActions = UISwipeActionsConfiguration(actions: [contextItem])
        
        return swipeActions
    }
    
    //    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
    //        let deleteAction = UITableViewRowAction(style: .default, title: "Delete", handler: { (action, indexPath) in
    //
    //            let urlDelete = "http://dummy.restapiexample.com/api/v1/delete/\(self.viewModelEmployee.arrEmployees[indexPath.row].id ?? "")"
    //            AF.request(urlDelete, method: .delete).response {response in
    //            if let data = response.data{
    //
    //                    let str = String(decoding: data, as: UTF8.self)
    //                    print(str)
    //                    print(" This is \(response)")
    //            }
    //            }
    //            print("Delete tapped")
    //        })
    //        return [deleteAction]
    //    }
    // MARK: Refresh Functionality
    var refhrea : UIRefreshControl{
        let ref = UIRefreshControl()
        ref.addTarget(self, action: #selector(handleRefresh(_:)), for: .valueChanged)
        return ref
    }
    
    @objc func handleRefresh(_ control: UIRefreshControl){
        tblView.backgroundColor = UIColor.orange
        control.endRefreshing()
        tblView.reloadData()
        viewModelEmployee.getAllUserDataAF()
    }
    
    
}

