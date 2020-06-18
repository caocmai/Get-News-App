//
//  NetworkManager.swift
//  News API
//
//  Created by Cao Mai on 4/27/20.
//  Copyright © 2020 Make School. All rights reserved.
//

import Foundation

class NetworkManager {
    
    static let singleton = NetworkManager()
    
    let urlSession = URLSession.shared
    let baseURL = "https://newsapi.org/v2/"
    let APIKEY = "\(Secret.apiKey.rawValue)" // Your API Key goes here
    
    enum EndPoints {
        case articles
        case category(categoryIn: String, pageNumber: String)
        case search(q: String)
        case sources
        case getFromNewsSource(newsSource: String)
        
        // Get Path
        func getPath() -> String {
            switch self {
            case .articles, .category, .getFromNewsSource:
                return "top-headlines"
            case .search:
                return "everything"
            case .sources:
                return "sources"
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
            case .category(let categoryIn, let pageNum):
                return ["country": "us",
                        "category": categoryIn,
                        "page": pageNum
                ]
            case .search(let qInput):
                return ["q": qInput
                ]
            case .sources:
                return ["language": "en"
                ]
            case .getFromNewsSource(let inputNewsSource):
                return ["sources": inputNewsSource
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
        case success(T?)
        case failure(Error)
    }
    
    enum EndPointError: Error {
        case couldNotParse
        case noData
    }
    
    
    private func makeRequest(for endPoint: EndPoints) -> URLRequest {
        let path = endPoint.getPath() // Get the first part of URL
        let stringParams = endPoint.paramsToString()
        let fullURL = URL(string: baseURL.appending("\(path)?\(stringParams)"))
//                print(fullURL)
        var request = URLRequest(url: fullURL!)
        request.httpMethod = endPoint.getHTTPRequestMethod()
        request.allHTTPHeaderFields = endPoint.getHeaders(secretKey: APIKEY)
//                print("\(String(describing: request.allHTTPHeaderFields))")
        return request
        
    }
    
    // Setting the default as page one.
    func getArticles(passedInCategory: String, passedInPageNumber: String="1", _ completion: @escaping (Result<[Article]>) -> Void)  {
        let articleRequest = makeRequest(for: .category(categoryIn: passedInCategory, pageNumber: passedInPageNumber))
        print(articleRequest)
        
        let task = urlSession.dataTask(with: articleRequest) { (data, response, error) in
            // If error
            if let error = error {
                return completion(Result.failure(error))
            }
            
            do {
                // Testing to see if got the proper json back
                let jsonObject = try JSONSerialization.jsonObject(with: data!, options: [])
                //                                print(jsonObject)
                //                                print("\n\n\n\n\n")
            } catch {
                print(error.localizedDescription)
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
    
    func getSearchArticles(passedInQuery: String, _ completion: @escaping (Result<[Article]>) -> Void)  {
        let articleRequest = makeRequest(for: .search(q: passedInQuery))
        
        let task = urlSession.dataTask(with: articleRequest) { (data, response, error) in
            // If error
            if let error = error {
                return completion(Result.failure(error))
            }
            guard let safeData = data else {
                return completion(Result.failure(EndPointError.noData))
                
            }
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
    
    func getSources(_ completion: @escaping (Result<AllNewsSources>) -> Void)  {
        let articleRequest = makeRequest(for: .sources)
        
        let task = urlSession.dataTask(with: articleRequest) { (data, response, error) in
            // If error
            if let error = error {
                return completion(Result.failure(error))
            }
            guard let safeData = data else {
                return completion(Result.failure(EndPointError.noData))
                
            }
            guard let result = try? JSONDecoder().decode(AllNewsSources.self, from: safeData) else {
                return completion(Result.failure(EndPointError.couldNotParse))
            }
            
            let sources = result
            
            DispatchQueue.main.async {
                completion(Result.success(sources))
            }
        }
        task.resume()
    }
    
    func getArticlesFromSource(from newsSource: String, _ completion: @escaping (Result<[Article]>) -> Void)  {
        let articleRequest = makeRequest(for: .getFromNewsSource(newsSource: newsSource))
        
        let task = urlSession.dataTask(with: articleRequest) { (data, response, error) in
            // If error
            if let error = error {
                return completion(Result.failure(error))
            }

            guard let safeData = data else {
                return completion(Result.failure(EndPointError.noData))
                
            }
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


