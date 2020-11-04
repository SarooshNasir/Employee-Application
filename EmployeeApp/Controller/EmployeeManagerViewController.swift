//
//  EmployeeManagerViewController.swift
//  EmployeeApp
//
//  Created by IT on 11/3/20.
//  Copyright © 2020 IT. All rights reserved.
//

import UIKit

class EmployeeManagerViewController: UIViewController {
    @IBOutlet weak var addEmployeeBTN: UIButton!
    @IBOutlet weak var employeeListBTN: UIButton!
    @IBOutlet weak var imageview: UIImageView!
    
    override func viewDidLoad() {
           ManagerDisplayCustomization()
              

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
    func ManagerDisplayCustomization(){
        imageview.alpha = 0.2
        addEmployeeBTN.layer.cornerRadius = addEmployeeBTN.frame.size.height/3
               addEmployeeBTN.clipsToBounds = true
        
        employeeListBTN.layer.cornerRadius = employeeListBTN.frame.size.height/3
                     employeeListBTN.clipsToBounds = true
    }
}
