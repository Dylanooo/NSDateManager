
//
//  DateHelper.swift
//  Drive
//
//  Created by Dylan on 15/12/21.
//  Copyright (c) 2015年 shop. All rights reserved.
//

import Foundation

class DateHelper {
    
    static let dateFormatter = NSDateFormatter()
   
    /// 获取时间戳
    ///
    /// :returns: Int
    class func timestamp() -> Int {
        return Int(NSDate().timeIntervalSince1970)
    }
    
    /// 格式化时间
    ///
    /// :param: format 日期格式  date 要格式化的日期
    /// :returns: String
    class func stringWithFormat(format:String = "yyyy-MM-dd", date: NSDate) -> String {
        dateFormatter.dateFormat = format
        return dateFormatter.stringFromDate(date)
    }
    
    /// 将格式为“yyyy-MM-dd”的时间格式化为 “yyyy-MM-dd HH:mm:ss”格式
    ///
    /// :param: format 日期格式  dateStr 日期字符串
    /// :returns: String
    
    class func stringWithFormat(format: String = "yyyy-MM-dd",dateStr: String) -> String {
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.dateFromString(dateStr)
        dateFormatter.dateFormat = format
        if let date = date {
            return dateFormatter.stringFromDate(date)
        } else {
            return ""
        }
        
    }
    
    /// 将格式为“yyyy-MM-dd HH:mm:ss”的时间格式化为“yyyy-MM-dd”格式
    ///
    /// :param: dateStr 日期字符串
    /// :returns: String
    
    class func stringWithFormat(dateString: String) -> String {
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.dateFromString(dateString)!
        return stringWithFormat("yyyy-MM-dd", date: date)
    }
    
    /// 将格式为“yyyy-MM-dd HH:mm:ss”的时间转换成NSDate
    ///
    /// :param: dateStr 日期字符串
    /// :returns: NSDate
    class func dateWithFormat(dateString: String) -> NSDate {
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let sourceTimeZone = NSTimeZone(abbreviation: "UTC")
        let destinationTimeZone = NSTimeZone.localTimeZone()
        let destinationGMTOffset = destinationTimeZone.secondsFromGMTForDate(dateFormatter.dateFromString(dateString)!)
        let sourceGMTOffset = sourceTimeZone?.secondsFromGMTForDate(dateFormatter.dateFromString(dateString)!)
        let interval: NSTimeInterval = Double(destinationGMTOffset - sourceGMTOffset!)
        
        let destinationDateNow = NSDate(timeInterval: interval, sinceDate: dateFormatter.dateFromString(dateString)!)
        return destinationDateNow
    }
    
    /// 某段时间后的 日期
    ///
    /// :param: format 日期格式 dateStr 日期字符串 timeInterval 需要延迟的秒数
    /// :returns: NSDate
    class func getDateAfterTimeInterval(format:String = "yyyy-MM-dd HH:mm:ss",dateStr: String, timeInterval: NSTimeInterval) -> NSDate {
        dateFormatter.dateFormat = format
        let dd = DateHelper.currentTimeZoneDate(dateFormatter.dateFromString(dateStr)!)
        
        return dd.dateByAddingTimeInterval(timeInterval)
    }
    
    ///获取当前时区下系统时间
    ///
    /// :param:
    /// :returns: NSDate
    class func currentTimeZoneDate() -> NSDate {
        let date = NSDate()
        let zone = NSTimeZone.systemTimeZone()
        let interval = zone.secondsFromGMTForDate(date)
        let zoneDate = date.dateByAddingTimeInterval(Double(interval))
        return zoneDate
    }
    
    /// 将日期转换成当前时区下日期
    ///
    /// :param: date 需要转换的日期
    /// :returns: NSDate
    class func currentTimeZoneDate(date: NSDate) -> NSDate {
        let zone = NSTimeZone.systemTimeZone()
        let interval = zone.secondsFromGMTForDate(date)
        let zoneDate = date.dateByAddingTimeInterval(Double(interval))
        return zoneDate
    }
    
    
    /// 将日期转换成微信转账格式的时间描述
    ///
    /// :param: date 需要转换的日期
    /// :returns: String
    class func getDateDescription(date: NSDate) -> String {
        let desDate = date
        let calendar = NSCalendar.currentCalendar()
        calendar.locale = NSLocale.currentLocale()
        
        let unitFlags: NSCalendarUnit = [.Era, .Year, .Month, .Day, .Hour, .Minute]
        var dateComponents = calendar.components(unitFlags, fromDate: desDate)
        dateComponents.timeZone = NSTimeZone.systemTimeZone()
        let destYear = dateComponents.year
        let destMonth = dateComponents.month
        let destDay = dateComponents.day
        
        dateComponents = calendar.components(unitFlags, fromDate: NSDate())
        dateComponents.timeZone = NSTimeZone.systemTimeZone()
        
        let currentYear = dateComponents.year
        let currentMonth = dateComponents.month
        let currentDay = dateComponents.day
        
        let dateFormatter = NSDateFormatter()
        
        if destYear == currentYear { //当年
            if destMonth == currentMonth { //当月
                if destDay == currentDay { //当天
                    dateFormatter.dateFormat = "HH:mm"
                    return dateFormatter.stringFromDate(desDate)
                } else {
                    if currentDay - destDay == 1 {
                        dateFormatter.dateFormat = "HH:mm"
                        return "昨天" + dateFormatter.stringFromDate(desDate)
                    } else if currentDay - destDay == 2 {
                        dateFormatter.dateFormat = "HH:mm"
                        return "前天" + dateFormatter.stringFromDate(desDate)
                    } else {
                        dateFormatter.dateFormat = "MM/dd"
                        return dateFormatter.stringFromDate(desDate)
                    }
                }
            } else {
                dateFormatter.dateFormat = "MM/dd"
                return dateFormatter.stringFromDate(desDate)
            }
        } else {
            dateFormatter.dateFormat = "yy/MM/dd"
            return dateFormatter.stringFromDate(desDate)
        }
    }
    
}
