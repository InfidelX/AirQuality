//
//  SensorsTableViewCell.swift
//  AirQuality
//
//  Created by Jovanco Jovanovski on 5/11/18.
//  Copyright © 2018 Jovanco Jovanovski. All rights reserved.
//

import UIKit

class SensorsTableViewCell: UITableViewCell {
        
    enum Description: String {
        case Six = "Avarage value in the last 6 hours is:"
        case Twelve = "Avarage value in the last 12 hours is:"
        case TwentyFour = "Avarage value in the last 24 hours is:"
    }
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var arrowImageVIew: UIImageView!
    
    func configureCellFor(row: Int, values: PMValues) {
        switch row {
        case 0:
            descriptionLabel.text = Description.Six.rawValue
            valueLabel.text = Presenter.present(value: values.six)
        case 1:
            descriptionLabel.text = Description.Twelve.rawValue
            valueLabel.text = Presenter.present(value: values.twelve)
            if values.twelve != 0.0 {
                if arrowImageVIew.isHidden {
                    arrowImageVIew.isHidden = false
                }
                if values.six > values.twelve {
                    arrowImageVIew.image =  UIImage(named: "down")
                }
                else{
                    arrowImageVIew.image =  UIImage(named: "up")
                }
            }
            else{
                arrowImageVIew.isHidden = true
            }
        case 2:
            descriptionLabel.text = Description.TwentyFour.rawValue
            valueLabel.text = Presenter.present(value: values.twentyFour)
        default:
            descriptionLabel.text = ""
            valueLabel.text = ""
        }
    }
}
