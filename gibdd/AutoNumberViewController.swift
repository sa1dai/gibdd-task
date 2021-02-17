//
//  AutoNumberViewController.swift
//  gibdd
//
//  Created by Admin on 17.02.2021.
//

import UIKit

class AutoNumberViewController: UIViewController {
  
  static let driverCarLicenseSegue = "driverCarLicense"
  
  @IBOutlet weak var textField: UITextField!
  
  func isCorrectAutoNumber(_ autoNumber: String) -> Bool {
    let autoNumberRussianLetters = "АВЕКМНОРСТУХ"
    let autoNumberEnglishLetters = "ABEKMHOPCTYX"
    let autoNumberLetterFormat = "[\(autoNumberRussianLetters)\(autoNumberEnglishLetters)]"
    let autoNumberFormat = "\(autoNumberLetterFormat)[0-9]{3}\(autoNumberLetterFormat){2}[0-9]{2}"
    let autoNumberPredicate = NSPredicate(format:"SELF MATCHES %@", autoNumberFormat)
    return autoNumberPredicate.evaluate(with: autoNumber)
  }
  
  @IBAction func autoNumberChanged(_ sender: UITextField) {
    let autoNumber = sender.text!
    sender.attributedText = NSAttributedString(string: autoNumber, attributes: [NSAttributedString.Key.foregroundColor: isCorrectAutoNumber(autoNumber) ? UIColor.black : UIColor.red])
  }
  
  func performSegue() {
    self.performSegue(withIdentifier: AutoNumberViewController.driverCarLicenseSegue, sender: self)
  }
  
  func selectTextField() {
    textField.becomeFirstResponder()
  }
  
  func confirmSkipAutoNumerInput() {
    let alert = UIAlertController(title: "Если вы не введете регистрационный номер ТС, то вы не сможете следить за штрафами, выписанными за автомобиль", message: "", preferredStyle: UIAlertController.Style.alert)
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
  
  func incorrectAutoNumberAlert() {
    let alert = UIAlertController(title: "Введите корректный регистрационный номер ТС", message: "", preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: "ОК", style: UIAlertAction.Style.cancel, handler: { action in
      self.selectTextField()
    }))
    self.present(alert, animated: true, completion: nil)
  }
  
  @IBAction func keyboardDonePressed(_ sender: UITextField) {
    let autoNumber = sender.text!
    if (autoNumber.isEmpty) {
      confirmSkipAutoNumerInput()
    } else if (!isCorrectAutoNumber(autoNumber)) {
      incorrectAutoNumberAlert()
    } else {
      performSegue()
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if (segue.identifier == AutoNumberViewController.driverCarLicenseSegue) {
      let destinationVC = segue.destination as! DriverCarLicenseViewController
      let autoNumber = textField.text!
      let defaults = UserDefaults.standard
      if isCorrectAutoNumber(autoNumber) {
        destinationVC.autoNumber = autoNumber
        defaults.set(autoNumber, forKey: DefaultsKeys.autoNumber)
      } else {
        destinationVC.autoNumber = nil
        defaults.removeObject(forKey: DefaultsKeys.autoNumber)
      }
    }
  }
  
}
