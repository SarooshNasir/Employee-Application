import Foundation

struct EmployeeModel : Codable {
    
	let status : String?
	let data : [EmployeeDataModel]?

	enum CodingKeys: String, CodingKey {

		case status = "status"
		case data = "data"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		status = try values.decodeIfPresent(String.self, forKey: .status)
		data = try values.decodeIfPresent([EmployeeDataModel].self, forKey: .data)
	}
}

struct EmployeeDataModel : Codable {
    let id : String?
    let employee_name : String?
    let employee_salary : String?
    let employee_age : String?
    let profile_image : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case employee_name = "employee_name"
        case employee_salary = "employee_salary"
        case employee_age = "employee_age"
        case profile_image = "profile_image"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        employee_name = try values.decodeIfPresent(String.self, forKey: .employee_name)
        employee_salary = try values.decodeIfPresent(String.self, forKey: .employee_salary)
        employee_age = try values.decodeIfPresent(String.self, forKey: .employee_age)
        profile_image = try values.decodeIfPresent(String.self, forKey: .profile_image)
    }

}

struct Adding : Encodable
{
    let MName: String
    let MAge: String
    let MSalary: String
}

struct PostResponse : Codable {
    let status : String?
    let data : Body?
    let message : String?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case data = "data"
        case message = "message"
    }

}
struct Body : Codable {
    let id : String?
    let Name : String?
    let Salary : String?
    let Age : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case Name = "Name"
        case Salary = "Salary"
        case Age = "Age"
    }

}

