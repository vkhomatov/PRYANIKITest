//
//  PryanikiNewViewController.swift
//  Pryaniki_Test
//
//  Created by Vitaly Khomatov on 04.02.2021.
//

import UIKit

class PryanikiNewViewController: UIViewController {
    
    private let model = PryanikiNewViewModel()
    private var tableView = UITableView()
    private var loadingLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        createLoadingLabel()
        
        model.loadCodableData { [self] in
            model.pryanikiAdapter(pryaniki: model.pryaniki)
            self.loadingLabel.isHidden = true
            self.createTable()
        }
        
    }
    
    private func createTable() {
        self.tableView = UITableView(frame: view.bounds, style: .plain)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.tableView.separatorStyle = .singleLine
        view.addSubview(tableView)
    }
    
    private func createLoadingLabel() {
        self.loadingLabel = UILabel(frame: CGRect(x: view.frame.minX + 20.0, y: view.frame.minY + 50.0, width: view.frame.width - 40, height: 30))
        self.loadingLabel.clipsToBounds = true
        self.loadingLabel.layer.cornerRadius =  self.loadingLabel.frame.height / 6
        self.loadingLabel.text = "Загрузка данных ..."
        self.loadingLabel.textAlignment = .center
        self.loadingLabel.backgroundColor = .systemYellow
        view.addSubview(loadingLabel)
    }

}

extension PryanikiNewViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let object = model.newPryaniki[indexPath.row]
        let pryanikiNewDataViewController = PryanikiNewDataViewController()
        pryanikiNewDataViewController.element = object
        pryanikiNewDataViewController.view.backgroundColor = .systemGray2
        present(pryanikiNewDataViewController, animated: true, completion: nil)
    }
    
}

extension PryanikiNewViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.newPryaniki.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.selectionStyle = .none
        cell.accessoryType = .disclosureIndicator
        if model.newPryaniki.count > indexPath.row {
            cell.textLabel?.text = model.newPryaniki[indexPath.row].name
        }
        return cell
    }
    
    
}
