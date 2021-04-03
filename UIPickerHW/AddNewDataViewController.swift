//
//  AddNewDataViewController.swift
//  UIPickerHW
//
//  Created by Иван on 3/31/21.
//

import UIKit

class AddNewDataViewController: UIViewController {
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var birthdayTF: UITextField!
    @IBOutlet weak var ageTF: UITextField!
    @IBOutlet weak var genderTF: UITextField!
    @IBOutlet weak var instagramTF: UITextField!
    
    var data = [String]()
    
    weak var delegate: BirthdayViewControllerDelegate?
    
    var birthdayPicker = UIDatePicker()
    var agePicker = UIPickerView()
    var genderPicker = UIPickerView()
    
    let gender = ["Мужской", "Женский"]
    
    var alertWillShow = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = false
        
        birthdayPicker = customDatePicker(datePicker: birthdayPicker, textField: birthdayTF)
        agePicker = customPickerView(picker: agePicker, textField: ageTF)
        genderPicker = customPickerView(picker: genderPicker, textField: genderTF)
        
        agePicker.tag = 0
        genderPicker.tag = 1
        
        birthdayTF.inputView = birthdayPicker
        ageTF.inputView = agePicker
        genderTF.inputView = genderPicker

        agePicker.delegate = self
        agePicker.dataSource = self
        genderPicker.delegate = self
        genderPicker.dataSource = self
        instagramTF.delegate = self
    }
    @IBAction func saveData(_ sender: Any) {
        data.append(nameTF.text ?? "")
        data.append(birthdayTF.text ?? "")
        data.append(ageTF.text ?? "")
        data.append(genderTF.text ?? "")
        data.append(instagramTF.text ?? "")
        delegate?.update(data: data)
        dismiss(animated: true, completion: nil)
    }
    
    
    @objc func doneDatePickerAction() {
        let timeFormatter = DateFormatter()
        //Устанавливаем формат отображения даты
        timeFormatter.dateStyle = .long
        timeFormatter.timeStyle = .none
        timeFormatter.locale = .init(identifier: "Russian")
        birthdayTF.text = timeFormatter.string(from: birthdayPicker.date)
        //Убрать пикер по кнопке done
        view.endEditing(true)
    }
    
    @objc func donePickerAction() {
        
        //Убрать пикер по кнопке done
        view.endEditing(true)
    }
    
    @IBAction func instagramTFAction(_ sender: UITextField) {
        textFieldShouldBeginEditing(textfield: sender)
    }
    
    
    
}

extension AddNewDataViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 0: return 100
        case 1: return 2
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 0: return String(row)
        case 1: return gender[row]
        default:
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 0: ageTF.text = String(row)
        case 1: genderTF.text = gender[row]
        default:
            break
        }
    }
    
    
    func customDatePicker(datePicker: UIDatePicker, textField: UITextField) -> UIDatePicker {
        //Локализация DatePicker
        datePicker.locale = .init(identifier: "Russian")
        //Создаем ToolBar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        //Добавляем кнопку Done к ToolBar
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneDatePickerAction))
        toolbar.setItems([doneButton], animated: true)
        //Добавляем ToolBar к TextField
        textField.inputAccessoryView = toolbar
        //Добавляем DatePicker к TextField
        textField.inputView = datePicker
        //Вид для DatePicker
        datePicker.datePickerMode = .date
        //Вид колеса для DatePicker
        datePicker.preferredDatePickerStyle = .wheels
        
        return datePicker
    }
    
    func customPickerView(picker: UIPickerView, textField: UITextField) -> UIPickerView {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePickerAction))
        toolbar.setItems([doneButton], animated: true)
        textField.inputAccessoryView = toolbar
        textField.inputView = picker
        return picker
    }
}

extension AddNewDataViewController {
    func insagramAlert(for textfield: UITextField) {
        let alert = UIAlertController(title: "Enter your Instagram profile", message: "", preferredStyle: .alert)
        alert.addTextField()
        let action = UIAlertAction(title: "Ok", style: .default) { _ in
            textfield.text = alert.textFields?.first?.text
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
}

extension AddNewDataViewController: UITextFieldDelegate {
    
    private func textFieldShouldBeginEditing(textfield: UITextField) {
        if alertWillShow {
            alertWillShow = false
            insagramAlert(for: textfield)
        }
    }
}
