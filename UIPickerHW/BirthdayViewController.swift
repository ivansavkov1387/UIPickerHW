//
//  BirthdayViewController.swift
//  UIPickerHW
//
//  Created by Иван on 3/31/21.
//

import UIKit

protocol BirthdayViewControllerDelegate: class {
    func update(data: [String])
}

class BirthdayViewController: UIViewController, BirthdayViewControllerDelegate {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    
    
    func update(data: [String]) {
        nameLabel.text = data[0]
        birthdayLabel.text = data[1]
    }
    
    var data = [String]()
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "addNewDataSegue" else { return }
        guard let destination = segue.destination as? AddNewDataViewController else { return }
        destination.delegate = self
    }
    
}


