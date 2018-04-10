//
//  MyCell.swift
//  Favorite_Pages
//
//  Created by Pankaj Sharma on 3/27/18.
//  Copyright © 2018 Pankaj Sharma. All rights reserved.
//

import UIKit

protocol CellDelegate : class {
    func deleteCell(cell: MyCell)
}

class MyCell : UICollectionViewCell {
    
    weak var delegate: CellDelegate?
    
    let imageIcon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "moon")
        icon.layer.cornerRadius = 5
        icon.layer.masksToBounds = true
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.contentMode = .scaleAspectFill
        return icon
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = UIColor.black
        
        label.font = label.font.withSize(15)
        label.textAlignment = NSTextAlignment.center
        label.numberOfLines = 0
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    var editImageBtn: UIButton = {
    var cellButton = UIButton()
        cellButton.setImage(#imageLiteral(resourceName: "Close-Red"), for: .normal)
        cellButton.contentMode = .scaleAspectFit
        cellButton.translatesAutoresizingMaskIntoConstraints = false
        cellButton.addTarget(self, action: #selector(cellButtonTapped), for: .touchUpInside)
        return cellButton
    }()
    @objc func cellButtonTapped() {
        delegate?.deleteCell(cell: self)
    }
    
    var isEditing: Bool = false {
        didSet {
            editImageBtn.isHidden = !isEditing
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
        
    }
    func setUp() {
        self.backgroundColor = UIColor.clear
       
        self.addSubview(imageIcon)
        self.addSubview(titleLabel)
        self.imageIcon.addSubview(editImageBtn)
        
        
        // constrains for edit image
        
        editImageBtn.topAnchor.constraint(equalTo: imageIcon.topAnchor).isActive = true
        editImageBtn.bottomAnchor.constraint(equalTo: imageIcon.bottomAnchor).isActive = true
        editImageBtn.leftAnchor.constraint(equalTo: imageIcon.leftAnchor).isActive = true
        editImageBtn.rightAnchor.constraint(equalTo: imageIcon.rightAnchor).isActive = true
        editImageBtn.isHidden = !isEditing
        
        
        // Set up Edit button
        
        
        // image icon
        
        imageIcon.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        imageIcon.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        imageIcon.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imageIcon.heightAnchor.constraint(equalToConstant: 60).isActive = true
       
        //Label Contrains
        titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 10).isActive = true
        titleLabel.topAnchor.constraint(equalTo: self.imageIcon.bottomAnchor, constant: 5).isActive = true
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
