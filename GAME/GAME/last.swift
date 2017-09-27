//
//  last.swift
//  GAME
//
//  Created by raghav babbar on 22/04/17.
//  Copyright © 2017 raghav babbar. All rights reserved.
//

import UIKit

class last: UIViewController {
    var a=10
    var m:main!
    @IBOutlet weak var sc: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var btn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        name.text=m.Moviename!
        sc.text="Your Score  : \(m.t!) "
        name.alpha=0
        sc.alpha=0
 //  tt.text="THE MOVIE WAS \n RAZZ\n Score : \(a)"
        // Do any additional setup after loading the view.
      btn.layer.borderWidth=3
      btn.layer.borderColor=UIColor.white.cgColor
      btn.layer.cornerRadius=10
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIView.animate(withDuration: 1, animations: {
        self.name.alpha=1
        }) { (i) in
            UIView.animate(withDuration: 1, animations: {
                self.sc.alpha=1
            })
            
        }
        
    }

    
    @IBAction func call(_ sender: Any)
    {
        let t = storyboard?.instantiateViewController(withIdentifier: "nav")
        present(t!, animated: true, completion: nil)
    }

}
