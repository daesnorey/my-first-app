//
//  HTTPHandler.swift
//  my-first-app
//
//  Created by user146790 on 12/1/18.
//  Copyright © 2018 user146790. All rights reserved.
//

import Foundation

class HTTPHandler {
    
    static func getJson(urlString: String, completionHandler: @escaping (Data?) -> (Void)) {
        let urlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        let url = URL(string: urlString!)
        print("url being used is \(url!)")

        let session = URLSession.shared
        let task = session.dataTask(with: url!) { data, response, error in
            if let data = data {
                let httpResponse = response as! HTTPURLResponse
                let statusCode = httpResponse.statusCode
                print("request completed with code \(statusCode)")
                if statusCode == 200 {
                    print("return to completionHandler with data")
                    completionHandler(data as Data)
                }
            } else if let error = error {
                print("***There was an error making the http request***")
                print(error.localizedDescription)
                completionHandler(nil)
            }
        }
        task.resume()
        
    }
}
