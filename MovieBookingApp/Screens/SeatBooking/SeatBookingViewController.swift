//
//  SeatBookingViewController.swift
//  MovieBookingApp
//
//  Created by Bhavishya Sharma on 11/04/23.
//

import UIKit

enum FieldType {
    case movie, theatre
}
struct BookingDataModel {
    let name: String
    let type: FieldType
}

class TableCell : UITableViewCell{
    
}

class SeatBookingViewController: UIViewController {

    @IBOutlet weak var seatLayoutCollectionView: UICollectionView!
    @IBOutlet weak var ivMoviePoster: UIImageView!
    @IBOutlet weak var viewBookingDetails: UIView!
    @IBOutlet weak var viewMovieTime: UIView!
    @IBOutlet weak var viewMovieDate: UIView!
    @IBOutlet weak var viewTheatreName: UIView!
    
    @IBOutlet weak var lblMovieName: UILabel!
    @IBOutlet weak var lblMovieDate: UILabel!
    @IBOutlet weak var lblMovieTime: UILabel!
    @IBOutlet weak var lblTheatreName: UILabel!
    
    
    @IBOutlet weak var svMovieName: UIStackView!
    @IBOutlet weak var svMovieDate: UIStackView!
    @IBOutlet weak var svMovieTime: UIStackView!
    @IBOutlet weak var svTheatreName: UIStackView!
    
    
    
