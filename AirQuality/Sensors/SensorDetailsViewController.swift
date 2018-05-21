//
//  SensorDetailsViewController.swift
//  AirQuality
//
//  Created by Jovanco Jovanovski on 5/11/18.
//  Copyright © 2018 Jovanco Jovanovski. All rights reserved.
//

import UIKit

protocol SensorDelegate: class {
    func disableSensor(id: String)
}

struct PMValues {
    let six: Double
    let twelve: Double
    let twentyFour: Double
}

class SensorDetailsViewController: UIViewController ,UITableViewDelegate, UITableViewDataSource {
    
    enum Period: Int {
        case six = 6
        case twelve = 12
        case twentyFour = 24
    }
    
    weak var delegate: SensorDelegate?
    
    @IBOutlet weak var tableView: UITableView!
    
    typealias Particles = (pm10: [SensorDetails], pm25: [SensorDetails])
    var particles = (pm10: [SensorDetails](), pm25: [SensorDetails]())
    
    var pm10AvgValues: PMValues?
    var pm25AvgValues: PMValues?
    
    var sensorId : String?
    var showPM10: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAverageValues()
    }
    
    func setupAverageValues () {
        let averageWorker = AverageValuesWorker(pm10: particles.pm10, pm25: particles.pm25)
        
        pm10AvgValues = PMValues (six: averageWorker.pm10Average(inLast: Period.six.rawValue),
                                  twelve: averageWorker.pm10Average(inLast: Period.twelve.rawValue),
                                  twentyFour: averageWorker.pm10Average(inLast: Period.twentyFour.rawValue))
        
        pm25AvgValues = PMValues(six: averageWorker.pm25Average(inLast: Period.six.rawValue),
                                 twelve: averageWorker.pm25Average(inLast: Period.twelve.rawValue),
                                 twentyFour: averageWorker.pm25Average(inLast: Period.twentyFour.rawValue))
    }
    
    @IBAction func particlesFilterChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            showPM10 = true
        }
        else{
            showPM10 = false
        }
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SensorDetailsCell") as! SensorsTableViewCell
        if showPM10 {
            cell.configureCellFor(row: indexPath.row, values: pm10AvgValues!)
        }
        else{
            cell.configureCellFor(row: indexPath.row, values: pm25AvgValues!)
        }
        return cell
    }
    @IBAction func disableSelectedSensor(_ sender: UIButton) {
        self.delegate?.disableSensor(id: sensorId!)
    }
}
