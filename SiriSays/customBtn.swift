//
//  customBtn.swift
//  SimonSays
//
//  Created by Tom Dobson on 1/23/18.
//  Copyright © 2018 Dobson Studios. All rights reserved.
//

import Foundation
import UIKit

class customBtn: UIButton {
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                alpha = 0.6
            } else {
                alpha = 0.5
            }
        }
    }
    
}

