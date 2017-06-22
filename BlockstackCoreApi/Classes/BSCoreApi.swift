import Foundation

public typealias BSApiCompletionHandler<T> = (_ object: T?, _ error: Error?) -> Void

public class BSCoreApi
{
    
}

extension BSCoreApi
{
    public static func ping(page : Int = 0, _ handler : @escaping BSApiCompletionHandler<Data>)
    {
        var request = URLRequest(url: URL(string: BSEndpoint.pingPath())!)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            if let data = data {
                handler(data, error)
            }
        }).resume()
    }
    
    public static func allNames(page : Int = 0, _ handler : @escaping BSApiCompletionHandler<Data>)
    {
        let url =  URLHelpers.buildURL(with: BSEndpoint.namesPath(), queryParams: ["page": String(page)])!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            if let data = data {
                handler(data, error)
            }
        }).resume()
    }
}

class URLHelpers
{
    static func buildURL(with string: String, queryParams: [String : String]) -> URL?
    {
        guard var components = URLComponents(string: string) else
        {
            return nil
        }
        
        var queryItems = components.queryItems ?? [URLQueryItem]()
        for(key, value) in queryParams
        {
            queryItems.append(URLQueryItem(name: key, value: value))
        }
        
        components.queryItems = queryItems
        return components.url
    }
}
