//
//  MenuCollectionViewCell.swift
//  MovieBookingApp
//
//  Created by Bhavishya Sharma on 04/04/23.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var labelDuration: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //setData(data: MovieData)
        imageView.layer.cornerRadius = 10
        
    }
    func setData(data : MovieDatum){
        imageView.image = nil
        labelName.text = data.title
        labelDuration.text = data.runtime
        guard let url = URL(string: data.images[2]) else { return }
        let dataTask = URLSession.shared.dataTask(with: url) { [weak self] (data, _, _) in
            if let safeData = data {
                DispatchQueue.main.async {
                    movieImages.append(safeData)
                    self?.imageView.image = UIImage(data: safeData)
                }
            }
        }
        dataTask.resume()
    }
}
