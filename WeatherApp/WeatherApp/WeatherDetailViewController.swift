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
    var cityInfo: City!
    var pictureInfo = [Hits](){
        didSet{
            setPicture()
        }
    }
    var saveImage = UIImage()
    
    
    var image: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 44, width: 414, height: 332))
        image.backgroundColor = .blue
        return image
    }()
    var labelTitle: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 385, width: 414, height: 35))
        label.text = ""
        return label
    }()
    var label1: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 420, width: 414, height: 35))
        label.text = ""
        return label
    }()
    var label2: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 455, width: 414, height: 35))
        label.text = ""
        return label
    }()
    var label3: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 490, width: 414, height: 35))
        label.text = ""
        
        return label
    }()
    var label4: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 525, width: 414, height: 35))
        label.text = ""
        
        return label
    }()
    var label5: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 560, width: 414, height: 35))
        label.text = ""
        
        return label
    }()
    var label6: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 600, width: 414, height: 35))
        label.text = ""
        
        return label
    }()
    
    lazy var saveButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(save))
        return button
    }()
    
    @objc func save() {
        let alert = UIAlertController(title: "Save Picture?", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in self.savePicture()}))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem  = saveButton
        self.view.backgroundColor = .white
        addViews()
        setLabelText()
        loadPicture()
        // Do any additional setup after loading the view.
    }
    func loadPicture(){
        ImageManager.manager.getImage(search: cityInfo.city.replacingOccurrences(of: " ", with: "") ) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let picture):
                    self.pictureInfo = picture
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    func setPicture(){
        ImageHelper.shared.getImage(urlStr: pictureInfo.randomElement()!.largeImageURL) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let picture):
                    self.image.image = picture
                    self.saveImage = picture
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func savePicture(){
        let newSave = Favorite(image: (( saveImage.pngData() ?? UIImage(named: "noPic")!.pngData())!))
        DispatchQueue.global(qos: .utility).async {
            try? SavePersistenceHelper.manager.save(newFavorite: newSave)
//            DispatchQueue.main.async {
//                self.navigationController?.popViewController(animated: true)
//            }
        }
    }
    
    
    func setLabelText(){
        let date = Date(timeIntervalSince1970: TimeInterval(weatherData.time))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: date)
        
        labelTitle.text = "\(dateString)"
        label1.text = "Sunrise: \(dateFormatting(time: weatherData.sunriseTime))"
        label2.text = "Sunset: \(dateFormatting(time: weatherData.sunsetTime))"
        label3.text = "High: \(weatherData.temperatureHigh) F°"
        label4.text = "Low: \(weatherData.temperatureLow) F°"
        label5.text = "Wind Speed: \(weatherData.windGust) mph"
        label6.text = "\(weatherData.summary)"
    }
    func dateFormatting(time: Int)-> String{
        let date = Date(timeIntervalSince1970: TimeInterval(time))
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .medium
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
    func addViews(){
        self.view.addSubview(labelTitle)
        self.view.addSubview(image)
        self.view.addSubview(label1)
        self.view.addSubview(label2)
        self.view.addSubview(label3)
        self.view.addSubview(label4)
        self.view.addSubview(label5)
        self.view.addSubview(label6)
    }
    
}
