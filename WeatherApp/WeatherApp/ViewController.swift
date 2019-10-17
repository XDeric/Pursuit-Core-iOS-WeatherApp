import Foundation
import UIKit

class ViewController: UIViewController {
    
    var weather = [DailyData](){
        didSet{
            collectionView.reloadData()
        }
    }
    var zipcode = "10008"
    
    
    let layout = UICollectionViewFlowLayout()
    lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: CGRect(x: 0 , y: 88 , width: 414, height: 232), collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        collection.dataSource = self
        collection.delegate = self
        let nib = UINib(nibName: "WeatherCollectionViewCell", bundle: nil)
        collection.register(nib, forCellWithReuseIdentifier: "weatherCell")
        //when you create the cell file, register the cell here and give it an id
        
        return collection
    }()
    
    
    var searchText: UITextField = {
        let text = UITextField(frame: CGRect(x: 20 , y: 400, width: 374, height: 34))
        text.placeholder = "Enter ZipCode"
        text.backgroundColor = .white
        return text
    }()
    
    var label: UILabel = {
        var titleLabel = UILabel(frame: CGRect(x: 20, y: 350, width: 374, height: 34))
        titleLabel.text = "test"
        titleLabel.backgroundColor = .white
        return titleLabel
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        self.view.addSubview(collectionView)
        self.view.addSubview(searchText)
        self.view.addSubview(label)
        self.view.backgroundColor = .cyan
        // Do any additional setup after loading the view.
    }
    
    
    func loadData(){
        Location.manager.getWeather(zipcode: zipcode) { (result) in
        
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let weather):
                     
                    self.weather = weather
                    
                
            }
        }
    }
        
        
        
        
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weather.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 414, height: 180)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "weatherCell", for: indexPath) as? WeatherCollectionViewCell else{ return UICollectionViewCell() }
        let date = Date(timeIntervalSince1970: TimeInterval(weather[indexPath.row].time))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: date)
        
        cell.weatherImage.image = UIImage(named: weather[indexPath.row].icon)
        cell.date.text = dateString
        cell.high.text = "High: \(weather[indexPath.row].temperatureHigh)"
        cell.low.text = "Low: \(weather[indexPath.row].temperatureLow)"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let forecast = weather[indexPath.row]
        let dVC = WeatherDetailViewController()
        dVC.weatherData = forecast
        self.navigationController?.pushViewController(dVC, animated: true)
    }

    
    
}
