//
//  FilterSensors.swift
//  AirQuality
//
//  Created by Jovanco Jovanovski on 5/11/18.
//  Copyright © 2018 Jovanco Jovanovski. All rights reserved.
//

import Foundation

class FilterSensors {
    
    func filterForParticleType(sensorId: String, array: [SensorDetails]) -> (_: [SensorDetails], _: [SensorDetails]) {
        let filteredArray = array.filter{$0.sensorId == sensorId}
        let filteredPM10 = filteredArray.filter{$0.type == "pm10"}
        let filteredPM25 = filteredArray.filter{$0.type == "pm25"}
        return (filteredPM10, filteredPM25)
    }
    
    func disable(disabledSensors: [String], inSensors sensors: inout [Sensor]) -> [Sensor] {
        var disabledSensor: Sensor?
        for sensorId in disabledSensors {
            for (index, item) in sensors.enumerated() {
                var sensor = item
                if sensorId == sensor.sensorId {
                    sensors.remove(at: index)
                    sensor.disabled = true
                    disabledSensor = sensor
                    sensors.insert(disabledSensor!, at: index)
                }
            }
        }
        return sensors
    }
}
