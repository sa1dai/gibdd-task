//
//  InfoViewController.swift
//  gibdd
//
//  Created by Admin on 18.02.2021.
//

import UIKit

class InfoViewController: UIViewController {

  var autoNumber: String?
  var driverCarLicense: String?
  
  @IBOutlet weak var driverCarLicenseLabel: UILabel!
  @IBOutlet weak var autoNumberLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let autoNumber = autoNumber {
      autoNumberLabel.text = autoNumber
    }
    
    if let driverCarLicense = driverCarLicense {
      driverCarLicenseLabel.text = driverCarLicense
    }
  }
  
}
