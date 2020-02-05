import UIKit
import CoreLocation
import NetworkHelper

enum LocationFetchingError: Error {
    case error(Error)
    case noErrorMessage
}

class ZipCodeHelper {
    private init() {}
//    static func getLatLong(fromZipCode zipCode: String, completionHandler: @escaping (Result<(lat: Double, long: Double), LocationFetchingError>) -> Void) {
//        let geocoder = CLGeocoder()
//        DispatchQueue.global(qos: .userInitiated).async {
//            geocoder.geocodeAddressString(zipCode){(placemarks, error) -> Void in
//                DispatchQueue.main.async {
//                    if let placemark = placemarks?.first, let coordinate = placemark.location?.coordinate {
//                        completionHandler(.success((coordinate.latitude, coordinate.longitude)))
//                    } else {
//                        let locationError: LocationFetchingError
//                        if let error = error {
//                            locationError = .error(error)
//                        } else {
//                            locationError = .noErrorMessage
//                        }
//                        completionHandler(.failure(locationError))
//                    }
//                }
//            }
//        }
//    }
    
    static func getLatLong(fromZipCode zipCode: String,
                           completionHandler: @escaping (Result<(lat: Double, long: Double, placeName: String), LocationFetchingError>) -> Void) {
      let geocoder = CLGeocoder()
      DispatchQueue.global(qos: .userInitiated).async {
        geocoder.geocodeAddressString(zipCode){(placemarks, error) -> Void in
          DispatchQueue.main.async {
            if let placemark = placemarks?.first,
              let coordinate = placemark.location?.coordinate,
              let name = placemark.locality {
              completionHandler(.success((lat: coordinate.latitude, long: coordinate.longitude, placeName: name)))
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

class WeatherHelper {
    static func getWeather(from coordinates: (Double, Double), completion: @escaping(Result<Weather,AppError>)->()){
        let endPointURL = "https://api.darksky.net/forecast/\(Secrets.secret)/\(coordinates.0),\(coordinates.1)"
        
        guard let url = URL(string: endPointURL) else {
            completion(.failure(.badURL(endPointURL)))
            return
        }
        
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result{
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do{
                    let weather = try JSONDecoder().decode(Weather.self, from: data)
                    completion(.success(weather))
                } catch{
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
