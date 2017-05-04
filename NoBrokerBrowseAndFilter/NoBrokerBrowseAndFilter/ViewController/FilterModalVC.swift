//
//  FilterModalVC.swift
//  NoBrokerBrowseAndFilter
//
//  Created by Sudhanshu on 5/3/17.
//  Copyright © 2017 Sudhanshu. All rights reserved.
//

import UIKit

class FilterModalVC: UIViewController {

    @IBOutlet weak var closeButton: UIButton!
    
    @IBOutlet weak var oneRK: RoundRectButton!
    
    @IBOutlet weak var oneBHK: RoundRectButton!
    @IBOutlet weak var twoBHK: RoundRectButton!
    @IBOutlet weak var threeBHK: RoundRectButton!
    @IBOutlet weak var fourBHK: RoundRectButton!
    @IBOutlet weak var fourPlusBHK: RoundRectButton!
    
    @IBOutlet weak var apartmentFilter: RoundRectButton!
    @IBOutlet weak var independentHouseFilter: RoundRectButton!
    @IBOutlet weak var independentFloorFilter: RoundRectButton!
    
    @IBOutlet weak var fullFurnished: RoundRectButton!
    @IBOutlet weak var semiFurnished: RoundRectButton!
    @IBOutlet weak var notFurnished: RoundRectButton!
    
    
    var filterArray = [String:String]()
    var filterTapped: (([String:String], [String : [String: Bool]]) -> Void)?
    var savedFilterArray = [String : [String: Bool]]()
    
    
    let borderColorSelected = UIColor(red: 253/255, green: 55/255, blue: 83/255, alpha: 1.0).cgColor
    let borderColor = UIColor(red: 207/255, green: 207/255, blue: 208/255, alpha: 1.0).cgColor
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        DispatchQueue.main.async {
            self.updateFilterUI()
        }
        
        
        
