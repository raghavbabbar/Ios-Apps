//
//  first.swift
//  GAME
//
//  Created by raghav babbar on 22/04/17.
//  Copyright © 2017 raghav babbar. All rights reserved.
//

import UIKit

class first: UIViewController,UITextFieldDelegate {


   // @IBOutlet weak var nnxt: UIButton!
    @IBOutlet weak var nnxt: UIButton!
    @IBOutlet weak var first: UITextField!
    @IBOutlet weak var sec: UITextField!
    var f1=false
    var f2=false
    override func viewDidLoad()
    {
super.viewDidLoad()
first.delegate=self
sec.delegate=self
        nnxt.isEnabled=false
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        return true;
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField==first
        {
          if textField.text != ""
          {    f1=true
        }
        }
        if textField==sec
        {
            if textField.text != ""
            {    f2=true
            }
        }
        if f1&&f2
        {nnxt.isEnabled=true
        }
        
        }
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let s=segue.destination as! second
       let a=main()
        a.firstname=self.first.text
        a.lastName=self.sec.text
        s.obj=a
           }

    @IBAction func next(_ sender: Any) {
        performSegue(withIdentifier: "one", sender: nil)
         }
 }
