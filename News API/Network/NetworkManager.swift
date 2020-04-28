//
//  NetworkManager.swift
//  News API
//
//  Created by Cao Mai on 4/27/20.
//  Copyright © 2020 Make School. All rights reserved.
//

import Foundation

class NetworkManager {
    
    let urlSession = URLSession.shared
    let topHeadlinesURL = "https://newsapi.org/v2/top-headlines?country=us&apiKey=cb3a1eac41554355a9bbf8612b87d638"
    let baseURL = "https://newsapi.org/v2/"
    let APIKEY = "cb3a1eac41554355a9bbf8612b87d638"
    
    
    enum EndPoints {
        case articles
        
        // Get Path
        func getPath() -> String {
            switch self {
            case .articles:
                return "top-headlines"
            }
        }
        
        // Get the Http Request method
        func getHTTPRequestMethod() -> String {
            return "GET"
        }
        
        // Getting the header
        func getHeaders(secretKey: String) -> [String: String] {
            
            return ["Accept": "application/json",
                    "Content-Type": "application/json",
                    "Authorization": "X-Api-Key \(secretKey)",
                "Host": "newsapi.org"
            ]
        }
        
        // Getting the paramters for the call
        func getParams() -> [String: String] {
            switch self {
            case .articles:
                
                return ["country": "us"
                ]
            }
        }
        
        // Converting paramters to actual url string
        func paramsToString() -> String {
            let parameterArray = getParams().map{ key, value in
                return "\(key)=\(value)"
                
            }
            
            return parameterArray.joined(separator: "&")
        }
    }
    
    enum Result<T> {
        case success(T)
        case failure(Error)
    }
    
    enum EndPointError: Error {
        case couldNotParse
        case noData
    }
    
    
    private func makeRequest(for endPoint: EndPoints) -> URLRequest {
        let stringParams = endPoint.paramsToString()
        let path = endPoint.getPath()
        let fullURL = URL(string: baseURL.appending("\(path)?\(stringParams)"))!
        var request = URLRequest(url: fullURL)
        request.httpMethod = endPoint.getHTTPRequestMethod()
        request.allHTTPHeaderFields = endPoint.getHeaders(secretKey: APIKEY)
        print("\(String(describing: request.allHTTPHeaderFields))")
        return request
        
    }
    
    func getArticles(_ completion: @escaping (Result<[Article]>) -> Void)  {
        let articleRequest = makeRequest(for: .articles)
        
        let task = urlSession.dataTask(with: articleRequest) { (data, response, error) in
            // If error
            if let error = error {
                return completion(Result.failure(error))
            }
            // If there's data
            guard let safeData = data else {
                return completion(Result.failure(EndPointError.noData))
            }
            // To decode data
            guard let result = try? JSONDecoder().decode(ArticleList.self, from: safeData) else {
                return completion(Result.failure(EndPointError.couldNotParse))
            }
            
            let articles = result.articles
            
            DispatchQueue.main.async {
                completion(Result.success(articles))
            }
            
        }
        task.resume()
    }
    
    
}


public struct Article: Codable {
    let author: String?
    let title: String?
    let description: String?
    let url: URL? // Direct URL to article
    let urlToImage: URL? //URL to image for the article
    let content: String?
}

public struct ArticleList: Codable{
    public var articles: [Article]
}
