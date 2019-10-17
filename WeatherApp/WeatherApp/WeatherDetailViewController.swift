//
//  WeatherDetailViewController.swift
//  WeatherApp
//
//  Created by EricM on 10/16/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import UIKit

class WeatherDetailViewController: UIViewController {
    var weatherData: DailyData!
    
    
    var labelTitle: UILabel = {
        let label = UILabel()
        
        return label
    }()
    var label1: UILabel = {
        let label = UILabel()
        
        return label
    }()
    var label2: UILabel = {
        let label = UILabel()
        
        return label
    }()
    var label3: UILabel = {
        let label = UILabel()
        
        return label
    }()
    var label4: UILabel = {
        let label = UILabel()
        
        return label
    }()
    var saveButton: UIButton = {
       let button = UIButton()
        
        return button
    }()
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
}
