//
//  APIService.swift
//  Clima
//
//  Created by 徳永勇希 on 2024/05/20.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation

class APIService {
    
    static let shared = APIService()
    
    func getRequest<T: Codable>(url: URL,value: String? = nil, headerField: String? = nil, type: T.Type, completionHandler: @escaping (T) -> Void, errorHandler: @escaping (String) -> Void) {
        var request = URLRequest(url: url)
        if let _value = value, let _headerField = headerField {
            request.addValue(_value, forHTTPHeaderField: _headerField)
        }
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                print(error as Any)
                errorHandler(error?.localizedDescription ?? "Error!")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("status code is not 200")
                errorHandler("Status code is not 200")
                print(response as Any)
            }
            if let mappedResponse = try? JSONDecoder().decode(T.self, from: data) {
                print(mappedResponse)
                completionHandler(mappedResponse)
            }
        }
        
        task.resume()
    }
}
