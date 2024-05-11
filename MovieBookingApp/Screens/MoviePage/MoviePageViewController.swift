//
//  MoviePageViewController.swift
//  MovieBookingApp
//
//  Created by Bhavishya Sharma on 10/04/23.
//

import UIKit

class MoviePageViewController: UIViewController {

    @IBOutlet weak var theatreCollectionView: UICollectionView!
    @IBOutlet weak var moviePageCalender: UICollectionView!
    @IBOutlet weak var lblMovieGenre: UILabel!
    @IBOutlet weak var lblRuntime: UILabel!
    @IBOutlet weak var lblMovieName: UILabel!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var genreView: UIView!
    var movieIndex: Int!
    var cellIndex: Int!
    var selectedDate = 0
    var selectedHall = 0
    var selectedTime = 0
    let dateFormatter = DateFormatter()
    var cvOffset: [CGPoint] = Array(repeating: CGPoint(), count: theatreName.count)
    @IBAction func btnNextTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "SeatBookingViewController")
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpDetails(movieIndex: movieIndex)
        regsiterCollectionCell(collectionView: moviePageCalender, cell: "MPCalenderCollectionViewCell", cellID: "MPCalenderCell")
        regsiterCollectionCell(collectionView: theatreCollectionView, cell: "TheatreCollectionViewCell", cellID: "TheatreCell")
        moviePageCalender.delegate = self
        moviePageCalender.dataSource = self
        theatreCollectionView.delegate = self
        theatreCollectionView.dataSource = self
        formatPoster(imageView: posterImageView)
        formatView(view: descriptionView)
        formatView(view: genreView)
        moviePageCalender.showsHorizontalScrollIndicator = false
        btnNext.layer.cornerRadius = 25
        // Do any additional setup after loading the view.
    }
    func setUpDetails(movieIndex: Int){
        posterImageView.image = UIImage(data: movieImages[movieIndex])
        lblMovieName.text = movies[movieIndex].title
        lblRuntime.text = movies[movieIndex].runtime
        lblDescription.text = movies[movieIndex].plot
        lblMovieGenre.text = movies[movieIndex].genre
    }
    func regsiterCollectionCell(collectionView : UICollectionView, cell: String, cellID: String ){
        collectionView.register(UINib(nibName: cell, bundle: nil), forCellWithReuseIdentifier: cellID)
    }
    func formatPoster( imageView : UIImageView){
        imageView.layer.cornerRadius = 25
        
    }
    func formatView( view : UIView){
        if view == descriptionView{
            view.layer.cornerRadius = 10
        }
        else{
            view.layer.cornerRadius = 8
        }
        view.layer.shadowRadius = 10
        if view == genreView{
            view.layer.shadowOpacity = 0
        }
        else{
            view.layer.shadowOpacity = 0.2
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    

}
extension MoviePageViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == moviePageCalender {
            return upcomingMovieDates.count
        }
        else
        {
            return theatreName.count
        }
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == moviePageCalender {
            return 1
        }
        else
        {
            return 1
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == moviePageCalender {
            guard let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MPCalenderCell", for: indexPath) as? MPCalenderCollectionViewCell else {return MPCalenderCollectionViewCell()}
            let date = upcomingMovieDates[indexPath.row]
            var dateFormat = "dd"
            dateFormatter.dateFormat = dateFormat
            collectionCell.lblDate.text = dateFormatter.string(from: date!)
            dateFormat = "EEE"
            dateFormatter.dateFormat = dateFormat
            collectionCell.lblDay.text = dateFormatter.string(from: date!)
            if(indexPath.row != selectedDate)
            {
                collectionCell.subview.layer.borderColor = UIColor.lightGray.cgColor
                collectionCell.lblDay.textColor = .lightGray
                collectionCell.lblDate.textColor = .lightGray
            }
            else
            {
                collectionCell.subview.layer.borderColor = UIColor.blue.cgColor
                collectionCell.lblDay.textColor = .black
                collectionCell.lblDate.textColor = .black
            }
            return collectionCell
        }
        else
        {
            guard let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TheatreCell", for: indexPath) as? TheatreCollectionViewCell else {return TheatreCollectionViewCell()}
            
            collectionCell.hallIndex = indexPath.row
            collectionCell.lblTheatreName.text = theatreName[indexPath.row]
            collectionCell.theatreTimeCollectionView.setContentOffset(cvOffset[indexPath.row], animated: false)
            
            if(indexPath.row == selectedHall)
            {
                collectionCell.selectedTime = selectedTime
            }
            else
            {
                collectionCell.selectedTime = nil
            }
            
            collectionCell.theatreTimeCollectionView.reloadData()
            return collectionCell
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.allowsMultipleSelection = false
        if collectionView == moviePageCalender{
            guard let cell = moviePageCalender.cellForItem(at: indexPath) as? MPCalenderCollectionViewCell else { return }
            cell.subview.layer.borderColor = UIColor.blue.cgColor
            cell.lblDay.textColor = .black
            cell.lblDate.textColor = .black
            guard let cell2 = moviePageCalender.cellForItem(at: IndexPath(row: selectedDate, section: 0)) as? MPCalenderCollectionViewCell else { selectedDate = indexPath.row
                return }
            cell2.subview.layer.borderColor = UIColor.lightGray.cgColor
            cell2.lblDay.textColor = .lightGray
            cell2.lblDate.textColor = .lightGray
            
            selectedDate = indexPath.row
        }
    }
}