        if let closeButtonImage = closeButton?.imageView?.image {
            closeButton?.imageView?.image = closeButtonImage.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
            closeButton?.imageView?.tintColor = UIColor(red:1, green:1, blue:1, alpha:1.0)
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTappedCloseBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func didApplyFilters(_ sender: Any) {
        
        // apartment filters
        var apartmentFilter = ""
        for (key, value) in savedFilterArray[FiltersConstants.Filters.Apartment.rawValue]! {
           
            guard value == true else {
                continue
            }
            
            if apartmentFilter != "" {
                apartmentFilter = "\(apartmentFilter),\(key)"
            } else {
                apartmentFilter = key
            }
        }
        if apartmentFilter != "" {
            self.filterArray["&type"] = apartmentFilter
        }
        
        // property filters
        var propertyFilter = ""
        for (key, value) in savedFilterArray[FiltersConstants.Filters.Property.rawValue]! {
            
            guard value == true else {
                continue
            }
            
            if propertyFilter != "" {
                propertyFilter = "\(propertyFilter),\(key)"
            } else {
                propertyFilter = key
            }
        }
        
        if propertyFilter != "" {
            self.filterArray["&buildingType"] = propertyFilter
        }

        // furnishing filters
        var furnishFilter = ""
        for (key, value) in savedFilterArray[FiltersConstants.Filters.Furnishing.rawValue]! {
            
            guard value == true else {
                continue
            }
            
            if furnishFilter != "" {
                furnishFilter = "\(furnishFilter),\(key)"
            } else {
                furnishFilter = key
            }
        }
        
        if furnishFilter != "" {
            self.filterArray["&furnishing"] = furnishFilter
        }
        
        self.dismiss(animated: true) {
            self.filterTapped?(self.filterArray, self.savedFilterArray)
        }
        
    }
    
    @IBAction func oneRKDidSelect(_ sender: Any) {
        
        let filterType = FiltersConstants.Filters.Apartment.rawValue
        let filterVal = FiltersConstants.ApartmentType.OneRK.rawValue
        savedFilterArray[filterType]?[filterVal] = !savedFilterArray[filterType]![filterVal]!
        
        updateOneRKUI()
    }
    
    @IBAction func oneBHKDidSelect(_ sender: Any) {
        
        let filterType = FiltersConstants.Filters.Apartment.rawValue
        let filterVal = FiltersConstants.ApartmentType.OneBHK.rawValue
        savedFilterArray[filterType]?[filterVal] = !savedFilterArray[filterType]![filterVal]!
        
        updateOneBHKUI()
    }
    
    @IBAction func twoBHKDidSelect(_ sender: Any) {
        
        let filterType = FiltersConstants.Filters.Apartment.rawValue
        let filterVal = FiltersConstants.ApartmentType.TwoBHK.rawValue
        savedFilterArray[filterType]?[filterVal] = !savedFilterArray[filterType]![filterVal]!
        
        updateTwoBHKUI()
    }
    
    @IBAction func threeBHKDidSelect(_ sender: Any) {
        
        let filterType = FiltersConstants.Filters.Apartment.rawValue
        let filterVal = FiltersConstants.ApartmentType.ThreeBHK.rawValue
        savedFilterArray[filterType]?[filterVal] = !savedFilterArray[filterType]![filterVal]!
        
        updateThreeBHKUI()
    }
    
    @IBAction func fourBHKDidSelect(_ sender: Any) {
        
        let filterType = FiltersConstants.Filters.Apartment.rawValue
        let filterVal = FiltersConstants.ApartmentType.FourBHK.rawValue
        savedFilterArray[filterType]?[filterVal] = !savedFilterArray[filterType]![filterVal]!
        
        updateFourBHKUI()
    }
    
    @IBAction func fourPlusBHKDidSelect(_ sender: Any) {
        let filterType = FiltersConstants.Filters.Apartment.rawValue
        let filterVal = FiltersConstants.ApartmentType.FourPlusBHK.rawValue
        savedFilterArray[filterType]?[filterVal] = !savedFilterArray[filterType]![filterVal]!
        
        updateFourPlusBHKUI()
    }
    
    
    @IBAction func apartmentDidSelect(_ sender: Any) {

        let filterType = FiltersConstants.Filters.Property.rawValue
        let filterVal = FiltersConstants.PropertyType.Apartment.rawValue
        savedFilterArray[filterType]?[filterVal] = !savedFilterArray[filterType]![filterVal]!
        
        updateApartmentUI()
    }
    
    @IBAction func independentHouseDidSelect(_ sender: Any) {
        
        let filterType = FiltersConstants.Filters.Property.rawValue
        let filterVal = FiltersConstants.PropertyType.IndependentHouse.rawValue
        savedFilterArray[filterType]?[filterVal] = !savedFilterArray[filterType]![filterVal]!
        
        updateIHUI()
    }
    
    @IBAction func independentFloorDidSelect(_ sender: Any) {
        
        let filterType = FiltersConstants.Filters.Property.rawValue
        let filterVal = FiltersConstants.PropertyType.IndependentFloor.rawValue
        savedFilterArray[filterType]?[filterVal] = !savedFilterArray[filterType]![filterVal]!
        
        updateIFUI()
    }
    
    @IBAction func fullyFurnishedDidSelect(_ sender: Any) {
        
        let filterType = FiltersConstants.Filters.Furnishing.rawValue
        let filterVal = FiltersConstants.FurnishingType.Full.rawValue
        savedFilterArray[filterType]?[filterVal] = !savedFilterArray[filterType]![filterVal]!
        
        updateFullFurnishUI()
    }
    
    @IBAction func semiFurnishedDidSelect(_ sender: Any) {
        
        let filterType = FiltersConstants.Filters.Furnishing.rawValue
        let filterVal = FiltersConstants.FurnishingType.Semi.rawValue
        savedFilterArray[filterType]?[filterVal] = !savedFilterArray[filterType]![filterVal]!
        
        updateSemiFurnishUI()
    }
    
    @IBAction func notFurnishedDidSelect(_ sender: Any) {
        
        let filterType = FiltersConstants.Filters.Furnishing.rawValue
        let filterVal = FiltersConstants.FurnishingType.Not.rawValue
        savedFilterArray[filterType]?[filterVal] = !savedFilterArray[filterType]![filterVal]!
        
        updateNotFurnishUI()
    }
    
    
    func updateOneRKUI() {
        if let val = savedFilterArray[FiltersConstants.Filters.Apartment.rawValue]?[FiltersConstants.ApartmentType.OneRK.rawValue], val == true {
            oneRK.setTitleColor(#colorLiteral(red: 1, green: 0.2013165951, blue: 0.3081526458, alpha: 1), for: .normal)
            oneRK.layer.borderColor = borderColorSelected
        } else {
            oneRK.setTitleColor(#colorLiteral(red: 0.4274509804, green: 0.4666666667, blue: 0.4823529412, alpha: 1), for: .normal)
            oneRK.layer.borderColor = borderColor
        }
    }
    
    func updateOneBHKUI() {
        if let val = savedFilterArray[FiltersConstants.Filters.Apartment.rawValue]?[FiltersConstants.ApartmentType.OneBHK.rawValue], val == true {
            oneBHK.setTitleColor(#colorLiteral(red: 1, green: 0.2013165951, blue: 0.3081526458, alpha: 1), for: .normal)
            oneBHK.layer.borderColor = borderColorSelected
        } else {
            oneBHK.setTitleColor(#colorLiteral(red: 0.4274509804, green: 0.4666666667, blue: 0.4823529412, alpha: 1), for: .normal)
            oneBHK.layer.borderColor = borderColor
            
        }
    }
    
    func updateTwoBHKUI() {
        if let val = savedFilterArray[FiltersConstants.Filters.Apartment.rawValue]?[FiltersConstants.ApartmentType.TwoBHK.rawValue], val == true {
            twoBHK.setTitleColor(#colorLiteral(red: 1, green: 0.2013165951, blue: 0.3081526458, alpha: 1), for: .normal)
            twoBHK.layer.borderColor = borderColorSelected
        } else {
            twoBHK.setTitleColor(#colorLiteral(red: 0.4274509804, green: 0.4666666667, blue: 0.4823529412, alpha: 1), for: .normal)
            twoBHK.layer.borderColor = borderColor
        }
    }
    
    func updateThreeBHKUI() {
        if let val = savedFilterArray[FiltersConstants.Filters.Apartment.rawValue]?[FiltersConstants.ApartmentType.ThreeBHK.rawValue], val == true {
            threeBHK.setTitleColor(#colorLiteral(red: 1, green: 0.2013165951, blue: 0.3081526458, alpha: 1), for: .normal)
            threeBHK.layer.borderColor = borderColorSelected
        } else {
            threeBHK.setTitleColor(#colorLiteral(red: 0.4274509804, green: 0.4666666667, blue: 0.4823529412, alpha: 1), for: .normal)
            threeBHK.layer.borderColor = borderColor
        }
    }
    
    func updateFourBHKUI() {
        if let val = savedFilterArray[FiltersConstants.Filters.Apartment.rawValue]?[FiltersConstants.ApartmentType.FourBHK.rawValue], val == true {
            fourBHK.setTitleColor(#colorLiteral(red: 1, green: 0.2013165951, blue: 0.3081526458, alpha: 1), for: .normal)
            fourBHK.layer.borderColor = borderColorSelected
        } else {
            fourBHK.setTitleColor(#colorLiteral(red: 0.4274509804, green: 0.4666666667, blue: 0.4823529412, alpha: 1), for: .normal)
            fourBHK.layer.borderColor = borderColor
        }
    }
    
    func updateFourPlusBHKUI() {
        if let val = savedFilterArray[FiltersConstants.Filters.Apartment.rawValue]?[FiltersConstants.ApartmentType.FourPlusBHK.rawValue], val == true {
            fourPlusBHK.setTitleColor(#colorLiteral(red: 1, green: 0.2013165951, blue: 0.3081526458, alpha: 1), for: .normal)
            fourPlusBHK.layer.borderColor = borderColorSelected
        } else {
            fourPlusBHK.setTitleColor(#colorLiteral(red: 0.4274509804, green: 0.4666666667, blue: 0.4823529412, alpha: 1), for: .normal)
            fourPlusBHK.layer.borderColor = borderColor
        }
    }
    
    func updateApartmentUI() {
        if let val = savedFilterArray[FiltersConstants.Filters.Property.rawValue]?[FiltersConstants.PropertyType.Apartment.rawValue], val == true {
            apartmentFilter.setTitleColor(#colorLiteral(red: 1, green: 0.2013165951, blue: 0.3081526458, alpha: 1), for: .normal)
            apartmentFilter.layer.borderColor = borderColorSelected
        }
      else {
            apartmentFilter.setTitleColor(#colorLiteral(red: 0.4274509804, green: 0.4666666667, blue: 0.4823529412, alpha: 1), for: .normal)
            apartmentFilter.layer.borderColor = borderColor
        }
    }
    
    func updateIHUI() {
        if let val = savedFilterArray[FiltersConstants.Filters.Property.rawValue]?[FiltersConstants.PropertyType.IndependentHouse.rawValue], val == true {
            independentHouseFilter.setTitleColor(#colorLiteral(red: 1, green: 0.2013165951, blue: 0.3081526458, alpha: 1), for: .normal)
            independentHouseFilter.layer.borderColor = borderColorSelected
        }
        else {
            independentHouseFilter.setTitleColor(#colorLiteral(red: 0.4274509804, green: 0.4666666667, blue: 0.4823529412, alpha: 1), for: .normal)
            independentHouseFilter.layer.borderColor = borderColor
        }
    }
    
    func updateIFUI() {
        if let val = savedFilterArray[FiltersConstants.Filters.Property.rawValue]?[FiltersConstants.PropertyType.IndependentFloor.rawValue], val == true {
            independentFloorFilter.setTitleColor(#colorLiteral(red: 1, green: 0.2013165951, blue: 0.3081526458, alpha: 1), for: .normal)
            independentFloorFilter.layer.borderColor = borderColorSelected
        }
        else {
            independentFloorFilter.setTitleColor(#colorLiteral(red: 0.4274509804, green: 0.4666666667, blue: 0.4823529412, alpha: 1), for: .normal)
            independentFloorFilter.layer.borderColor = borderColor
        }
    }
    
    func updateFullFurnishUI() {
        if let val = savedFilterArray[FiltersConstants.Filters.Furnishing.rawValue]?[FiltersConstants.FurnishingType.Full.rawValue], val == true {
            fullFurnished.setTitleColor(#colorLiteral(red: 1, green: 0.2013165951, blue: 0.3081526458, alpha: 1), for: .normal)
            fullFurnished.layer.borderColor = borderColorSelected
        } else {
            fullFurnished.setTitleColor(#colorLiteral(red: 0.4274509804, green: 0.4666666667, blue: 0.4823529412, alpha: 1), for: .normal)
            fullFurnished.layer.borderColor = borderColor
        }
    }
    
    func updateSemiFurnishUI() {
        if let val = savedFilterArray[FiltersConstants.Filters.Furnishing.rawValue]?[FiltersConstants.FurnishingType.Semi.rawValue], val == true {
            semiFurnished.setTitleColor(#colorLiteral(red: 1, green: 0.2013165951, blue: 0.3081526458, alpha: 1), for: .normal)
            semiFurnished.layer.borderColor = borderColorSelected
        } else {
            semiFurnished.setTitleColor(#colorLiteral(red: 0.4274509804, green: 0.4666666667, blue: 0.4823529412, alpha: 1), for: .normal)
            semiFurnished.layer.borderColor = borderColor
        }
    }
    
    func updateNotFurnishUI() {
        if let val = savedFilterArray[FiltersConstants.Filters.Furnishing.rawValue]?[FiltersConstants.FurnishingType.Not.rawValue], val == true {
            notFurnished.setTitleColor(#colorLiteral(red: 1, green: 0.2013165951, blue: 0.3081526458, alpha: 1), for: .normal)
            notFurnished.layer.borderColor = borderColorSelected
        } else {
            notFurnished.setTitleColor(#colorLiteral(red: 0.4274509804, green: 0.4666666667, blue: 0.4823529412, alpha: 1), for: .normal)
            notFurnished.layer.borderColor = borderColor
        }
    }
    
    func updateFilterUI () {
        updateOneRKUI()
        updateOneBHKUI()
        updateTwoBHKUI()
        updateThreeBHKUI()
        updateFourBHKUI()
        updateFourPlusBHKUI()
        updateApartmentUI()
        updateIHUI()
        updateIFUI()
        updateFullFurnishUI()
        updateSemiFurnishUI()
        updateNotFurnishUI()
    }
    
}
