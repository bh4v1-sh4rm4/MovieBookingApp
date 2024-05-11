//
//  RegisterViewController.swift
//  MovieBookingApp
//
//  Created by Bhavishya Sharma on 04/04/23.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {
    
    let userDefaults = UserDefaults.standard
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfConfirmPassword: UITextField!
    @IBOutlet weak var lblPasswordError: UILabel!
    @IBOutlet weak var lblEmailError: UILabel!
    @IBOutlet weak var lblNameError: UILabel!
    @IBOutlet weak var lblConfirmPasswordError: UILabel!
    @IBOutlet weak var btnRegister: UIButton!
    @IBOutlet weak var lblLoginNow: UILabel!
    @IBAction func emailChanged(_ sender: Any) {
        if let email = tfEmail.text
        {
            if let errorMessage = invalidEmail(email)
            {
                lblEmailError.text = errorMessage
                lblEmailError.isHidden = false
            }
            else
            {
                lblEmailError.isHidden = true
            }
        }
        checkForValidForm()
    }
    @IBAction func nameChanged(_ sender: Any) {
        if tfName.text != ""{
            lblNameError.isHidden = true
        }
        else{
            lblNameError.isHidden = false
        }
    }
    @IBAction func confirmPasswordChanged(_ sender: Any) {
        let confirmPassword = tfConfirmPassword.text
        if let errorMessage = matchPasswords(confirmPassword!){
            lblConfirmPasswordError.text = errorMessage
            lblConfirmPasswordError.isHidden = false
        }
        else{
            lblConfirmPasswordError.isHidden = true
        }
        checkForValidForm()
    }
    @IBAction func btnRegisterTapped(_ sender: Any) {
        
        if let email = tfEmail.text, let confirmPassword = tfConfirmPassword.text {
            Auth.auth().createUser(withEmail: email, password: confirmPassword) { result, error in
                if let e = error {
                    self.showErrorDailog(message: e.localizedDescription)
                }
                else{
                    self.registerAndNaviagte()
                }
            }
        }
    }
    @IBAction func passwordChanged(_ sender: Any) {
        if let password = tfPassword.text
        {
            if let errorMessage = invalidPassword(password)
            {
                lblPasswordError.text = errorMessage
                lblPasswordError.isHidden = false
            }
            else
            {
                lblPasswordError.isHidden = true
            }
        }
        checkForValidForm()
    }
   // var userDict : Dictionary<String,UserData>?
    override func viewDidLoad() {
        super.viewDidLoad()
        formatTextField(tfName)
        formatTextField(tfEmail)
        formatTextField(tfPassword)
        formatTextField(tfConfirmPassword)
        checkForValidForm()
        self.navigationController?.isNavigationBarHidden = true
        addTapGesture(lblLoginNow, #selector(tappedLoginNow))
        // Do any additional setup after loading the view.
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
    
    @objc func tappedLoginNow(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            self.navigationController?.popViewController(animated: true)
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
    func registerAndNaviagte(){
        let alert = UIAlertController(title: "Well Done!", message: "See you at the movies!!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler : {_ in
            self.navigationController?.popViewController(animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    func showErrorDailog(message : String?) {
        let alert = UIAlertController(title: "Error", message: message , preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler : {_ in
        }))
        self.present(alert, animated: true, completion: nil)
    }
    func invalidEmail(_ value: String) -> String?{
        let reqularExpression = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", reqularExpression)
        if !predicate.evaluate(with: value){
            return "Invalid email"
        }
        else{
            return nil
        }
    }
    func matchPasswords(_ value: String)-> String?{
        if(value != tfPassword.text){
            return "Password does not match."
        }
        else{
            return nil
        }
    }
    func invalidPassword(_ value: String) -> String? {
        if containsUpperCase(value)
        {
            return "Password must contain at least 1 uppercase character"
        }
        if containsSpecialCharacter(value)
        {
            return "Password must contain at least 1 special character like $, &, ?, @, #, !"
        }
        if containsDigit(value)
        {
            return "Password must contain at least 1 digit"
        }
        if value.count < 8
        {
            return "Password must be at least 8 characters"
        }
        
        return nil
    }
    func containsDigit(_ value: String) -> Bool
    {
        let reqularExpression = ".*[0-9]+.*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", reqularExpression)
        return !predicate.evaluate(with: value)
    }
    
    func containsSpecialCharacter(_ value: String) -> Bool
    {
        let reqularExpression = ".*[$&?@#!]+.*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", reqularExpression)
        return !predicate.evaluate(with: value)
    }
    
    func containsUpperCase(_ value: String) -> Bool
    {
        let reqularExpression = ".*[A-Z]+.*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", reqularExpression)
        return !predicate.evaluate(with: value)
    }
    
    func checkForValidForm()
    {
        if lblPasswordError.isHidden && lblEmailError.isHidden && lblNameError.isHidden && lblConfirmPasswordError.isHidden
        {
            btnRegister.isEnabled = true
            btnRegister.backgroundColor = UIColor(named: "blueButtonColor")
            btnRegister.alpha = 1.0
        }
        else
        {
            btnRegister.isEnabled = false
            btnRegister.backgroundColor = UIColor(named: "blueButtonColor")
            btnRegister.alpha = 0.5
        }
    }

}
extension RegisterViewController{
    func formatTextField( _ textField: UITextField){
         let layer = CALayer()
        layer.backgroundColor = UIColor.lightGray.cgColor
        layer.frame = CGRect(x: 0, y: textField.frame.height - 1, width: textField.frame.width, height: 1)
        textField.layer.addSublayer(layer)
        self.view.layer.masksToBounds = true
    }
}

