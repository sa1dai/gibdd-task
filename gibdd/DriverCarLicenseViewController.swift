//
//  DriverCarLicenseViewController.swift
//  gibdd
//
//  Created by Admin on 18.02.2021.
//

import UIKit

class DriverCarLicenseViewController: UIViewController {

  static let wizardContainerSegue = "wizardContainer"
  
  var autoNumber: String? = nil
  
  @IBOutlet weak var textField: UITextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    selectTextField()
  }
  
  func isCorrectDriverCarLicense(_ driverCarLicense: String) -> Bool {
    let driverCarLicenseLetterFormat = "[A-ZА-Я]"
    let driverCarLicenseFormat = "[0-9]{2}\(driverCarLicenseLetterFormat){2}[0-9]{6}"
    let driverCarLicensePredicate = NSPredicate(format:"SELF MATCHES %@", driverCarLicenseFormat)
    return driverCarLicensePredicate.evaluate(with: driverCarLicense)
  }
  
  @IBAction func driverCarLicenseChanged(_ sender: UITextField) {
    let driverCarLicense = sender.text!
    sender.attributedText = NSAttributedString(string: driverCarLicense, attributes: [NSAttributedString.Key.foregroundColor: isCorrectDriverCarLicense(driverCarLicense) ? UIColor.black : UIColor.red])
  }
  
  func performSegue() {
    self.performSegue(withIdentifier: DriverCarLicenseViewController.wizardContainerSegue, sender: self)
  }
  
  func selectTextField() {
    textField.becomeFirstResponder()
  }
  
  func confirmSkipAutoNumerInput() {
    let alert = UIAlertController(title: "Если вы не введете номер водительского удостоверения, то вы не сможете следить за штрафами, выписанными на водителя", message: "", preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: "Пропустить", style: UIAlertAction.Style.default, handler: { action in self.performSegue()
    }))
    alert.addAction(UIAlertAction(title: "Ввести номер", style: UIAlertAction.Style.cancel, handler: { action in
      self.selectTextField()
    }))
    self.present(alert, animated: true, completion: nil)
  }
  
  @IBAction func barButtonPressed(_ sender: UIBarButtonItem) {
    confirmSkipAutoNumerInput()
  }
  
  func incorrectDriverCarLicenseAlert() {
    let alert = UIAlertController(title: "Введите корректный номер водительского удостоверения", message: "", preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: "ОК", style: UIAlertAction.Style.cancel, handler: { action in
      self.selectTextField()
    }))
    self.present(alert, animated: true, completion: nil)
  }
  
  @IBAction func keyboardDonePressed(_ sender: UITextField) {
    let driverCarLicense = sender.text!
    if (driverCarLicense.isEmpty) {
      confirmSkipAutoNumerInput()
    } else if (!isCorrectDriverCarLicense(driverCarLicense)) {
      incorrectDriverCarLicenseAlert()
    } else {
      performSegue()
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if (segue.identifier == DriverCarLicenseViewController.wizardContainerSegue) {
      let destinationVC = segue.destination as! WizardContainerViewController
      let driverCarLicense = textField.text!
      let defaults = UserDefaults.standard
      if (isCorrectDriverCarLicense(driverCarLicense)) {
        destinationVC.driverCarLicense = driverCarLicense
        defaults.set(driverCarLicense, forKey: DefaultsKeys.driverCarLicense)
      } else {
        destinationVC.driverCarLicense = nil
        defaults.removeObject(forKey: DefaultsKeys.driverCarLicense)
      }
      destinationVC.autoNumber = autoNumber
    }
  }
}
