//
//  BedkinSecondaryButton.swift
//  Bedkin
//
//  Created by lsease on 10/11/16.
//  Copyright © 2016 Bedkin. All rights reserved.
//

import UIKit
import SeaseAssist

class BedkinSecondaryButton : UIButton
{
    override func setNeedsDisplay() {
        self.backgroundColor = UIColor.clear
        self.tintColor = Constants.Color.mainTint
        self.setTitleColor(Constants.Color.mainTint, for: .normal)
        self.titleLabel?.textColor = Constants.Color.mainTint
        self.titleLabel?.font = UIFont(name: "Lato", size: self.frame.size.height)
        self.makeClean()
        self.layer.cornerRadius = 4
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.titleLabel!.font = UIFont(name: "Lato-Bold", size: 18)
    }
}

