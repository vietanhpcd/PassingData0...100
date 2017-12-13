//
//  TableViewController.swift
//  PassingData0...100
//
//  Created by Anhdzai on 12/8/17.
//  Copyright © 2017 Anhdzai. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    // Tạo mảng kiểu string


    
    func array (number: Int) -> [String] {
        var a = [String]()
        for b in 0...number {
            a.append("\(b)")
        }
        return a
    }
    
    var arrayString = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Không thể thay đổi giá trị mảng trong func nên cần đổi sang mảng khác
        arrayString = array(number: 1)
        navigationItem.leftBarButtonItem = editButtonItem
        // loat lựa trọn
        clearsSelectionOnViewWillAppear = true
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayString.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "number", for: indexPath)
            cell.textLabel?.text = arrayString[indexPath.row]
        return cell
    }
    // Truyền dữ liệu sang ViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let data = segue.destination as? ViewController,
            let index = tableView.indexPathForSelectedRow {
            data.dataNumber = arrayString[index.row]
        }
    }
    // Tạo unwind nhận dữ liệu từ VỉewController
    @IBAction func unwindFromAdd(_ sender: UIStoryboardSegue) {
        if let data =  sender.source as? ViewController, let Datanumber = data.dataNumber {
            // Nếu dữ liệu dòng truyền về thì thực hiện đk1 không thì thực hiện đk2
            if let index = tableView.indexPathForSelectedRow {
                // Thay đổi dữ liệu trong hàng bằng dữ liệu mới
                arrayString[index.row] = Datanumber
                // reload dữ liệu tại dòng đó
                tableView.reloadRows(at: [index], with: .none)
            } else {
                // Xác định vị trí thêm dòng
                let indexPath = IndexPath(row: arrayString.count, section: 0)
                // Thêm dữ liệu cho mảng
                arrayString.append(Datanumber)
                // Thêm dòng cho tableView
                tableView.insertRows(at: [indexPath], with: .automatic)
            }
        }
    }
    // Xoá ròng
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            arrayString.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    // Hiện thông báo khi xoá hết data
    override func numberOfSections(in tableView: UITableView) -> Int
    {
        if arrayString.count == 0 {
            let noDataLabel: UILabel     = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            noDataLabel.text          = "No data"
            noDataLabel.textColor     = UIColor.black
            noDataLabel.textAlignment = .center
            tableView.backgroundView  = noDataLabel
            tableView.separatorStyle  = .none
        }
        return 1
    }
}
