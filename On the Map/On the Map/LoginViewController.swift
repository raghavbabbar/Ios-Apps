//
//  LoginViewController.swift
//  On the Map
//
//  Created by raghav babbar on 17/03/17.
//  Copyright © 2017 raghav babbar. All rights reserved.
//

import UIKit
import AVFoundation
import AudioToolbox
class LoginViewController: UIViewController ,UITextFieldDelegate{
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var password: UITextField!
    //   @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var udacityLabel: UILabel!
    
    
    @IBOutlet weak var loginButton: UIButton!
    var getxEmail:CGFloat!
    var getxPass:CGFloat!
    var btnx:CGFloat!
    var labelx:CGFloat!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.configureTextField([self.name,self.password])
            self.configureUI()
            self.setUp()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            
            
            self.configureTextField([self.name,self.password])
            self.configureUI()
        }
    }
    
    func setUp()
    {
        getxEmail=name.center.x;
        getxPass=password.center.x;
        btnx=loginButton.center.x
        labelx=udacityLabel.center.x
        name.delegate=self
        password.delegate=self
        password.isSecureTextEntry=true
        
        subscribeToNotification(.UIKeyboardWillShow, selector: #selector(moveUp(notification:)))
        subscribeToNotification(.UIKeyboardWillHide, selector: #selector(moveDown(notification:)))
        
        
        
        
    }
    
    func animate()
    {
        
        
        name.center.x+=10
        password.center.x+=10
        loginButton.center.x+=10
        udacityLabel.center.x+=10
        UIView.animateKeyframes(withDuration: 0.2, delay: 0, options: .autoreverse , animations: {
            self.name.center.x-=20
            self.password.center.x-=20
            self.loginButton.center.x-=20
            self.udacityLabel.center.x-=20
            
        }, completion: { a in
            
            UIView.animateKeyframes(withDuration: 0.1, delay: 0, options: .beginFromCurrentState, animations: {
                
                self.name.center.x=self.getxEmail
                self.password.center.x=self.getxPass
                self.loginButton.center.x=self.btnx
                self.udacityLabel.center.x=self.labelx
            }, completion: nil)
            
            
        })
        AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
        
    }
    
    
    func getHeight( notification: Notification) -> CGFloat {
        let info=(notification as NSNotification).userInfo
        let Size =  info![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return Size.cgRectValue.height
    }
    override func viewWillDisappear(_ animated: Bool) {
        //  NotificationCenter.default.removeObserver(self)
    }
    
    
    func moveUp(notification:Notification)
    {
        if self.view.frame.origin.y >= 0
        {
            self.view.frame.origin.y-=self.getHeight(notification: notification) - 14
        }
        
    }
    func moveDown(notification:Notification)
    {
        self.view.frame.origin.y+=self.getHeight(notification: notification) - 14
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        self.view.frame.origin.y=0
        return true
    }
    @IBAction func loginButton(_ sender: Any)
    { if name.text == "" || password.text == ""
    {
        alert(message: "Please Enter The Details")
    }
    else
    {
        setUIEnable(enable: false)
        validateLogin(name: name.text!, password: password.text!, responsee: responseAfterLogin(e:))
        
        }
        
    }
    func responseAfterLogin(e error:String?)
    {
        if error != nil
        {
            
            loginFailed()
            
            alert(message: error!)
            
        }
        else
        {
            
            DispatchQueue.main.async {
                self.setUIEnable(enable: true)
                self.completeLogin()
            }
        }
        
    }
    
    
    func configureUI()
    {           let toolbar = UIToolbar()
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(d))
        toolbar.sizeToFit()
        toolbar.setItems([done], animated: true);
        password.inputAccessoryView  = toolbar
        
        
    }
    func configureTextField(_ textFields: [UITextField]) {
        
        for textField in textFields {
            
            let textFieldPaddingViewFrame = CGRect(x: 0.0, y: 0.0, width: 13.0, height: 0.0)
            let textFieldPaddingView = UIView(frame: textFieldPaddingViewFrame)
            textField.leftView = textFieldPaddingView
            textField.leftViewMode = .always
            textField.textColor = UIColor.white
            textField.attributedPlaceholder = NSAttributedString(string: textField.placeholder!,attributes: [NSForegroundColorAttributeName: UIColor.white])
            textField.tintColor = UIColor(colorLiteralRed: 1, green: 118/255, blue: 18/255, alpha: 1.0)
        }
    }
    func completeLogin()
    {
        setUIEnable(enable: true)
        let control = storyboard?.instantiateViewController(withIdentifier: "tabbar") as! UITabBarController
        present(control, animated: true, completion:  nil );
    }
    func loginFailed()
    {
        self.setUIEnable(enable: true)
       // self.animate()
    }
    
    
    func setUIEnable(enable:Bool)
    {
        self.name.isEnabled=enable
        self.password.isEnabled=enable
        self.loginButton.isEnabled=enable
        if !enable
        {
            self.view.alpha = 0.7
        }
        else
        {
            self.view.alpha = 1
            
        }
        
    }
    
    
    
}
private extension LoginViewController {
    
    func subscribeToNotification(_ notification: NSNotification.Name, selector: Selector) {
        NotificationCenter.default.addObserver(self, selector: selector, name: notification, object: nil)
    }
    
    func unsubscribeFromAllNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    
    func alert(message:String )
    {
        DispatchQueue.main.async {
            
            
            let alertview = UIAlertController(title: "", message: message, preferredStyle: .alert)
            alertview.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: {
                action in
                DispatchQueue.main.async {
                    
                    self.setUIEnable(enable: true)
                }
            }))
            self.present(alertview, animated: true, completion: nil)
        }
    }
    
    
    
    @objc  func d()
    { view.endEditing(true)
    }
    
}


