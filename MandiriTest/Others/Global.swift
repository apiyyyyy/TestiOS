//
//  Global.swift
//  MandiriTest
//
//  Created by Afi Permana on 21/02/22.
//

import Foundation
import UIKit

func showAlertDismiss(title: String, message: String, view: UIViewController) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
    view.present(alert, animated: true)
}

func getCurrentDate() -> String {
    let date = Date()
    let formatter = DateFormatter()
    
    formatter.locale = Locale(identifier: "id_ID")
    formatter.dateFormat = "d MMMM yyyy"
    
    return formatter.string(from: date)
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
