//
//  MPCalenderCollectionViewCell.swift
//  MovieBookingApp
//
//  Created by Bhavishya Sharma on 10/04/23.
//

import UIKit

class MPCalenderCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var subview: UIView!
    @IBOutlet weak var lblDay: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        formatView(view: subview)
        // Initialization code
    }
    
    func formatView(view: UIView){
       // view.layer.borderColor = CGColor(gray: 1/1.5, alpha: 1)
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
    }
    

}
extension MPCalenderCollectionViewCell : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}
