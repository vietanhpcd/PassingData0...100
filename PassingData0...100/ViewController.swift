//
//  ViewController.swift
//  PassingData0...100
//
//  Created by Anhdzai on 12/8/17.
//  Copyright © 2017 Anhdzai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    var dataNumber: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.text = dataNumber
    }
    // Truyền dữ liệu không xác định vị trí nhận 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        dataNumber = textField.text
    }
    // Tạo hành động nút cancel
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        let cancel = presentingViewController is UINavigationController
        // Nếu cancel từ Navigation Controller thì thực hiện hđ1, nếu là Navigation con thì thực hiện hđ2
        if cancel {
            dismiss(animated: true, completion: nil)
        } else if let Navigation = navigationController {
            Navigation.popViewController(animated: true)
        } else {
            fatalError("loi cancel")
        }
    }
}

