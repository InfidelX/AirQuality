//
//  AverageValuesTest.swift
//  AirQualityTests
//
//  Created by Jovanco Jovanovski on 5/20/18.
//  Copyright © 2018 Jovanco Jovanovski. All rights reserved.
//
@testable import AirQuality
import XCTest

class AverageValuesTest: XCTestCase {
    
    var sut: AverageValuesWorker!
    var testSensorDetails: [SensorDetails]!
    
    override func setUp() {
        super.setUp()
        setupAverageWorker()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func setupAverageWorker ()
    {
        let pm10 = [TestSensorDetails.sensorOne, TestSensorDetails.sensorTwo, TestSensorDetails.sensorThree]
        let pm25 = [SensorDetails]()
        sut = AverageValuesWorker(pm10: pm10, pm25: pm25)
    }
    
    func testCalculateAverageValue ()
    {
        // Given
        let expected = sut.pm10Average(inLast: 6)
        
        // When
        let actual = 10.8133333333333
        
        // Then
        XCTAssertEqual(expected, actual, accuracy: 0.0000000000001)
    }
    
    func testEmptyInputShouldReturnZero ()
    {
        // Given
        let expected = sut.pm25Average(inLast: 6)
        
        // When
        let actual = 0.0
        
        // Then
        XCTAssertEqual(expected, actual)
    }
    
}
