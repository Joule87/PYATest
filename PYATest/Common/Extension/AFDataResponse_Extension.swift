//
//  AFDataResponse_Extension.swift
//  PYATest
//
//  Created by Julio Collado on 4/2/20.
//  Copyright © 2020 Altimetrik. All rights reserved.
//

import Foundation
import Alamofire

extension AFDataResponse {
    ///Prints URL request and the Response if is not longer than 10kb
    func printRespone() {
        #if DEBUG
        print(self.request?.url ?? "")
        if let size = self.data?.count, size < 1000000 {
            print(self)
        } else {
            print("Response too large for print")
        }
        #endif
    }
}
