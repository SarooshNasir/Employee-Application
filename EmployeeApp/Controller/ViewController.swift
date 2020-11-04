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

class ViewController: UIViewController {
    @IBOutlet weak var tblView: UITableView!
    var viewModelEmployee = EmployeeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModelEmployee.vc = self
        viewModelEmployee.getAllUserDataAF()
        // Do any additional setup after loading the view.
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
    
    
    
    
}

