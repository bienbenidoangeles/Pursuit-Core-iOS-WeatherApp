//
//  WeatherAppTests.swift
//  WeatherAppTests
//
//  Created by Bienbenido Angeles on 2/5/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

@testable
import WeatherApp
import XCTest

class WeatherAppTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

     func testZipcodeToCoordinates() {
       // arrange
       let zipcode = "10023"
       
       let exp = XCTestExpectation(description: "zipcode parsed")
       
       // act
       ZipCodeHelper.getLatLong(fromZipCode: zipcode) { (result) in
         switch result {
         case .failure(let fetchingError):
           XCTFail("coordinates fetching error: \(fetchingError)")
         case .success(let coordinate):
           // assert
           XCTAssertEqual(coordinate.lat, 40.7754123)
           exp.fulfill()
         }
       }
       
       wait(for: [exp], timeout: 3.0)
     }
    
    func testZipCodeToPhotoIsNil(){
        //arrange
        let zipcode = "10023"
        let exp = XCTestExpectation(description: "zipcode parsed")
        
        //act
        ZipCodeHelper.getLatLong(fromZipCode: zipcode) { (result) in
          switch result {
          case .failure(let fetchingError):
            XCTFail("coordinates fetching error: \(fetchingError)")
          case .success(let coordinate):
            PhotoAPIClient.getPhotos(with: coordinate.placeName) { (result) in
                switch result{
                case .failure(let appError):
                    XCTFail("coordinates fetching error: \(appError)")
                case .success(let photo):
                    //assert
                    XCTAssertNotNil(photo)
                    exp.fulfill()
                }
            }
          }
        }
        
        wait(for: [exp], timeout: 3.0)
    }

}
