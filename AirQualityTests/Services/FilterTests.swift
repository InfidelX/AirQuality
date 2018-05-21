//
//  FilterTests.swift
//  AirQualityTests
//
//  Created by Jovanco Jovanovski on 5/20/18.
//  Copyright © 2018 Jovanco Jovanovski. All rights reserved.
//
import XCTest

class FilterTests: XCTestCase {
    
    var sut: FilterSensors!
    var particles = (pm10: [SensorDetails](), pm25: [SensorDetails]())
    var testSensorsDetails: [SensorDetails]!

    override func setUp() {
        super.setUp()
        setupFilter()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func setupFilter ()
    {
        sut = FilterSensors()
        testSensorsDetails = [TestSensorDetails.sensorOne, TestSensorDetails.sensorTwo, TestSensorDetails.sensorThree]
    }
    
    func test_FilterShouldReturnTuple_ofPm10AndPm25Particles_ForGivenSensorId ()
    {
        //Given
        let sensorId = "11888f3a-bc5e-4a0c-9f27-702984decedf"
        
        //When
        particles = sut.filterForParticleType(sensorId: sensorId, array: testSensorsDetails)
        
        //Then
        XCTAssertEqual(particles.pm10.count, 2, "pm10 should contain 2 elements")
        XCTAssertEqual(particles.pm25.count, 1, "pm25 should contain 1 element")
    }
    
    func test_disableMethodShouldDisableSensor ()
    {
        //Given
        let sensor = Sensor(sensorId: "b10ee8d4-daac-4d70-afe6-54d4062b592b", disabled: false)
        let sensorToDisable = [sensor.sensorId]
        
        var testSensors = [TestSensors.sensorOne, TestSensors.sensorTwo, TestSensors.sensorThree]
        var isSensorDisabled = false
        
        //When
        let disabledSensors = sut.disable(disabledSensors: sensorToDisable, inSensors: &testSensors)
        
        for sensor in disabledSensors {
            isSensorDisabled = sensor.disabled
        }
        
        //Then
        XCTAssertEqual(isSensorDisabled, true, "disabledSensors should contain 1 disabled sensor")
    }
}
