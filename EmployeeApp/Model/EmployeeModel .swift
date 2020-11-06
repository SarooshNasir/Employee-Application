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
}

struct Adding : Encodable
{
    let MName: String
    let MAge: String
    let MSalary: String
    
}

struct PostResponse : Codable {
    let status : String?
    let data : Data?
    let message : String?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case data = "data"
        case message = "message"
    }

}

struct Delete : Codable {
    let status : String?
    //let data : String?
    let message : String?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        //case data = "data"
        case message = "message"
    }

}
struct Data : Codable {
    let id : Int?
    let name : String?
    let salary : String?
    let age : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case salary = "salary"
        case age = "age"
    }

}

