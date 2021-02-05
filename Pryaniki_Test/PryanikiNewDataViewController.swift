//
//  PryanikiNewDataViewController.swift
//  Pryaniki_Test
//
//  Created by Vitaly Khomatov on 05.02.2021.
//

import UIKit

class PryanikiNewDataViewController: UIViewController {
    
    private var labelName = UILabel()
    private var hzText = UITextView()
    private var pictureImage = UIImageView()
    private var pictureText = UILabel()
    private var selectorTable = UITableView()

    private var minY: CGFloat = 30.0
    private let minX:  CGFloat = 20
    private let height: CGFloat = 30
    private let width: CGFloat = 40
    private let indent: CGFloat = 6
    
    var element : Datum?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let element = self.element {
          createView(element: element)
        }
        
    }
    
    private func createView(element: Datum) {
        
        switch element.name {
            case "hz":
                createName()
                createText()
            case "selector":
                createName()
                createSelector()
            case "picture":
                createName()
                createPicture()
                if let element = self.element, let url = element.data.url {
                    DispatchQueue.main.async { self.pictureImage.kf.setImage(with: URL(string: url)) }
                }
            default:
                break
            }
    }

    private func createName() {
        self.labelName = UILabel(frame: CGRect(x: minX, y: minY, width: view.frame.width - width, height: height))
        self.labelName.backgroundColor = .systemYellow
        self.labelName.clipsToBounds = true
        self.labelName.layer.cornerRadius =  self.labelName.frame.height / indent
        if let element = self.element { self.labelName.text = " " + element.name }
        view.addSubview(labelName)
    }

    private func createText() {
        self.hzText = UITextView(frame: CGRect(x: minX, y: labelName.frame.maxY + indent, width: view.frame.width - width, height: height))
        self.hzText.backgroundColor = .systemYellow
        self.hzText.layer.cornerRadius =  self.hzText.frame.height / indent
        if let element = self.element, let text = element.data.text { self.hzText.text = " " + text }
        view.addSubview(hzText)
    }
        
    private func createPicture() {
        
        self.pictureImage = UIImageView(frame: CGRect(x: minX, y: labelName.frame.maxY + indent, width: view.frame.width - width, height: height * 7))
        self.pictureImage.backgroundColor = .systemGreen
        self.pictureImage.layer.cornerRadius =  self.pictureImage.frame.height / (indent * 3)
        self.pictureImage.contentMode = .scaleAspectFit
        
        self.pictureText = UILabel(frame: CGRect(x: minX, y: labelName.frame.maxY + indent, width: (view.frame.width - width) / 4, height: height))
        self.pictureText.backgroundColor = .systemOrange
        self.pictureText.clipsToBounds = true
        self.pictureText.layer.cornerRadius =  self.pictureText.frame.height / indent
        self.pictureText.textAlignment = .center
        
        if let element = self.element, let text = element.data.text {
            self.labelName.text = " " + element.name
            self.pictureText.text = " " + text
        }
        
        view.addSubview(pictureImage)
        view.addSubview(pictureText)
    }

    
    private func createSelector() {
        self.selectorTable = UITableView(frame: CGRect(x: minX, y: labelName.frame.maxY + indent, width: view.frame.width - width, height: height * 10))
       // self.selectorTable.delegate = self
        self.selectorTable.dataSource = self
        self.selectorTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.selectorTable.separatorStyle = .singleLine

        view.addSubview(selectorTable)
    }

}


//extension PryanikiNewDataViewController : UITableViewDelegate {

//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//    }
    
//}

extension PryanikiNewDataViewController : UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let element = self.element, let variants = element.data.variants {
            return variants.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if let element = self.element, let variants = element.data.variants, let selectedId = element.data.selectedID {
            
            if variants.count > indexPath.row {
                cell.textLabel?.text = variants[indexPath.row].text
                if variants[indexPath.row].id == selectedId {
                    self.selectorTable.selectRow(at: indexPath, animated: false, scrollPosition: .none)
                }
            }
        }
        return cell
    }
}
    
