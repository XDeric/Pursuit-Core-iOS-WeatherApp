import UIKit
import CoreLocation

enum LocationFetchingError: Error {
    case error(Error)
    case noErrorMessage
}

class ZipCodeHelper {
    private init() {}
    
    static let shared = ZipCodeHelper()
    
    static func getLatLong(fromZipCode zipCode: String, completionHandler: @escaping (Result<(lat: Double, long: Double, name:String), LocationFetchingError>) -> Void) {
        let geocoder = CLGeocoder()
        DispatchQueue.global(qos: .userInitiated).async {
            geocoder.geocodeAddressString(zipCode){(placemarks, error) -> Void in
                DispatchQueue.main.async {
                    if let placemark = placemarks?.first, let coordinate = placemark.location?.coordinate, let name = placemark.locality  {
                        print(name)
                        completionHandler(.success((coordinate.latitude, coordinate.longitude, name)))
                    } else {
                        let locationError: LocationFetchingError
                        if let error = error {
                            locationError = .error(error)
                        } else {
                            locationError = .noErrorMessage
                        }
                        completionHandler(.failure(locationError))
                    }
                }
            }
        }
    }
    
    
    
}

class Location{
    private init() {}
    
    static let manager = Location()
    
    func getWeather(zipcode: String, completionHandler: @escaping (Result<City, AppError>) -> Void) {
        
        ZipCodeHelper.getLatLong(fromZipCode: zipcode) { (result) in
            switch result {
            case .failure(let error):
                completionHandler(.failure(.other(rawError: error)))
            case .success(let lat,let long, let name):
                
                let urlStr = "https://api.darksky.net/forecast/\(Secret.key)/\(lat),\(long)"
                    guard let url = URL(string: urlStr) else {
                    completionHandler(.failure(.badURL))
                    return
                }
                //                print(url)
                NetworkHelper.manager.performDataTask(withURL: url, andMethod: .get) { (result) in
                    switch result {
                    case .failure(let error):
                        completionHandler(.failure(error))
                    case .success(let data):
                        do {
                            let weatherData = try JSONDecoder().decode(Sky.self, from: data)
                            let forecast = City(city: name, skyInfo: weatherData)
                            completionHandler(.success(forecast))
                        } catch {
                            print(error)
                            completionHandler(.failure(.couldNotParseJSON(rawError: error)))
                        }
                    }
                }
            }
            
        }
    }
}

