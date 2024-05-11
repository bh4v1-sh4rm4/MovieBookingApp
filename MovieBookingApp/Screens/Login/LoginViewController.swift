//
//  ViewController.swift
//  MovieBookingApp
//
//  Created by Bhavishya Sharma on 04/04/23.
//
import UIKit
import FirebaseAuth



class LoginViewController: UIViewController {
    let userDefaults = UserDefaults.standard
    let emailLayer = CALayer()
    let passwordLayer = CALayer()
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var lblForgotPassword: UILabel!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var lblRegister: UILabel!

    @IBAction func btnLogin(_ sender: Any) {
        if let email = tfEmail.text, let password = tfPassword.text {
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
                if let e = error {
                    
                }
                else
                {
                    self?.navigationController?.pushViewController(HomeViewController(), animated: true)
                }
            }
            UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
        }
    }

   
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUsers()
        // Do any additional setup after loading the view.
        formatTextField(emailLayer, tfEmail)
        formatTextField(passwordLayer, tfPassword)
        addTapGesture(lblRegister, #selector(self.tappedRegister))
        print(savedDetails)
    }
    func loadUsers(){
        let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURL = URL(fileURLWithPath: "userFile", relativeTo: directoryURL).appendingPathExtension("txt")
        do {
            let data = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()

            savedDetails = try decoder.decode(Users.self, from: data)
        }
        catch {
            print("Unable to retrieve users")
        }
    }
    func addTapGesture(_ button : UILabel, _ action: Selector){
        let tapGR = UITapGestureRecognizer(target: self, action: action)
        button.addGestureRecognizer(tapGR)
        button.isUserInteractionEnabled = true
    }
    func presentViewController(_ string:  String)
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: string)
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    @objc func tappedRegister(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            presentViewController("RegisterViewController")
        }
    }

}

extension LoginViewController{
    func formatTextField(_ layer: CALayer, _ textField: UITextField){
        layer.backgroundColor = UIColor.lightGray.cgColor
        layer.frame = CGRect(x: 0, y: textField.frame.height - 1, width: textField.frame.width, height: 1)
        textField.layer.addSublayer(layer)
        self.view.layer.masksToBounds = true
    }
    
//    func formatViews(view: UIView){
//        view.clipsToBounds = true
//        view.layer.cornerRadius = 90
//        
//        view.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
//    }
}
