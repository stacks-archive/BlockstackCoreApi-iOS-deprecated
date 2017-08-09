//  Created by lsease on 10/11/16.
//  Copyright © 2016 Bedkin. All rights reserved.
//

import UIKit

class OutlineButton : UIButton
{
    override func setNeedsDisplay() {
        self.backgroundColor = UIColor.clear
        self.tintColor = self.tintColor
        self.setTitleColor(self.tintColor, for: .normal)
        self.titleLabel?.textColor = self.tintColor
        self.layoutIfNeeded()
        self.layer.cornerRadius = 4
        self.layer.masksToBounds = true
        self.layer.borderWidth = 2
        self.layer.borderColor = self.tintColor.cgColor
    }
    
}

