//
//  TheatreCollectionViewCell.swift
//  MovieBookingApp
//
//  Created by Bhavishya Sharma on 10/04/23.
//

import UIKit

class TheatreCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lblTheatreName: UILabel!
    @IBOutlet weak var theatreTimeCollectionView: UICollectionView!
    let dateFormatter = DateFormatter()
    let dateFormat = "hh:mm a"
    var hallIndex: Int!
    var selectedTime: Int!
    
    var delegateChangeSelectedSeat: IChangeSelectedSeat!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        theatreTimeCollectionView.register(UINib(nibName: "TheatreTimeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TheatreTime")
        theatreTimeCollectionView.delegate = self
        theatreTimeCollectionView.dataSource = self
    }

}
extension TheatreCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/3.5, height: collectionView.frame.height/1.2)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieTimings.count
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TheatreTime", for: indexPath) as? TheatreTimeCollectionViewCell else {return TheatreTimeCollectionViewCell()}
       //collectionCell.lblTime.text = movieTimings[indexPath.row]
        dateFormatter.dateFormat = dateFormat
        collectionCell.lblTime.text = dateFormatter.string(from: movieTimings[indexPath.row])
        if let time = selectedTime {
            if(time == indexPath.row) {
                collectionCell.timeView.layer.borderColor = UIColor.blue.cgColor
            }
        }
        return collectionCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? TheatreTimeCollectionViewCell else { return }
        delegateChangeSelectedSeat.updateSeat(newSelectedHall: hallIndex!, newSelectedTime: indexPath.row)
        cell.timeView.layer.borderColor = UIColor.blue.cgColor
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        delegateChangeSelectedSeat.saveContentOffset(hallIndex: hallIndex, offset: scrollView.contentOffset)
    }
    
    
}
