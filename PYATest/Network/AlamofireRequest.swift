//
//  AlamofireRequest.swift
//  PYATest
//
//  Created by Julio Collado on 4/2/20.
//  Copyright © 2020 Altimetrik. All rights reserved.
//

import Foundation
import Alamofire

public class AlamofireRequest {
    
    static func createObjectRequest<T: Codable> (request: DataRequest, completionHandler completion: @escaping (Results<T>) -> Void) {
        request.validate()
            .responseJSON { (response) in
                response.printRespone()
                if let error = response.error {
                    completion(.failure(error: error, data: nil))
                    return
                }
                
                do {
                    let value = try JSONDecoder().decode(T.self, from: response.data!)
                    completion(.success(value))
                } catch {
                    completion(.failure(error: error, data: response.data))
                }
                
        }
    }
    
}
