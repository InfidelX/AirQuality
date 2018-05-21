//
//  SensorsViewController.swift
//  AirQuality
//
//  Created by Jovanco Jovanovski on 5/10/18.
//  Copyright © 2018 Jovanco Jovanovski. All rights reserved.
//

import UIKit

class SensorsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SensorDelegate{
    @IBOutlet weak var tableView: UITableView!
    
    let networkManager = NetworkManager()
    let model = CreateModelObjects()
    let filterWorker = FilterSensors()
    
    var sensors = [Sensor]()
    var disabledSensors = [String]()
    var sensorDetails = [SensorDetails]()
    var sensorId: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchSensorsList()
        fetchSensorsDetails()
    }
    
    func fetchSensorsList () {
        networkManager.loadDataFor(urlString: networkManager.API.sensorsList, withCompletion: {(response) -> () in
            self.sensors = self.model.createSensors(array: response!)
            self.tableView.reloadData()
        })
    }
    
    func fetchSensorsDetails () {
        networkManager.loadDataFor(urlString: networkManager.API.data24, withCompletion: {(response) -> () in
            self.sensorDetails = self.model.createSensorDetails(array: response!)
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        checkForDisabledSensors()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sensors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "")
        if sensors[indexPath.row].disabled {
            cell.isUserInteractionEnabled = false
            cell.contentView.backgroundColor = UIColor.lightGray
        }
        cell.textLabel?.text = sensors[indexPath.row].sensorId
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sensor = sensors[indexPath.row]
        sensorId = sensor.sensorId
        performSegue(withIdentifier: "showSensorDetails", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let sensorDetailsVC = segue.destination as! SensorDetailsViewController
        sensorDetailsVC.sensorId = sensorId
        
        let filteredValues = filterWorker.filterForParticleType(sensorId: sensorId!, array: self.sensorDetails)
        
        sensorDetailsVC.particles = filteredValues
        sensorDetailsVC.delegate = self
    }

    func disableSensor(id: String) {
        disabledSensors.append(id)
    }
    
    func checkForDisabledSensors ()
    {
        if disabledSensors.count > 0 {
            sensors = filterWorker.disable(disabledSensors: disabledSensors, inSensors: &sensors)
            tableView.reloadData()
        }
    }
}

