//
//  PryanikiViewController.swift
//  Pryaniki_Test
//
//  Created by Vitaly Khomatov on 03.02.2021.
//

import Kingfisher
import UIKit

class PryanikiViewController: UIViewController {
    
    
    private let model = PryanikiViewModel()
    
    private var hzName = UILabel()
    private var hzText = UITextView()
    private var pictureName = UILabel()
    private var pictureImage = UIImageView()
    private var pictureText = UILabel()
    private var selectorName = UILabel()
    private var selectorTable = UITableView()
    private var scrollView = UIScrollView()

    private var previousViewY : CGFloat = 50.0
    private let minX :  CGFloat = 20
    private let height : CGFloat = 30
    private let width : CGFloat = 40
    private let indent : CGFloat = 6
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        previousViewY = model.getDeviceModel()
        
        createScrollView()
        self.view = scrollView
        
        model.loadSwiftyJSONData {
            self.setViewInOrder()
            DispatchQueue.main.async {
                self.pictureImage.kf.setImage(with: URL(string: self.model.picture.url))
            }
        }
    }
    
    private func setViewInOrder() {
        
        for element in model.order.order {
            switch element {
            case "hz":
                createHzView()
            case "selector":
                createSelectorView()
            case "picture":
                createPictureView()
            default:
                break
            }
        }
        
    }
    
    
    private func setGestureRecognizer(label: UILabel) {
        let tap: UITapGestureRecognizer
        tap = UITapGestureRecognizer(target: self, action: #selector(self.showObjectInfo(sender:)))
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(tap)
    }

    
    @objc private func showObjectInfo(sender: UIGestureRecognizer) {
        let alert = UIAlertController(title: "Информация об объекте", message: String(describing: sender.view.self!), preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }

    
    private func createScrollView() {
        self.scrollView = UIScrollView(frame: self.view.bounds)
        self.scrollView.showsVerticalScrollIndicator = false
        self.scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentSize = CGSize(width: 0, height: 700)

    }
    
    private func createHzView() {
        
        self.hzName = UILabel(frame: CGRect(x: minX, y: previousViewY, width: view.frame.width - width, height: height))
        self.hzName.backgroundColor = .systemYellow
        self.hzName.clipsToBounds = true
        self.hzName.layer.cornerRadius =  self.hzName.frame.height / indent
        self.hzName.text = " " + model.hz.name
        scrollView.addSubview(hzName)
        
        self.hzText = UITextView(frame: CGRect(x: minX, y: hzName.frame.maxY + indent, width: view.frame.width - width, height: height))
        self.hzText.backgroundColor = .systemYellow
        self.hzText.layer.cornerRadius =  self.hzText.frame.height / indent
        self.hzText.text = " " + model.hz.text
        scrollView.addSubview(hzText)
        
        previousViewY = self.hzText.frame.maxY + minX
        self.setGestureRecognizer(label: self.hzName)

    }
        
    private func createPictureView() {
        
        self.pictureName = UILabel(frame: CGRect(x: minX, y: previousViewY, width: view.frame.width - width, height: height))
        self.pictureName.backgroundColor = .systemGreen
        self.pictureName.clipsToBounds = true
        self.pictureName.layer.cornerRadius =  self.pictureName.frame.height / indent
        self.pictureName.text = " " + model.picture.name
        scrollView.addSubview(pictureName)
        
        self.pictureImage = UIImageView(frame: CGRect(x: minX, y: pictureName.frame.maxY + indent, width: view.frame.width - width, height: height * 7))
        self.pictureImage.backgroundColor = .systemGreen
        self.pictureImage.layer.cornerRadius =  self.pictureImage.frame.height / (indent * 3)
        self.pictureImage.contentMode = .scaleAspectFit
        scrollView.addSubview(pictureImage)
        
        self.pictureText = UILabel(frame: CGRect(x: minX, y: pictureName.frame.maxY + indent, width: (view.frame.width - width) / 4, height: height))
        self.pictureText.backgroundColor = .systemOrange
        self.pictureText.clipsToBounds = true
        self.pictureText.layer.cornerRadius =  self.pictureText.frame.height / indent
        self.pictureText.text = " " + model.picture.text
        self.pictureText.textAlignment = .center
        scrollView.addSubview(pictureText)
        
        previousViewY = self.pictureImage.frame.maxY + minX
        self.setGestureRecognizer(label: self.pictureName)

    }
        
        
    private func createSelectorView() {

        self.selectorName = UILabel(frame: CGRect(x: minX, y: previousViewY, width: view.frame.width - width, height: height))
        self.selectorName.backgroundColor = .systemBlue
        self.selectorName.clipsToBounds = true
        self.selectorName.layer.cornerRadius =  self.selectorName.frame.height / indent
        self.selectorName.text = " " + model.selector.name
        scrollView.addSubview(selectorName)
        
        self.selectorTable = UITableView(frame: CGRect(x: minX, y: selectorName.frame.maxY + indent, width: view.frame.width - width, height: height * 4.5))
      //  self.selectorTable.delegate = self
        self.selectorTable.dataSource = self
        self.selectorTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.selectorTable.separatorStyle = .singleLine
        scrollView.addSubview(selectorTable)
        
        previousViewY = self.selectorTable.frame.maxY + minX

        self.setGestureRecognizer(label: self.selectorName)
        
    }

}


//extension PryanikiViewController : UITableViewDelegate {
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        self.showObjectInfo(sender: UITapGestureRecognizer())
//    }
//}

extension PryanikiViewController : UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.selector.variants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        if model.selector.variants.count > indexPath.row {
            cell.textLabel?.text = model.selector.variants[indexPath.row].text
            if model.selector.variants[indexPath.row].id == model.selector.selectedId {
                self.selectorTable.selectRow(at: indexPath, animated: false, scrollPosition: .none)
            }
        }
        return cell
    }
    
}
