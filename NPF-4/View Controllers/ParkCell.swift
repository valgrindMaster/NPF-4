//
//  ParkCell.swift
//  NPF-4
//
//  Created by Oliver Haynes on 4/22/18.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation
import UIKit

class ParkCell: UITableViewCell {
    
    var park: Park?
    
    convenience init(park: Park, reuseIdentifier: String) {
        self.init(style: UITableViewCellStyle.subtitle, reuseIdentifier: reuseIdentifier)
        self.park = park
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: UITableViewCellStyle.subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func getPark() -> Park {
        return self.park!
    }
}
