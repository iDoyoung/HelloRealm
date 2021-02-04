//
//  ViewController.swift
//  HelloRealm
//
//  Created by ido on 2021/02/03.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {

    let model = RealmModel()
    var resultDatas: Results<MyData>?
    
    @IBOutlet weak var tableView: UITableView!
    
    var carrers = List<String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultDatas = try! Realm().objects(MyData.self)
        tableView.dataSource = self
    }

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var positionTextField: UITextField!
    @IBOutlet weak var careerTextField: UITextField!
    
    @IBAction func addCareer(_ sender: UIButton) {
        if let textFiled = careerTextField.text, !textFiled.isEmpty {
            let career = textFiled
            carrers.append(career)
        }
    }
    
    
    @IBAction func saveData(_ sender: UIButton) {
        let newData = MyData()
        newData.careers = self.carrers
        newData.jobPosition = positionTextField.text!
        newData.name = nameTextField.text!
        model.create(newData)
        resultDatas = try! Realm().objects(MyData.self)
        tableView.reloadData()
        carrers = List<String>()
    }
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultDatas?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? Cell else {
            return UITableViewCell()
        }
        cell.nameLabel.text = resultDatas?[indexPath.row].name
        cell.positionLabel.text = resultDatas?[indexPath.row].jobPosition
        cell.careerCount.text = String(resultDatas?[indexPath.row].careers.count ?? 0)
        
        return cell
    }
    
    
}

class Cell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var careerCount: UILabel!
    
}
