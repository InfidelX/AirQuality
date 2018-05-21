//
//  ModelsTests.swift
//  AirQualityTests
//
//  Created by Jovanco Jovanovski on 5/20/18.
//  Copyright © 2018 Jovanco Jovanovski. All rights reserved.
//

@testable import AirQuality
import XCTest

class ModelsTests: XCTestCase {
    
    var sut: CreateModelObjects!
    var testSensors: [Sensor]!
    var testSensorsDetails: [SensorDetails]!
    
    override func setUp() {
        super.setUp()
        setupModels()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func setupModels ()
    {
        sut = CreateModelObjects()
        testSensors = [TestSensors.sensorOne, TestSensors.sensorTwo, TestSensors.sensorThree]
        testSensorsDetails = [TestSensorDetails.sensorOne, TestSensorDetails.sensorTwo, TestSensorDetails.sensorThree]
    }
    
    func test_CreateSensorsShouldReturnArray_withSensorObjects ()
    {
        //Given
        var actual = [[String:AnyObject]]()
        actual.append(["sensorId":"1002" as AnyObject])
        actual.append(["sensorId":"11888f3a-bc5e-4a0c-9f27-702984decedf" as AnyObject])
        actual.append(["sensorId":"6c4d9b3a-4e60-4131-8a95-022335856b17" as AnyObject])
        
        //When
        var expected = [Sensor]()
        expected = sut.createSensors(array: actual as [AnyObject])
        
        //Then
        XCTAssertEqual(testSensors.count, expected.count, "createSensors() should return a list of sensors")
        XCTAssertEqual(testSensors[0], expected[0], "first elements should match")
    }
    
    func test_CreateSensorDetailsShouldReturnArray_withSensorDetailsObjects ()
    {
        //Given
        var actual = [[String:AnyObject]]()
        actual.append(["position":"41.995828195848325,21.484215259552002" as AnyObject,
                       "sensorId":"1002" as AnyObject,
                       "stamp":"2018-05-20T07:11:13+02:00" as AnyObject,
                       "type":"pm10" as AnyObject,
                       "value":"4" as AnyObject,
                       "year":2018 as AnyObject
            ])
        actual.append(["position":"41.995828195848325,21.484215259552002" as AnyObject,
                       "sensorId":"6c4d9b3a-4e60-4131-8a95-022335856b17" as AnyObject,
                       "stamp":"2018-05-20T07:11:13+02:00" as AnyObject,
                       "type":"pm10" as AnyObject,
                       "value":"12.46" as AnyObject,
                       "year":2018 as AnyObject
            ])
        actual.append(["position":"41.995828195848325,21.484215259552002" as AnyObject,
                       "sensorId":"11888f3a-bc5e-4a0c-9f27-702984decedf" as AnyObject,
                       "stamp":"2018-05-20T07:11:13+02:00" as AnyObject,
                       "type":"pm10" as AnyObject,
                       "value":"15.24" as AnyObject,
                       "year":2018 as AnyObject
            ])
        
        //When
        var expected = [SensorDetails]()
        expected = sut.createSensorDetails(array: actual as [AnyObject])
        
        //Then
        XCTAssertEqual(testSensorsDetails.count, expected.count, "createSensorsDetails() should return a list of sensorDetails")
    }
}
