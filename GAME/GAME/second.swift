//
//  second.swift
//  GAME
//
//  Created by raghav babbar on 22/04/17.
//  Copyright © 2017 raghav babbar. All rights reserved.
//

import UIKit

class second: UIViewController ,UITextFieldDelegate{
    var obj:main!
//    @IBOutlet weak var titkle: UILabel!
    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var hint2: UITextField!
    @IBOutlet weak var moviename: UITextField!
    @IBOutlet weak var hint1: UITextField!
    @IBOutlet weak var boo: UIButton!
    @IBOutlet weak var hoo: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
           moviename.delegate=self
           hint1.delegate=self
           hint2.delegate=self
        boo.isEnabled=false
        hoo.isEnabled=false
        lbl.text="Hey! \(obj.firstname!) enter the movie name "
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField==moviename
        { if moviename.text != ""
        {   boo.isEnabled=true
            hoo.isEnabled=true
        }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func nxtXl(_ sender: Any)
    {
       let a=storyboard?.instantiateViewController(withIdentifier: "endr") as! End
        obj.Moviename=moviename.text?.uppercased()
        let btn=sender as! UIButton
        obj.type=btn.currentTitle!+"!"
        
        obj.hint1=hint1.text
        obj.hint2=hint2.text
        a.obj=self.obj
        present(a, animated: true, completion: nil)
    }
}
