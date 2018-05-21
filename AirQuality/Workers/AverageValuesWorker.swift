//
//  AverageValuesWorker.swift
//  AirQuality
//
//  Created by Jovanco Jovanovski on 5/11/18.
//  Copyright © 2018 Jovanco Jovanovski. All rights reserved.
//

import Foundation

import Foundation

class AverageValuesWorker {
    
    let pmTen: [SensorDetails]?
    let pmTwentyFive: [SensorDetails]?
    
    init(pm10: [SensorDetails], pm25: [SensorDetails]) {
        self.pmTen = pm10
        self.pmTwentyFive = pm25
    }
    
    let now = Date()
    
    public func pm10Average (inLast: Int) -> Double {
        if pmTen!.count == 0 {
            return 0.0
        }
        let avg = pmTen!.filter({under(hours:inLast, end: $0.stamp)})
        let sum = avg.reduce(0) {(result, next) -> Double in
            return result + Double(next.value)!
        }
        return sum/Double(avg.count)
    }
    
    public func pm25Average (inLast: Int) -> Double {
        if pmTwentyFive!.count == 0 {
            return 0.0
        }
        let avg = pmTwentyFive!.filter({under(hours:inLast, end: $0.stamp)})
        let sum = avg.reduce(0) {(result, next) -> Double in
            return result + Double(next.value)!
        }
        return sum/Double(avg.count)
    }
    
    private func under(hours: Int, end: Date) -> Bool {
        let tempHours = Calendar.current.dateComponents([.hour], from: now, to: end).hour!
        if abs(tempHours) <= hours {
            return true
        }
        return false
    }
}
