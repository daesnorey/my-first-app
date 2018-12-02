//
//  JSONParser.swift
//  my-first-app
//
//  Created by user146790 on 12/1/18.
//  Copyright © 2018 user146790. All rights reserved.
//

import Foundation

class JSONParser {
    
    static func parse(data: Data) -> [String: AnyObject]? {
        let options = JSONSerialization.ReadingOptions()
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: options) as? [String: AnyObject]
            return json
        } catch let parseError {
            print("There was an error parsing the JSON: \"\(parseError.localizedDescription)\"")
        }
        return nil
    }
}
