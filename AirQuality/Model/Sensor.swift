//
//  Sensor.swift
//  AirQuality
//
//  Created by Jovanco Jovanovski on 5/10/18.
//  Copyright © 2018 Jovanco Jovanovski. All rights reserved.
//

import Foundation

struct Sensor: Equatable {
    let sensorId: String
    var disabled: Bool
}

func ==(lhs: Sensor, rhs: Sensor) -> Bool
{
    return lhs.sensorId == rhs.sensorId
        && lhs.disabled == rhs.disabled
}
