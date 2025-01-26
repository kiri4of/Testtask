
import Foundation

struct PositionsResponse: Decodable {
    let success: Bool
    let positions: [PositionAPI]
}

struct PositionAPI: Decodable {
    let id: Int
    let name: String
}
