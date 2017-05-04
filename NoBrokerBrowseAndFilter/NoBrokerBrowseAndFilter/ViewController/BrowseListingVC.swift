//
//  BrowseListingVC.swift
//  NoBrokerBrowseAndFilter
//
//  Created by Sudhanshu on 5/2/17.
//  Copyright © 2017 Sudhanshu. All rights reserved.
//

import UIKit
import Alamofire

class BrowseListingVC: UIViewController {

    
    @IBOutlet weak var listingtableView: UITableView!
    
    var listingModelArr = [ListingModel]()
    var listingModelPageArr = [ListingModel]()
    var pageNo : Int = 1
    
    var filters = [String: Any]()
    var savedFilterArray = FiltersConstants.savedFilterArray
    
    override func viewDidLoad() {
        super.viewDidLoad()
        propertyListingAPI()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  
    @IBAction func filterButtonDidTapped(_ sender: Any) {
        
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let filterModalVC = storyBoard.instantiateViewController(withIdentifier: "FilterModalVC") as! FilterModalVC
        
        filterModalVC.filterTapped = { (filterArray, savedFilters) in
            
            self.filters.removeAll()
            for (key, value) in filterArray {
                self.filters[key] = value
            }
            
            self.listingModelArr.removeAll()
            self.listingModelPageArr.removeAll()
            self.pageNo = 1
            self.savedFilterArray = savedFilters
            
            self.propertyListingAPI()
        }
        
        filterModalVC.savedFilterArray = self.savedFilterArray
        
        self.present(filterModalVC, animated: true, completion: nil)
        
    }
    
    func propertyListingAPI() {
        
        var listingAPIBaseUrl = "http://www.nobroker.in/api/v1/property/filter/region/ChIJLfyY2E4UrjsRVq4AjI7zgRY/?pageNo=\(pageNo)"
        
        print(listingAPIBaseUrl)
        
        for (filter,val) in filters {
            listingAPIBaseUrl = "\(listingAPIBaseUrl)\(filter)=\(val)"
        }
        
        print(listingAPIBaseUrl)
        
        Alamofire.request(listingAPIBaseUrl, method: .get,
                          encoding: JSONEncoding.default)
            .responseJSON { response in
                guard response.result.error == nil else {
                    // got an error in getting the data, need to handle it
                    print("error calling Get")
                    print(response.result.error!)
                    return
                }
                // make sure we got some JSON since that's what we expect
                guard let json = response.result.value as? [String: Any] else {
                    print("didn't get object as JSON from API")
                    print("Error: \(String(describing: response.result.error))")
                    return
                }
                
                // getting city data
                if let otherParams = json["otherParams"] as? [String:Any] {
                    let cityModel = OtherParamsModel(responseData: otherParams)
                    self.title = cityModel.cityModel.city?.capitalized
                } else{
                    print("Couldn't get city data")
                }
                
                
                // getting listing data
                guard let data = json["data"] as? [[String:Any]] else {
                    print("Could not get data from JSON")
                    return
                }
                
                let apiModel =  ListingAPIModel(responseData: data)
                self.listingModelPageArr =  apiModel.listingModelArr
                
                // appending current results in the previous
                self.listingModelArr.append(contentsOf: self.listingModelPageArr)
                
                DispatchQueue.main.async {
                    self.listingtableView.reloadData()
                }
        }
    }
}

//MARK: UITableViewDataSource methods
extension BrowseListingVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listingModelArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let listingCellTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ListingCellTableViewCell", for: indexPath) as! ListingCellTableViewCell
            listingCellTableViewCell.configureCell(listingModelArr[indexPath.row])
            return listingCellTableViewCell
    }
}

//MARK: UITableViewDelegate methods
extension BrowseListingVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 330
    }
}

extension BrowseListingVC: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y == (scrollView.contentSize.height - scrollView.bounds.height) {
            self.pageNo += 1
            self.propertyListingAPI()
        }
    }
    
}

