//
//  ViewController.swift
//  Favorite_Pages
//
//  Created by Pankaj Sharma on 3/20/18.
//  Copyright © 2018 Pankaj Sharma. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, BookMarkProtocol, CellDelegate {
 
    let cellID = "cellID"
    var dataArray = [DataModel]()
    let defaults = UserDefaults.standard
    var newArray = [DataModel]()
    override func viewDidLoad() {
        
        super.viewDidLoad()
  
        if let savedArray = defaults.value(forKey: "myPersonalKey") as? Data,
            let decodedArray = try? PropertyListDecoder().decode([DataModel].self, from: savedArray) {
           
            dataArray = decodedArray
        }
        
        
        collectionView?.backgroundColor = UIColor(red: 200/255, green: 200/255, blue: 200/255, alpha: 1)
        navigationItem.title = "Favorite Pages"
        navigationController?.navigationBar.tintColor = UIColor.black
       
        navigationController?.navigationBar.barTintColor = UIColor(red: 135/255, green: 206/255, blue: 250/255, alpha: 1)
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black, NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 25)]
      
        collectionView?.register(MyCell.self, forCellWithReuseIdentifier: cellID)
        navigationItem.leftBarButtonItem = editButtonItem
        navigationBarSetUp()
    }
    
    
   @objc func editTapped() {
     navigationItem.rightBarButtonItem?.isEnabled = true
    if navigationItem.leftBarButtonItem?.title == "Edit" {
        navigationItem.leftBarButtonItem?.title = "Done"
        navigationItem.rightBarButtonItem?.isEnabled = false
        if let indexPath = collectionView?.indexPathsForVisibleItems {
            for indexpath in indexPath {
                if let cell = collectionView?.cellForItem(at: indexpath) as? MyCell {
                    cell.isEditing = true
                }
            }
        }

    } else {
        navigationItem.leftBarButtonItem?.title = "Edit"
        navigationItem.rightBarButtonItem?.isEnabled = true
        if let indexPath = collectionView?.indexPathsForVisibleItems {
            for indexpath in indexPath {
                if let cell = collectionView?.cellForItem(at: indexpath) as? MyCell {
                    cell.isEditing = false
                }
            }
        }
    }
}

    func navigationBarSetUp() {
        navigationItem.rightBarButtonItem =
            UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButton))

    }

    let webViewVC = WebViewController()
    
    
    @objc func addButton()  {
     
        let navController = UINavigationController(rootViewController: webViewVC)
        webViewVC.myDelegate = self
        let url = URL(string: "https://www.google.com")
        webViewVC.webView.loadRequest(URLRequest(url: url!))
        webViewVC.showWebView()
        
        present(navController, animated: true, completion: nil)
        
    }
    
    var searchedURL: String?
    
    func saveWebLink(title: String, url: String, image: String) {
        
        let data = DataModel(title: title, url: url, iconImage: image)
       dataArray.append(data)
        encode()
        
        
    }
    func encode() {
        let encodedArray = try? PropertyListEncoder().encode(dataArray)
        defaults.set(encodedArray, forKey: "myPersonalKey")
        defaults.synchronize()
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
        }
    }
  
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       // saveData()
        return dataArray.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! MyCell
        let image = UIImage(named: dataArray[indexPath.item].iconImage)
            cell.imageIcon.image = image
            cell.titleLabel.text = dataArray[indexPath.row].title
            cell.editImageBtn.isHidden = true
            cell.delegate = self
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (view.frame.width / 4) - 20, height: 100)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
    
    
       override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if !isEditing {
            
            let tappedCell = dataArray[indexPath.row]
            // print(tappedCell.url)
            let navController = UINavigationController(rootViewController: webViewVC)
            webViewVC.myDelegate = self
            present(navController, animated: true, completion: nil)
            
            self.webViewVC.myURLString = tappedCell.url
            self.webViewVC.loadWebPage()
            print(self.webViewVC.myURLString)
        }
        
     
        }
    
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        navigationItem.rightBarButtonItem?.isEnabled = !editing
        
        if let indexPaths = collectionView?.indexPathsForVisibleItems {
            for indexPath in indexPaths {
                if let cell = collectionView?.cellForItem(at: indexPath) as? MyCell {
                    cell.isEditing = editing
                     
                }
            }
        }
    }
    
    func deleteCell(cell: MyCell) {
        
        let alertcontroller = UIAlertController(title: "Delete Cell", message: "Are you sure you want to delete cell?", preferredStyle: .alert)
        alertcontroller.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (showAlert) in
            if let indexPath = self.collectionView?.indexPath(for: cell) {
                print(123)
                
                self.dataArray.remove(at: indexPath.item)
                self.collectionView?.deleteItems(at: [indexPath])
                self.encode()
               // self.collectionView?.reloadData()
            }

        }))
        alertcontroller.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        present(alertcontroller, animated: true, completion: nil)
        
        }
    
    

    
            }
    



extension String {
    func contains(find: String) -> Bool {
        return (self.range(of: find, options: .caseInsensitive) != nil)
    }
}
    






