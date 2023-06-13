

import Foundation
struct Questions : Codable {
	var answerChoices : [AnswerChoices]?
	let id : Int?
	let name : String?
	var selectedAnswerChoiceId : String?


}
