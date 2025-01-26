
import Foundation

//API Model 
struct UsersResponse: Decodable {
    let success: Bool
    let total_pages: Int
    let total_users: Int
    let count: Int
    let page: Int
    let links: Links
    let users: [UserAPI]
}

struct Links: Decodable {
    let next_url: String?
    let prev_url: String?
}

struct UserAPI: Decodable {
    let id: Int
    let name: String
    let email: String
    let phone: String
    let position: String
    let position_id: Int  
    let registration_timestamp: Int
    let photo: String
}

