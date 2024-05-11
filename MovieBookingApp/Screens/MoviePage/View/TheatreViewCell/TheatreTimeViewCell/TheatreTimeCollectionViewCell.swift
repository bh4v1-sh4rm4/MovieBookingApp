//
//  TheatreTimeCollectionViewCell.swift
//  MovieBookingApp
//
//  Created by Bhavishya Sharma on 10/04/23.
//

import UIKit

class TheatreTimeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var timeView: UIView!
    @IBOutlet weak var lblTime: UILabel!
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.layer.borderColor = UIColor.blue.cgColor
            } else {
                self.layer.borderColor = UIColor.gray.cgColor
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        formatView(view: timeView)
    }
    func formatView(view: UIView){
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.cornerRadius = 15
        view.layer.borderWidth = 1
        
    }
    
//    func selectedCell() {
//        view.layer.borderColor = UIColor.black.cgColor
//        view.layer.cornerRadius = 15
//        view.layer.borderWidth = 1
//    }
}
