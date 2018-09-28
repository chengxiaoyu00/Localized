//
//  Bundle+LBELocalized.swift
//  LBELocalized
//
//  Created by chengxiaoyu on 2018/5/17.
//  Copyright © 2018年 chengxiaoyu. All rights reserved.
//

import UIKit

public let kUserLanguage:String = "kUserLanguage"
public let kTableDefault:String = "Localizable"
public let kNotifyRootViewControllerReset:String = "kNotifyRootViewControllerReset"

class LBELocalizedStr: NSObject {
    
    
    public func LBE_NSLocalizedString(_ key: String, tableName: String?  , comment: String) -> String {

        var locaname :String?
        
        if let talN = tableName {
            locaname = talN
        }else{
            locaname = kTableDefault
        }
       
        return  NSLocalizedString(key, tableName:locaname, bundle: setupLocalizedBubdle(),comment: "")
        
    }

    fileprivate static let language = (Locale.current as NSLocale).object(forKey: NSLocale.Key.languageCode)
    
    private func setupLocalizedBubdle() -> Bundle {
   
        var userLanguage = UserDefaults.standard.object(forKey: kUserLanguage)
        //初始值，用户未设置过语言
        if (userLanguage == nil) {
            //暂时取本地化数组第一个元素
            let systemLanguage = Bundle.main.localizations.first
            userLanguage = systemLanguage;
        }
   
        let path = Bundle.main.path(forResource: userLanguage as? String, ofType: "lproj")
        
        return Bundle.init(path: path!)!
    
    }
    func currentLanguage() -> String {
        var userLanguage = UserDefaults.standard.object(forKey: kUserLanguage)
        //初始值，用户未设置过语言
        if (userLanguage == nil) {
            //暂时取本地化数组第一个元素
            let systemLanguage = Bundle.main.localizations.first
            userLanguage = systemLanguage;
        }
        return (userLanguage as? String)!;
    }
    func setUserLanguage(_ key:String) {
        if !key.isEmpty {
            let defaults = UserDefaults.standard
            defaults.set(key, forKey: kUserLanguage)
            defaults.synchronize()
            let time: TimeInterval = 1.0
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) {
                NotificationCenter.default.post(name:NSNotification.Name.init(rawValue: kNotifyRootViewControllerReset) , object: nil)
            }
        }
        let DIC = Bundle.main.localizedInfoDictionary
        let preferred = Bundle.main.preferredLocalizations
        let info = LBELocalizedStr.availableLocalizations()
                
    }
    /// 当前可用所有的可选语言项
    ///
    /// - Returns: [zh-Hans,en,....]
    public class func availableLocalizations() -> [String] {
        #if VideoShow_China
        
        return Bundle.main.localizations
        #else
        //        zh-Hans
        //        zh-Hant
        let bund = LBELocalizedStr().setupLocalizedBubdle()
        var filteredArray = bund.localizations.filter(){
            return (!$0.hasPrefix("zh-Hans") && !$0.hasPrefix("zh-Hant"))
        }
        //            print(filteredArray)
        filteredArray.insert("defult", at: 0)
        return filteredArray//Bundle.main.localizations
        #endif
    }
}

