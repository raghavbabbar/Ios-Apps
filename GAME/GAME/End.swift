//
//  End.swift
//  GAME
//
//  Created by raghav babbar and raghav mahajan on 18/04/17.
//  Copyright © 2017 raghav babbar. All rights reserved.
//

import UIKit

class End: UIViewController {
    var obj:main!
    var p1=0
    var maketime=0
    @IBOutlet weak var TopLabel: UILabel!
    var arr=[Int](repeating: 0, count: 27)
    @IBOutlet weak var tview: UITextView!
    @IBOutlet weak var timer: UILabel!
    @IBOutlet weak var R: UIButton!
    @IBOutlet weak var Y: UIButton!
    @IBOutlet weak var P: UIButton!
    @IBOutlet weak var J: UIButton!
    @IBOutlet weak var Z: UIButton!
    @IBOutlet weak var V: UIButton!
    @IBOutlet weak var N: UIButton!
    @IBOutlet weak var HINT: UIButton!
    @IBOutlet weak var M: UIButton!
    @IBOutlet weak var B: UIButton!
    @IBOutlet weak var C: UIButton!
    @IBOutlet weak var X: UIButton!
    @IBOutlet weak var L: UIButton!
    @IBOutlet weak var K: UIButton!
    @IBOutlet weak var H: UIButton!
    @IBOutlet weak var G: UIButton!
    @IBOutlet weak var F: UIButton!
    @IBOutlet weak var D: UIButton!
    @IBOutlet weak var S: UIButton!
    @IBOutlet weak var A: UIButton!
    @IBOutlet weak var O: UIButton!
    @IBOutlet weak var I: UIButton!
    @IBOutlet weak var U: UIButton!
    @IBOutlet weak var T: UIButton!
    @IBOutlet weak var E: UIButton!
    @IBOutlet weak var W: UIButton!
    @IBOutlet weak var Q: UIButton!
    var tt=Timer()
    var nn=0
    var str:String!
    var original:String!
    var rr=[Character]()
    var rr2=[Character]()
    var type:String!
    var count=0
    var t=[Character]()
    var ms:String!
    var mak=Timer()
    override func viewDidLoad() {
        super.viewDidLoad()
      
        tt=Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(change), userInfo: nil, repeats: true)
        self.f();
        str=obj.Moviename!
        original=str
        tview.text=str
      
        for c in original.characters
        { rr.append(c)
        }
        rr2=rr
        f2(s: str);
        type=obj.type!
        TopLabel.text=type
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        for c in type.characters
        {t.append(c)
        }
    }
    func f2(s:String)
    {  var a=rr.startIndex
       let b=rr.endIndex
        while a != b
        { if rr[a]=="A"||rr[a]=="E"||rr[a]=="I"||rr[a]=="O"||rr[a]=="U"
        {}
         else if rr[a] != " "
        {rr[a]="-"
            
        }
          a+=1
        }
    tview.text=String(rr)
    }
  
   
    @IBAction func Qaction(_ sender: Any) {
        ge(sender);
    }
    
    @IBAction func Waction(_ sender: Any) {
         ge(sender);
    }
   
    @IBAction func ge(_ sende:Any )
    {let btn=sende as! UIButton
    let tex=btn.titleLabel?.text
    btn.layer.cornerRadius=10
    btn.backgroundColor=UIColor(red: 60/255, green: 128/255, blue: 185/255, alpha: 1)
    btn.isEnabled=false
    if original.contains(tex!)
    {  let c=Character(tex!)
        var a=rr.startIndex
        let b=rr.endIndex
        while a != b
        {if rr2[a]==c
        {rr[a]=c
        }
        a+=1
        }
        tview.text=String(rr)
        }
    else if count != 10
        {
            t[count]="✕"
            count+=1
         TopLabel.text=String(t)
        }
    }
    func change()
    {nn+=1;
       
        timer.text="\(nn%100)"
        if String(rr)==original || nn==99 || count==10
        { tt.invalidate();
          let vc=storyboard?.instantiateViewController(withIdentifier: "ll") as! last
           
            self.obj.t=10-count
            vc.m=obj
            present(vc, animated: true, completion: nil)
        }
        
    }
    @IBAction func hintAction(_ sender: Any)
    {   if p1%2==0
    {   if obj.hint1 != ""
    {HINT.setTitle(obj.hint1, for: .normal)
    }
    }
    else
    {
        if obj.hint2 != ""
        {HINT.setTitle(obj.hint2, for: .normal)
        }
        
    }
        p1+=1
    }
       func f()
    {f1(B: Q);
        f1(B: W);
        f1(B: E);
        f1(B: R);
        f1(B: T);
        f1(B: Y);
        f1(B: U);
        f1(B: I);
        f1(B: O);
        f1(B: P);
        f1(B: A);
        f1(B: S);
        f1(B: D);
        f1(B: F);
        f1(B: G);
        f1(B: H);
        f1(B: J);
        f1(B: K);
        f1(B: L);
        f1(B: Z);
        f1(B: X);
        f1(B: C);
        f1(B: V);
        f1(B: B);
        f1(B: N);
        f1(B: M);




    }
    func f1(B:UIButton)
    {   B.layer.borderWidth=3
        B.layer.borderColor = UIColor(red: 157/255, green: 31/255, blue: 39/255, alpha: 1).cgColor

    }
   
    @IBAction func exitAction(_ sender: UIButton)
     { let t = storyboard?.instantiateViewController(withIdentifier: "nav")
        present(t!, animated: true, completion: nil)
    }
}
