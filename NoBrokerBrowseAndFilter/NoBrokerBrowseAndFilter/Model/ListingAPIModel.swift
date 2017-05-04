//
//  ListingAPIModel.swift
//  NoBrokerBrowseAndFilter
//
//  Created by Sudhanshu on 5/3/17.
//  Copyright © 2017 Sudhanshu. All rights reserved.
//

import UIKit

class ListingAPIModel: NSObject {
    
    var listingModelArr = [ListingModel]()
    
    init(responseData:[[String:Any]]?) {
        
        if let data = responseData {
            for response in data {
                let listingModel = ListingModel()
                
                listingModel.propertyTitle = response["propertyTitle"] as? String
                listingModel.secondaryTitle = response["secondaryTitle"] as? String
                
                if let rent = response["rent"] as? Int {
                    listingModel.rent = "₹ \(rent)"
                }
                
                if let furnishing = response["furnishing"] as? String {
                    let furnishingRefactored = furnishing.replacingOccurrences(of: "_", with: " ").lowercased().capitalized
                    listingModel.furnishing = furnishingRefactored
                }
                
                if let bathroom = response["bathroom"] as? Int {
                    if Int(bathroom) > 1 {
                        listingModel.bathroom = "\(bathroom) Bathrooms"
                    } else {
                        listingModel.bathroom = "\(bathroom) Bathroom"
                    }
                }
                
                if let propertySize = response["propertySize"] as? Int {
                    listingModel.propertySize = "\(propertySize) Sq.ft"
                }
                
                var imagesArr = [String]()
                if let imageId = response["id"] as? String, let imageArray = response["photos"] as? [[String:Any]] , imageArray.count > 0  {
                    for images in imageArray {
                        guard let displayPic = images["displayPic"] as? Bool, displayPic == true else {
                            continue
                        }
                        
                        if let imagesMap = images["imagesMap"] as? [String:String], let originalImage = imagesMap["original"] {
                            let imageUrl = "http://d3snwcirvb4r88.cloudfront.net/images/\(imageId)/\(originalImage)"
                            imagesArr.append(imageUrl)
                        }
                    }
                    listingModel.imageArray = imagesArr
                }
                
                listingModelArr.append(listingModel)
            }
        }
    }
}

class ListingModel: NSObject {
    var propertyTitle : String?
    var secondaryTitle : String?
    var rent : String?
    var furnishing : String?
    var bathroom : String?
    var propertySize : String?
    var imageArray : [String]?
}
