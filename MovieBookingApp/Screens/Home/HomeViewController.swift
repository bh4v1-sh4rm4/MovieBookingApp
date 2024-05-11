//
//  HomeViewController.swift
//  MovieBookingApp
//
//  Created by Bhavishya Sharma on 04/04/23.
//

import UIKit

var currentPage = 1
var totalPages = 1
class HomeViewController: UIViewController{
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var lblViewAll: UILabel!
    @IBOutlet weak var homeCollectionView: UICollectionView!
    var carouselScrollOffset: CGFloat = 0.0
    var homeViewModel = HomeViewModel()
    @IBAction func btnProfileTouchUp(_ sender: Any) {
        let alert = UIAlertController(title: "Warning!", message: "Do you want to Logout?", preferredStyle: .alert)
        let action1 = UIAlertAction(title: "Logout", style: .default, handler: {(_) in
            //print("Released pressed")
            (UIApplication.shared.delegate as? AppDelegate)?.setUpRootVC()
            UserDefaults.standard.set(false, forKey: "isUserLoggedIn")
        })
        let action2 = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(action1)
        alert.addAction(action2)
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        cardsCollectionView.isPagingEnabled = true
        homeCollectionView.register(UINib(nibName: "MenuCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MenuCell")
        homeCollectionView.delegate = self
        homeCollectionView.dataSource = self
        homeViewModel.apiCall()
        homeViewModel.homeVMCallback = {
            DispatchQueue.main.async {
                self.homeCollectionView.reloadData()
            }
        }
        addTapGestureLbl(lblViewAll, #selector(self.tappedViewAll))
    }
    
    func presentViewController(_ string:  String)
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: string)
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    @objc func tappedViewAll(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            presentViewController("MenuViewController")
        }
    }
    func addTapGestureLbl(_ button : UILabel, _ action: Selector){
        let tapGR = UITapGestureRecognizer(target: self, action: action)
        button.addGestureRecognizer(tapGR)
        button.isUserInteractionEnabled = true
    }
    func profileActionSheet(controller : UIViewController)
    {
        let alert = UIAlertController(title: "Filters", message: "Choose from options below to filter", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Duration", style: .default, handler: {(_) in
            //print("Duration runtime pressed")
        }))
        alert.addAction(UIAlertAction(title: "Rating", style: .default, handler: {(_) in
            //print("imdb pressed")
        }))
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: { (_) in
            //print("User click Dismiss button")
        }))
    }
    
}
extension HomeViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == homeCollectionView{
            return  movies.count
        }
        else{
            return imageData.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == homeCollectionView{
            guard let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuCell", for: indexPath) as? MenuCollectionViewCell else {return MenuCollectionViewCell()}
            if(movieImages.count>indexPath.row){
                collectionCell.imageView.image = UIImage(data: movieImages[indexPath.row])
                collectionCell.layer.cornerRadius = 10
            }
            else {
                collectionCell.setData(data: movies[indexPath.row])
            }
            
            // collectionCell.setData(data: movies[indexPath.row])
            return collectionCell
        }
        else
        {
            guard let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as? CardCollectionViewCell else {return CardCollectionViewCell()}
            collectionCell.cardImageView.image = imageData[indexPath.row]
            print("cardCell number: \(indexPath)")
            return collectionCell
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let destinationVC = storyboard.instantiateViewController(withIdentifier: "MoviePageViewController") as? MoviePageViewController else { return}
        destinationVC.movieIndex = indexPath.row
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == homeCollectionView{
            return CGSize(width: (collectionView.frame.size.width-40)/3, height: collectionView.bounds.size.height)
        }
        else{
            return CGSize(width: (collectionView.frame.size.width - 60), height: collectionView.bounds.size.height)
        }
    }
}
