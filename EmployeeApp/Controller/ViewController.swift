//
//  ViewController.swift
//  EmployeeApp
//
//  Created by IT on 11/2/20.
//  Copyright © 2020 IT. All rights reserved.
//

import UIKit

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
    
    
    
    
}

