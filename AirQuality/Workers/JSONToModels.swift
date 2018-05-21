//
//  JSONToModels.swift
//  AirQuality
//
//  Created by Jovanco Jovanovski on 5/11/18.
//  Copyright © 2018 Jovanco Jovanovski. All rights reserved.
//

import Foundation

class CreateModelObjects {
    
    enum ServerKeys: String {
        case position = "position"
        case sensorId = "sensorId"
        case stamp = "stamp"
        case type = "type"
        case value = "value"
        case year = "year"
    }

    func createSensors(array: [AnyObject]) -> [Sensor] {
        var sensors = [Sensor]()
        for sensor in array {
            let sensor = createSensor(item: sensor)
            sensors.append(sensor)
        }
        return sensors
    }
    
    private func createSensor(item: AnyObject) -> Sensor {
        let sensorId = item.object(forKey: ServerKeys.sensorId.rawValue) as! String
        let sensor = Sensor(sensorId: sensorId, disabled: false)
        return sensor
    }
    
    func createSensorDetails(array: [AnyObject]) -> [SensorDetails] {
        var sensorsDetails = [SensorDetails]()
        for sensor in array {
            let sensorDetail = createSensorInfo(item: sensor)
            sensorsDetails.append(sensorDetail)
        }
        return sensorsDetails
    }
    
    private func createSensorInfo(item: AnyObject) -> SensorDetails {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let position = item.object(forKey: ServerKeys.position.rawValue) as! String
        let sensorId = item.object(forKey: ServerKeys.sensorId.rawValue) as! String
        let timeStamp = formatter.date(from: item.object(forKey: ServerKeys.stamp.rawValue) as! String)
        let type = item.object(forKey: ServerKeys.type.rawValue) as! String
        let value = item.object(forKey: ServerKeys.value.rawValue) as! String
        let year = item.object(forKey: ServerKeys.year.rawValue) as! NSNumber

        let sensorDetail = SensorDetails(position: position, sensorId: sensorId, stamp: timeStamp!, type: type, value: value, year: year)
        
        return sensorDetail
    }
}
