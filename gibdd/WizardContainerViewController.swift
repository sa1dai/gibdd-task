//
//  WizardViewController.swift
//  gibdd
//
//  Created by Admin on 18.02.2021.
//

import UIKit

class WizardContainerViewController: UIViewController {

  static let wizardSegue = "wizard"
  static let infoSegue = "info"
  
  var autoNumber: String?
  var driverCarLicense: String?
  
  @IBOutlet weak var button: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.navigationController?.isNavigationBarHidden = true
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if (segue.identifier == WizardContainerViewController.wizardSegue) {
      let wizardVC = segue.destination as! WizardViewController
      wizardVC.showButton = showButton
    } else if (segue.identifier == WizardContainerViewController.infoSegue) {
      let infoVC = segue.destination as! InfoViewController
      infoVC.autoNumber = autoNumber
      infoVC.driverCarLicense = driverCarLicense
    }
  }
  
  func showButton(show: Bool) {
    button.isHidden = !show
  }
}
