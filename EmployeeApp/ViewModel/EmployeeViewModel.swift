//
//  EmployeeViewModel.swift
//  EmployeeApp
//
//  Created by IT on 11/2/20.
//  Copyright © 2020 IT. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class EmployeeViewModel{
    
    weak var vc : ViewController?
    var arrEmployees = [EmployeeDataModel]()
    var employeeModel: EmployeeModel?
    // MARK: BYAlarmofire
    func getAllUserDataAF(){
        AF.request("http://dummy.restapiexample.com/api/v1/employees").response {
            response in
            if let data = response.data{
                do{
                    //Parsing
                    let userResponse = try JSONDecoder().decode(EmployeeModel.self, from: data)
                    self.arrEmployees.append(contentsOf: userResponse.data ?? [EmployeeDataModel]())
                    DispatchQueue.main.async {
                        self.vc?.tblView.reloadData()
                    }
                    print(self.arrEmployees)
                    
                }catch let err{
                    print(err.localizedDescription)
                    
                }
                
            }
            
        }
        //        AF.request("http://dummy.restapiexample.com/api/v1/employees").responseJSON { (response) in
        //            switch response.result{
        //            case .success:
        //                let data = JSON(response.value!)
        //                let data2 = data["data"].arrayValue[0]
        //                let data3 = JSON(data2["employee_salary"])
        //                print(data3)
        //            case .failure:
        //                print("Error")
        //
        //            }
        //        }
    }
    // MARK: ByURLSession
    func getAllUserData(){
        URLSession.shared.dataTask(with: URL(string: "http://dummy.restapiexample.com/api/v1/employees")!) { (data, response, error) in
            if error == nil{
                if let data = data{
                    do{
                        //Parsing
                        let userResponse = try JSONDecoder().decode(EmployeeModel.self, from: data)
                        self.arrEmployees.append(contentsOf: userResponse.data ?? [EmployeeDataModel]())
                        
                        //userResponse.data
                        //self.arrEmployees.append(contentsOf: userResponse)
                        DispatchQueue.main.async {
                            self.vc?.tblView.reloadData()
                        }
                        print(self.arrEmployees)
                        
                    }catch let err{
                        print(err.localizedDescription)
                        
                    }
                    
                }
            }
            else{
                print(error?.localizedDescription)
            }
        }.resume()
    }
}
