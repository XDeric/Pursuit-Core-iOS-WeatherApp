//
//  WeatherCollectionViewCell.swift
//  WeatherApp
//
//  Created by EricM on 10/16/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import UIKit

class WeatherCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var high: UILabel!
    @IBOutlet weak var low: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
