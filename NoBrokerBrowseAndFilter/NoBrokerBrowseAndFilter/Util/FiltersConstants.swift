//
//  FiltersConstants.swift
//  NoBrokerBrowseAndFilter
//
//  Created by Sudhanshu on 5/4/17.
//  Copyright © 2017 Sudhanshu. All rights reserved.
//

import UIKit

class FiltersConstants: NSObject {
    
    enum Filters: String {
        case Apartment = "apartment"
        case Property = "property"
        case Furnishing = "furnishing"
    }
    
    enum ApartmentType: String {
        case OneRK = "RK1"
        case OneBHK = "BHK1"
        case TwoBHK = "BHK2"
        case ThreeBHK = "BHK3"
        case FourBHK = "BHK4"
        case FourPlusBHK = "BHK4PLUS"
    }
    
    enum PropertyType: String {
        case Apartment = "AP"
        case IndependentHouse = "IH"
        case IndependentFloor = "IF"
    }
    
    enum FurnishingType: String {
        case Full = "FULLY_FURNISHED"
        case Semi = "SEMI_FURNISHED"
        case Not = "NOT_FURNISHED"
    }
    
    static var apartmentSelectionArray = [ApartmentType.OneRK.rawValue : false,
                                   ApartmentType.OneBHK.rawValue : false,
                                   ApartmentType.TwoBHK.rawValue : false,
                                   ApartmentType.ThreeBHK.rawValue : false,
                                   ApartmentType.FourBHK.rawValue : false,
                                   ApartmentType.FourPlusBHK.rawValue : false,
                                   ]
    
    static var propertySelectionArray = [PropertyType.Apartment.rawValue : false,
                                  PropertyType.IndependentHouse.rawValue : false,
                                  PropertyType.IndependentFloor.rawValue : false,
                                  ]
    
    static var furnishingSelectionArray = [FurnishingType.Full.rawValue : false,
                                    FurnishingType.Semi.rawValue : false,
                                    FurnishingType.Not.rawValue : false,
                                    ]
    
    static var savedFilterArray = [Filters.Apartment.rawValue : apartmentSelectionArray,
                                   Filters.Property.rawValue : propertySelectionArray,
                                   Filters.Furnishing.rawValue :furnishingSelectionArray ]
    
    

}
