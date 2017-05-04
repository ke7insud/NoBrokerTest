//
//  RoundRectButton.swift
//  NoBrokerBrowseAndFilter
//
//  Created by Sudhanshu on 5/3/17.
//  Copyright © 2017 Sudhanshu. All rights reserved.
//

import UIKit

@IBDesignable class RoundRectButton: UIButton {

    @IBInspectable var borderColor:UIColor?
    @IBInspectable var fillColor:UIColor?
    @IBInspectable var borderRadius:Float = 4.0
    @IBInspectable var borderWidth:Float = 2.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        self.layer.cornerRadius = CGFloat(self.borderRadius)
        self.layer.borderWidth = CGFloat(self.borderWidth)
        self.layer.borderColor = self.borderColor?.cgColor ?? UIColor.clear.cgColor
        self.layer.backgroundColor = self.fillColor?.cgColor ?? UIColor.clear.cgColor
        
        
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

