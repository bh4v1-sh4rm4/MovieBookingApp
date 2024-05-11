//
//  BrowseViewController.swift
//  MovieBookingApp
//
//  Created by Bhavishya Sharma on 04/04/23.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet weak var menuCollectionView: UICollectionView!
    
    let cell = MenuCollectionViewCell()
    
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
    @IBAction func btnFilterTouchUp(_ sender: Any) {
        filterActionSheet(controller: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        fetchDevices(completion: movies)
        menuCollectionView.register(UINib(nibName: "MenuCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MenuCell")
        menuCollectionView.delegate = self
        menuCollectionView.dataSource = self
        // Do any additional setup after loading the view.
        //apiCall()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    /* Filter Button code start */
    func filterActionSheet(controller : UIViewController){
        let alert = UIAlertController(title: "Filters", message: "Choose from options below to filter", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Released", style: .default, handler: {(_) in
            //print("Released pressed")
            self.filteringReleasedDate()
        }))
        alert.addAction(UIAlertAction(title: "Year", style: .default, handler: {(_) in
            //print("Years pressed")
            self.filteringYear()
        }))
        alert.addAction(UIAlertAction(title: "Duration", style: .default, handler: {(_) in
            //print("Duration runtime pressed")
            self.filteringRuntime()
        }))
        alert.addAction(UIAlertAction(title: "Rating", style: .default, handler: {(_) in
            //print("imdb pressed")
            self.filteringRating()
        }))
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: { (_) in
            //print("User click Dismiss button")
        }))
        self.present(alert, animated: true, completion: {
           // print("completion block")
        })
    }
    /* Filtering Year code starts  */
    func filteringYear(){
        var filteredMovies = movies
        let moviesCount = movies.count-1
        for movie in 0...moviesCount-1{
            for j in 0...(moviesCount-movie-1){
            
                let filterYear1 = Int(filteredMovies[j].year) ?? 0
                let filterYear2 = Int(filteredMovies[j+1].year) ?? 0
            
                if(filterYear1 > filterYear2){
                    let tempArr = filteredMovies[j]
                    filteredMovies[j] = filteredMovies[j+1]
                    filteredMovies[j+1] = tempArr
                    
                }
            }
        }
        movies=filteredMovies
        DispatchQueue.main.async {
            self.menuCollectionView.reloadData()
        }
    }
    /* Filter Runtime code starts */
    func filteringRuntime(){
        
        var filteredMovies = movies
        let moviesCount = movies.count-1
        for movie in 0...moviesCount-1{
            for j in 0...(moviesCount-movie-1){
            
                let filterRun1 = filteredMovies[j].runtime.split(separator: " ")
                let filterRuntime1 = Int(filterRun1[0]) ?? 0
                let filterRun2 = filteredMovies[j+1].runtime.split(separator: " ")
                let filterRuntime2 = Int(filterRun2[0]) ?? 0
                
                if(filterRuntime1 > filterRuntime2){
                    let tempArr = filteredMovies[j]
                    filteredMovies[j] = filteredMovies[j+1]
                    filteredMovies[j+1] = tempArr

                }
            }
        }
        movies=filteredMovies
        DispatchQueue.main.async {
            self.menuCollectionView.reloadData()
        }
    }
    /* Filtering Ratings code start */
    func filteringRating(){
        var filteredMovies = movies
        let moviesCount = movies.count-1
        for movie in 0...moviesCount-1{
            for j in 0...(moviesCount-movie-1){
                    
                let filterRating1 = Double(filteredMovies[j].imdbRating) ?? 0
                let filterRating2 = Double(filteredMovies[j+1].imdbRating) ?? 0
            
                if(filterRating1 > filterRating2){
                    let tempArr = filteredMovies[j]
                    filteredMovies[j] = filteredMovies[j+1]
                    filteredMovies[j+1] = tempArr
                    
                }
            }
        }
        movies=filteredMovies
        DispatchQueue.main.async {
            self.menuCollectionView.reloadData()
        }
    }
    /* Filtering Released Date code start */
    func filteringReleasedDate(){
        var filteredMovies = movies
        let moviesCount = movies.count-1
        for movie in 0...moviesCount-1{
            for j in 0...(moviesCount-movie-1){
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd MMM yyyy"
                let filterDate1 = dateFormatter.date(from: filteredMovies[j].released) ?? Date()
                let filterDate2 = dateFormatter.date(from: filteredMovies[j+1].released) ?? Date()
            
                if (filterDate1.compare(filterDate2)) == .orderedAscending{
                    let tempArr = filteredMovies[j]
                    filteredMovies[j] = filteredMovies[j+1]
                    filteredMovies[j+1] = tempArr

                }
            }
        }
        movies=filteredMovies
        DispatchQueue.main.async {
            self.menuCollectionView.reloadData()
        }
    }

}
extension MenuViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("movies \(movies.count)")
        return movies.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuCell", for: indexPath) as? MenuCollectionViewCell else {return MenuCollectionViewCell()}
        collectionCell.setData(data: movies[indexPath.row])
//        collectionCell.imageView.image = nil
//        collectionCell.labelName.text = movies[indexPath.row].title
//        collectionCell.labelDuration.text = movies[indexPath.row].runtime
//        guard let url = URL(string: movies[indexPath.row].images[1]) else { return MenuCollectionViewCell() }
//        let dataTask = URLSession.shared.dataTask(with: url) { [weak self] (data, _, _) in
//            if let data = data {
//                DispatchQueue.main.async {
//                    movieImages.append(data)
//                    collectionCell.imageView.image = UIImage(data: data)
//                }
//            }
//        }
//        dataTask.resume()
        return collectionCell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (collectionView.frame.size.width-40)/3, height: collectionView.frame.size.height/3)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let destinationVC = storyboard.instantiateViewController(withIdentifier: "MoviePageViewController") as? MoviePageViewController else { return}
        destinationVC.movieIndex = indexPath.row
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    
}

