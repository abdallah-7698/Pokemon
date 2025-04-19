import Foundation

/// A protocol that represents a network session capable of fetching data asynchronously.
 protocol URLSessionProtocol {
     /// Fetches the data and URL response for the given request.
         ///
         /// This method performs an asynchronous network request and calls the provided
         /// `completionHandler` once the network operation is complete. The completion handler
         /// returns the fetched `data`, the `URLResponse` received, or an `Error` if something went wrong.
         ///
         /// - Parameters:
         ///   - request: The `URLRequest` that contains the information for the network request, such as URL, headers, etc.
         ///   - completionHandler: A closure that will be called once the data task completes. It provides:
         ///     - `data`: The data returned from the request if successful.
         ///     - `response`: The URL response object from the server, typically containing status codes and headers.
         ///     - `error`: An error object if something went wrong during the network request.
         /// - Returns: A `URLSessionDataTask` that can be used to control the lifecycle of the request (e.g., canceling it).
         /// - Throws: This function can throw an error if something goes wrong during the request setup or execution.
     func dataTask( with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void ) -> URLSessionDataTask
}

/// Extension to make URLSession conform to URLSessionProtocol.
extension URLSession: URLSessionProtocol {}
