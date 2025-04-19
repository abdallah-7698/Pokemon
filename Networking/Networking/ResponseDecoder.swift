import Foundation

public protocol ResponseDecoder {
    /// The type of the response expected from the request.
    associatedtype ResponseType

    /// The closure that handles the decoding of the response data.
    var responseDecoder: (Data) throws -> ResponseType { get }
}

