

import Foundation
struct Categories : Codable {
	let id : Int?
	let name : String?
	var questions : [Questions]?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case name = "name"
		case questions = "questions"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		questions = try values.decodeIfPresent([Questions].self, forKey: .questions)
	}

}
