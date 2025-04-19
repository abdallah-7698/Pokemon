import Foundation

public enum NetworkError: LocalizedError {
    case invalidURL
    case invalidResponse
    case invalidData
    case unableToComplete
    case timeOutRequest
    
    public var errorDescription: String? {
        switch self {
        case .invalidData, .invalidResponse, .invalidURL, .unableToComplete:
            return "Servaer Error"
        case .timeOutRequest:
            return "Time Out"
        }
    }
    
    public var recoverySuggestion: String? {
        switch self {
        case .invalidData:
            return "The Data received from the server was invalid. Pleas contact support."
        case .invalidResponse:
            return "Invalid response from the server. Please try again later or contact support"
        case .invalidURL:
            return "There was an issue connecting to the server. If this persists, Pleas contact support."
        case .unableToComplete:
            return "Unable to complete your request at this time. Pleas check your internet connection."
        case .timeOutRequest:
            return "Unable to complete your request. Pleas check your internet connection."
        }
    }
}
