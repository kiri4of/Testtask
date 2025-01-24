
import Foundation

struct SignUpResponse: Decodable {
    let success: Bool
    let user_id: Int?
    let message: String
    
}
