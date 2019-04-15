import Foundation

struct PostData: Codable{
    
    var title: String
    var thumbnail: String?
    var author: String
    var created: Double
    var commentCount: Int
    var score: Int
    var url: String
    var postHint: String?
    var selfText: String?
    var isSelf: Bool
    
    private enum CodingKeys: String, CodingKey{
        case title
        case thumbnail
        case author
        case created
        case commentCount = "num_comments"
        case score
        case url
        case postHint = "post_hint"
        case selfText = "selftext"
        case isSelf = "is_self"
    }
}
