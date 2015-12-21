//
//  ViewController.swift
//  NormalHandleForDate
//
//  Created by Dylan on 15/12/21.
//  Copyright © 2015年 Dylan.Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print(DateHelper.timestamp())
        
        print(DateHelper.stringWithFormat("YYYY-MM-dd HH:mm:ss", date: NSDate()))
        
        print(DateHelper.stringWithFormat("YYYY-MM-dd HH:mm", dateStr: "2015-10-30 17:19:22"))
        
        print(DateHelper.stringWithFormat("2015-10-30 01:19:22"))
        
        print(DateHelper.dateWithFormat("2015-10-30 01:19:22"))
        
        print(DateHelper.getDateAfterTimeInterval("YYYY-MM-dd HH:mm:ss", dateStr: "2015-10-30 17:19:22", timeInterval: 13))
        
        print(DateHelper.currentTimeZoneDate())
        
        print(DateHelper.getDateDescription(DateHelper.currentTimeZoneDate()))

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

