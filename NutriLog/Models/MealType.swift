import Foundation

enum MealType: String, CaseIterable, Identifiable, Codable {
    case breakfast = "Déjeuner";
    case lunch = "Dîner"
    case dinner = "Souper"
    
    var id: String { rawValue }
    
    var localizedName: String {
            switch self {
            case .breakfast:
                return NSLocalizedString("KeyBreakfast", comment: "")
            case .lunch:
                return NSLocalizedString("KeyLunch", comment: "")
            case .dinner:
                return NSLocalizedString("KeyDinner", comment: "")
            }
        }
}
