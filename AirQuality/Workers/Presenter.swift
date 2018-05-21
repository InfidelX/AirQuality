//
//  Presenter.swift
//  AirQuality
//
//  Created by Jovanco Jovanovski on 5/11/18.
//  Copyright © 2018 Jovanco Jovanovski. All rights reserved.
//

import Foundation

class Presenter {
    public static func present(value: Double) -> String {
        let result = String(format: "%.02f", value)
        return result
    }
}
