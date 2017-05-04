//
//  OtherParamsModel.swift
//  NoBrokerBrowseAndFilter
//
//  Created by Sudhanshu on 5/4/17.
//  Copyright © 2017 Sudhanshu. All rights reserved.
//

import UIKit

class OtherParamsModel: NSObject {

    var cityModel = CityModel()
    
    init(responseData:[String:Any]?) {
        if let data = responseData {
                cityModel.city = data["city"] as? String
        }
    }
}

class CityModel: NSObject {
    var city : String?
}
