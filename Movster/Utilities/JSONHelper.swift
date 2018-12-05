//
//  JSONHelper.swift
//  Movster
//
//  Created by Fong, Peter on 12/4/18.
//  Copyright © 2018 Fong, Peter. All rights reserved.
//

import UIKit

class JSONHelper: NSObject {
    static func loadJson<T>(data: Data) -> T? where T: Decodable {
            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(T.self, from: data)
                return jsonData
            } catch {
                print("error:\(error)")
            }
        return nil
    }
}
