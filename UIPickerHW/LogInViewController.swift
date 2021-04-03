//
//  ViewController.swift
//  UIPickerHW
//
//  Created by Иван on 3/30/21.
//

import UIKit

class LogInViewController: UIViewController {
    
    
    @IBOutlet weak var userTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    private let user = User.getUserData()
    
    @IBAction func loginPressed() {
        guard userTF.text == user.name && passwordTF.text == user.password
        else {
            showAlert(title: "Wrong name or password", message: "Please enter correct data", style: .alert)
            return
        }
        performSegue(withIdentifier: "loginSegue", sender: nil)
    }
}

extension LogInViewController {
    private func showAlert(title: String , message: String?, style: UIAlertController.Style) {
        let alert = UIAlertController(title: title , message: message, preferredStyle: style)
        let action = UIAlertAction(title: "Ok", style: .cancel) { _ in
            self.userTF.text = ""
            self.passwordTF.text = ""
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
    
}

extension LogInViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userTF {
            textField.resignFirstResponder()
            passwordTF.becomeFirstResponder()
        } else {
            loginPressed()
        }
        return true
    }
}

