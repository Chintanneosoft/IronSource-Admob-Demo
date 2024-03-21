//
//  JsonConverter.swift
//  Widgets
//
//  Created by Apple on 17/10/20.
//

import Foundation


extension Array{
    func json() -> String? {
        guard let data = try? JSONSerialization.data(withJSONObject: self, options: []) else {
            return nil
        }
        return String(data: data, encoding: String.Encoding.utf8)
    }
}

extension String{
    func array() -> [[String:Any]] {
        let data = self.data(using: .utf8)!
        do {
            if let jsonArray = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? [[String:Any]]
            {
               //print(jsonArray) // use the json here
                
                return jsonArray
            } else {
                print("bad json")
            }
        } catch let error as NSError {
            print(error)
        }
        
        return []
    }
}
