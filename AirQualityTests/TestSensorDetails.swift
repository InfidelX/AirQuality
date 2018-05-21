//
//  TestSensorDetails.swift
//  AirQualityTests
//
//  Created by Jovanco Jovanovski on 5/20/18.
//  Copyright © 2018 Jovanco Jovanovski. All rights reserved.
//

import XCTest

struct TestSensorDetails {
    static let position = "41.995828195848325,21.484215259552002"
    static let sensorId = "11888f3a-bc5e-4a0c-9f27-702984decedf"
    static let timeStamp = Date()
    static let typePm10 = "pm10"
    static let typePm25 = "pm25"
    
    static let valueOne = "4.74"
    static let valueTwo = "15.24"
    static let valueThree = "12.46"
    
    static let year = NSNumber(integerLiteral: 2018)
    
    static let sensorOne = SensorDetails(position: position, sensorId: sensorId, stamp: timeStamp, type: typePm10, value: valueOne, year: year)
    static let sensorTwo = SensorDetails(position: position, sensorId: sensorId, stamp: timeStamp, type: typePm25, value: valueTwo, year: year)
    static let sensorThree = SensorDetails(position: position, sensorId: sensorId, stamp: timeStamp, type: typePm10, value: valueThree, year: year)
}
