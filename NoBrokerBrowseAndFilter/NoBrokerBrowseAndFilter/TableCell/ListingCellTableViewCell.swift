//
//  ListingCellTableViewCell.swift
//  NoBrokerBrowseAndFilter
//
//  Created by Sudhanshu on 5/2/17.
//  Copyright © 2017 Sudhanshu. All rights reserved.
//

import UIKit
import SDWebImage

class ListingCellTableViewCell: UITableViewCell {

    
    @IBOutlet weak var mTitle: UILabel!
    @IBOutlet weak var mSubtitle: UILabel!
    @IBOutlet weak var mImage: UIImageView!
    @IBOutlet weak var mCost: UILabel!
    @IBOutlet weak var mFurnishing: UILabel!
    @IBOutlet weak var mBathrooms: UILabel!
    @IBOutlet weak var mSqFt: UILabel!
    @IBOutlet weak var shortlistBtn: UIButton!
    @IBOutlet weak var callBtn: UIButton!
    @IBOutlet weak var mainView: UIView!
    
    @IBAction func didTappedLoveBtn(_ sender: Any) {
        
    }
    
    @IBAction func didTappedCallBtn(_ sender: Any) {
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cellUITweaked()
        
        if let shortlistBtnImage = shortlistBtn?.imageView?.image {
        shortlistBtn?.imageView?.image = shortlistBtnImage.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        shortlistBtn?.imageView?.tintColor = UIColor(red:134/255, green:131/255, blue:131/255, alpha:1.0)
        }
        
        if let callButton = callBtn?.imageView?.image {
            callBtn?.imageView?.image = callButton.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
            callBtn?.imageView?.tintColor = UIColor(red: 253/255, green: 55/255, blue: 83/255, alpha: 1.0)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(_ listingModel : ListingModel) {
        
        self.mTitle.text = listingModel.propertyTitle
        self.mSubtitle.text = listingModel.secondaryTitle
        self.mCost.text = listingModel.rent
        self.mFurnishing.text = listingModel.furnishing
        self.mBathrooms.text = listingModel.bathroom
        self.mSqFt.text = listingModel.propertySize
        
        if let imageArray = listingModel.imageArray, imageArray.count > 0 {
                mImage.sd_setImage(with: URL(string: imageArray[0]), placeholderImage: UIImage(named: "placeholderHome"))
        } else {
            self.mImage.image = UIImage(named: "placeholderHome")
        }
    }
    
    override func prepareForReuse() {
        self.mTitle.text = ""
        self.mSubtitle.text = ""
        self.mCost.text = ""
        self.mFurnishing.text = ""
        self.mBathrooms.text = ""
        self.mSqFt.text = ""
        self.mImage.image = nil
    }
    
    func cellUITweaked() {
        self.mainView.layer.cornerRadius = 4.0
        self.mainView.layer.borderWidth = 1.0
        self.mainView.layer.borderColor = UIColor(red: 187/255, green: 187/255, blue: 187/255, alpha: 1.0).cgColor
        self.mainView.clipsToBounds = true
        
        self.mainView.layer.shadowColor = UIColor(red: 187/255, green: 187/255, blue: 187/255, alpha: 1.0).cgColor
        self.mainView.layer.shadowOffset = CGSize.zero
        self.mainView.layer.shadowOpacity = 1;
        self.mainView.layer.shadowRadius = 1.0;
    }

}