    @IBOutlet weak var priceView: UIView!
    @IBOutlet weak var btnPayment: UIButton!
    @IBOutlet weak var lblTotalPrice: UILabel!
    @IBOutlet weak var lblTicketCount: UILabel!
    @IBOutlet weak var bottomViewHeight: NSLayoutConstraint!
    
    
    @IBAction func btnPaymentTouchUp(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "BookingConfirmationViewController")
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    let transparentView = UIView()
    let tableView = UITableView()
    var selectedFrame = CGRect()
    var selectedLabel = UILabel()
    var dataSource: [BookingDataModel] = []
    
    
    var seatLayout = [[0, 0, 1, 0, 1, 1, 1, 1, 0, 1, 0, 0],
                      [0, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1, 0],
                      [1, 1, 1, 0, 1, 1, 3, 3, 0, 1, 1, 1],
                      [1, 1, 1, 0, 1, 1, 3, 3, 0, 1, 1, 1],
                      [1, 1, 1, 0, 1, 1, 3, 3, 0, 1, 1, 1],
                      [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                      [1, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1, 1],
                      [1, 1, 1, 0, 1, 3, 3, 3, 0, 1, 1, 1],
                      [1, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1, 1],
                      [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                      [1, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1, 1],
                      [1, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1, 1]]
    
    var seatCount: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        seatLayoutCollectionView.delegate = self
        seatLayoutCollectionView.dataSource = self
        formatView(view: viewTheatreName)
        formatView(view: viewMovieTime)
        formatView(view: viewMovieDate)
        formatView(view: priceView)
        formatMajorView(view: viewBookingDetails)
        formatPoster(imageView: ivMoviePoster)
        tableView.register(TableCell.self, forCellReuseIdentifier: "Cell")
        btnPayment.layer.cornerRadius = 30
        // Do any additional setup after loading the view.
    }
    
    func addTransaprentView(frame: CGRect){
        let window = UIApplication.shared.keyWindow
        transparentView.frame = window?.frame ?? self.view.frame
        self.view.addSubview(transparentView)
        
        tableView.frame = CGRect(x: frame.origin.x, y: frame.origin.y + frame.height, width: frame.width, height: 0)
        self.view.addSubview(tableView)
        tableView.layer.cornerRadius = 3
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        tableView.reloadData()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(removeTransparentView))
        
        transparentView.addGestureRecognizer(tapGesture)
        transparentView.alpha = 0
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0,options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0.5
            self.tableView.frame = CGRect(x: frame.origin.x, y: frame.origin.y + frame.height, width: frame.width, height: 200)
        }, completion: nil)
    }
    
    @objc func removeTransparentView(){
        let frame = selectedFrame
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0,options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0
            self.tableView.frame = CGRect(x: frame.origin.x, y: frame.origin.y + frame.height, width: frame.width, height:0)
        }, completion: nil)
        
    }
    
    @IBAction func movieSelctionButtonTouchUp(_ sender: Any) {
        dataSource = ["The Super Mario Bros. Movie", "The Lost King", "The Pope's Exorcist", "John Wick Chapter 4", "All Of Those Voices", "The Eternal Daughter", "Scream VI", "Triangle Of Sadness"].map({ BookingDataModel(name: $0, type: .movie) })
        selectedFrame = view.convert(svMovieName.frame, from: svMovieName.superview)
        selectedLabel = lblMovieName
        addTransaprentView(frame: view.convert(svMovieName.frame, from: svMovieName.superview))
    }
    
    @IBAction func theatreSelctionButtonTouchUp(_ sender: Any) {
        dataSource = ["Cinepolis", "Inox Movies", "E Square Multiplex", "City Pride Multiplex", "Cinepolis IMAX Pune", "Westend Cinema"].map({ BookingDataModel(name: $0, type: .theatre) })
        selectedFrame = view.convert(svTheatreName.frame, from: svTheatreName.superview)
        selectedLabel = lblTheatreName
        addTransaprentView(frame: view.convert(svTheatreName.frame, from: svTheatreName.superview))
        print("frame of clicked field is \(svTheatreName.frame)")
    }
    
    @IBAction func dateSelctionButtonTouchUp(_ sender: Any) {
        selectedFrame = view.convert(svMovieDate.frame, from: svMovieDate.superview)
        selectedLabel = lblMovieDate
        addTransaprentView(frame: view.convert(svMovieDate.frame, from: svMovieDate.superview))
        print("frame of clicked field is \(svMovieDate.frame)")
    }
    
    @IBAction func timeSelctionButtonTouchUp(_ sender: Any) {
        selectedFrame = view.convert(svMovieTime.frame, from: svMovieTime.superview)
        selectedLabel = lblMovieTime
        addTransaprentView(frame: view.convert(svMovieTime.frame, from: svMovieTime.superview))
        print("frame of clicked field is \(svMovieTime.frame)")
    }
    func formatPoster( imageView : UIImageView){
        imageView.layer.cornerRadius = 25
        
    }
    
    func formatMajorView( view : UIView){
        view.layer.cornerRadius = 10
        view.layer.shadowRadius = 10
        view.layer.shadowOpacity = 0.5
    }
        
    func formatView(view: UIView){
        //view.layer.borderColor = CGColor(gray: 1/1.5, alpha: 1)
        view.layer.cornerRadius = 15
        view.layer.borderWidth = 1
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
extension SeatBookingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        12
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        12
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width/12), height: (collectionView.frame.height/12))
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SeatCell", for: indexPath) as? SeatCollectionViewCell else {return SeatCollectionViewCell()}
        if seatLayout[indexPath.section][indexPath.row] == 0 {
            cell.seat.image = nil
        }else if seatLayout[indexPath.section][indexPath.row] == 1 {
            cell.seat.image = #imageLiteral(resourceName: "unFilled")
        }else if seatLayout[indexPath.section][indexPath.row] == 2 {
            cell.seat.image = #imageLiteral(resourceName: "selected")
        }
        else{
            cell.seat.image = #imageLiteral(resourceName: "filled")
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(seatLayout[indexPath.section][indexPath.row]==1) {
            seatLayout[indexPath.section][indexPath.row] = 2
            seatCount += 1
            if seatCount == 1{
              //  showBottomView()
            }
            setSeatnPrice()
        } else if(seatLayout[indexPath.section][indexPath.row]==2) {
            seatLayout[indexPath.section][indexPath.row] = 1
            seatCount -= 1
            if seatCount == 0{
                hideBottomView()
            }
            setSeatnPrice()
        }
        seatLayoutCollectionView.reloadData()
    }
    
    
}
extension SeatBookingViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? TableCell else {return TableCell()}
        cell.textLabel?.text = dataSource[indexPath.row].name
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(dataSource[indexPath.row].type)
        selectedLabel.text =  dataSource[indexPath.row].name
        ivMoviePoster.image = imageData[indexPath.row]
        removeTransparentView()
    }
    func showBottomView(){
        seatLayoutCollectionView.scrollsToTop = true
        UIView.animate(withDuration: 0.5, animations: {
            self.bottomViewHeight.constant = 60
        }) { (success) in
        }
    }
    func hideBottomView(){
        UIView.animate(withDuration: 0.5, animations: {            self.bottomViewHeight.constant = 0
        }) { (success) in
        }
    }
//
    func setSeatnPrice(){
        let price = Double(seatCount)*260.00
        if price != 0.0 {
            lblTotalPrice.text = ("₹ \(price)")
        }else{
            lblTotalPrice.text = "₹ 0"
        }
        lblTicketCount.text = "\(seatCount)"
    }
}

