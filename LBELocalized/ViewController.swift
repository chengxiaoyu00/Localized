//
//  ViewController.swift
//  LBELocalized
//
//  Created by chengxiaoyu on 2018/5/17.
//  Copyright © 2018年 chengxiaoyu. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    private var changeBtn:UIButton?
  
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
        let srt = LBELocalizedStr().LBE_NSLocalizedString("change", tableName: nil, comment: "")
        
        changeBtn = UIButton.init(frame: CGRect(x:10, y: 100, width: 100, height: 100))
        changeBtn?.addTarget(self, action: #selector(ViewController.btnClick(sender:)), for: .touchUpInside)
        changeBtn?.setTitle(srt, for: .normal)
        changeBtn?.backgroundColor = UIColor.blue
        view.addSubview(changeBtn!)
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

    
}
//MARK:- 事件监听
extension ViewController {
    
    @objc fileprivate func btnClick(sender:UIButton) {
        
        sender.isSelected = !sender.isSelected
        if LBELocalizedStr().currentLanguage() == "zh-Hans" {
            LBELocalizedStr().setUserLanguage("en")
        }else{
        
            LBELocalizedStr().setUserLanguage("zh-Hans")
        }
            
    }
    
    
}
