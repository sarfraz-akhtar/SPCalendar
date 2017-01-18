import Foundation
extension Date {
    func ToDateMediumString() -> NSString? {
        let formatter = DateFormatter()
        formatter.dateStyle = .long;
        formatter.timeStyle = .none;
        formatter.timeZone = TimeZone(identifier: "UTC")
        return (formatter.string(from: self)).uppercased() as NSString?
    }
    
    static func isGreaterThanDate(_ date: Date, toDate: Date) -> Bool {
        // Declare Variables
        var isGreater = false
        
        // Compare Values
        if (Calendar.current as NSCalendar).compare(date, to: toDate, toUnitGranularity: .day) == .orderedDescending {
            isGreater = true
            
        }
        
        // Return Result
        return isGreater
    }
    
    static func isLessThanDate(_ date: Date, toDate: Date) -> Bool {
        // Declare Variables
        var isLess = false
        
        // Compare Values
        if (Calendar.current as NSCalendar).compare(date, to: toDate, toUnitGranularity: .day) == .orderedAscending {
            isLess = true
        }
        
        // Return Result
        return isLess
    }
    
    static func isEqualToDate(_ date: Date, toDate: Date) -> Bool {
        // Declare Variables
        var isEqualTo = false
        
        // Compare Values
        if (Calendar.current as NSCalendar).compare(date, to: toDate, toUnitGranularity: .day) == .orderedSame {
            isEqualTo = true
        }
        
        // Return Result
        return isEqualTo
    }
    
    
    static func isGreaterThanDateTime(_ date: Date, toDate: Date) -> Bool {
        // Declare Variables
        var isGreater = false
        
        // Compare Values
        if date.compare(toDate) == .orderedDescending {
            isGreater = true
            
        }
        
        // Return Result
        return isGreater
    }
    
    static func isLessThanDateTime(_ date: Date, toDate: Date) -> Bool {
        // Declare Variables
        var isLess = false
        
        // Compare Values
        if date.compare(toDate) == .orderedAscending {
            isLess = true
        }
        
        // Return Result
        return isLess
    }
    static func isEqualToDateTime(_ date: Date, toDate: Date) -> Bool {
        // Declare Variables
        var isEqualTo = false
        
        // Compare Values
        
        if date.compare(toDate) == .orderedSame {
            isEqualTo = true
        }
        
        // Return Result
        return isEqualTo
    }
    
    //	static let dateFormatter = NSDateFormatter()
    /***
     // Week Days
     0 - Sunday
     1 - Monday
     2 - Tuesday
     3 - Wedensday
     4 - Thursday
     5 - Friday
     6 - Saturday
     ****/
    static func getDayOfWeek(_ todayDate: Date) -> Int {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(identifier: "UTC")!
        let myComponents = (calendar as NSCalendar).components(.weekday, from: todayDate)
        let weekDay = myComponents.weekday
        return (weekDay! - 1)
    }
    
    // return date before or after from current date.
    static func getdateByAddingUnit(_ today: Date, noOfdays: Int) -> Date {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(identifier: "UTC")!
        
        return (calendar as NSCalendar).date(byAdding: NSCalendar.Unit.day, value: noOfdays, to: today, options: [])!
    }
    
    static func getdateFromISOString(_ date: String) -> Date {
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        return dateFormatter.date(from: date)!
    }
    
    static func getISOStringFromDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return dateFormatter.string(from: date)
    }
    
    static func getDateTimeFromString(_ date: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.date(from: date)!
    }
    static func getDateFromString(_ date: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: date)!
    }
    static func getDateString(_ date: Date, dateFormat: String = "yyyy-MM-dd") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: date)
    }
    
    static func getDateFromTimeAMPMString(_ time: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        dateFormatter.timeStyle = .short
        return dateFormatter.date(from: time)!
    }
    
    static func __getDateFromTimeAMPMString(_ time: String) throws -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        dateFormatter.timeStyle = .short
        return dateFormatter.date(from: time)!
    }
    static func getTimeAMPM(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: date)
        
    }
    
    static func getTime24Hours(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        dateFormatter.dateFormat = "HH:mm:ss"
        return dateFormatter.string(from: date)
        
    }
    static func getWeekEndDate(_ weekStartDate: Date) -> Date {
        return getdateByAddingUnit(weekStartDate, noOfdays: 6)
    }
    
    static func getWeekStartDate(_ today: Date, weekStartDay: Int) -> Date {
        let weekDay: Int = Date.getDayOfWeek(today)
        var noOfdays: Int?
        if weekDay < weekStartDay {
            noOfdays = weekStartDay - (7 + weekDay)
        }
        else {
            noOfdays = weekStartDay - weekDay
        }
        return Date.getdateByAddingUnit(today, noOfdays: noOfdays!)
    }
    
    // This function counts number of leap years before the
    // given date
    static func countLeapYears(_ d: Date) -> Int
    {
        
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(identifier: "UTC")!
        var years = (calendar as NSCalendar).component(.year, from: d)
        
        // Check if the current year needs to be considered
        // for the count of leap years or not
        if ((calendar as NSCalendar).component(.month, from: d) <= 2) {
            years -= 1
        }
        
        // An year is a leap year if it is a multiple of 4,
        // multiple of 400 and not a multiple of 100.
        return years / 4 - years / 100 + years / 400;
    }
    
    static func daysBetweenDates(_ dt1: Date, dt2: Date) -> Int
    {
        var calendar = Calendar.current
        let monthDays: Array <Int> = Array <Int>(arrayLiteral: 31, 28, 31, 30, 31, 30,
                                                 31, 31, 30, 31, 30, 31)
        calendar.timeZone = TimeZone(identifier: "UTC")!
        
        // COUNT TOTAL NUMBER OF DAYS BEFORE FIRST DATE 'dt1'
        
        // initialize count using years and day
        var n1: Int = (calendar as NSCalendar).component(.year, from: dt1) * 365 + (calendar as NSCalendar).component(.day, from: dt1)
        
        // Add days for months in given date
        for i: Int in 0 ..< (calendar as NSCalendar).component(.month, from: dt1) - 1 {
            n1 += monthDays[i];
        }
        
        // Since every leap year is of 366 days,
        // Add a day for every leap year
        n1 += countLeapYears(dt1);
        
        // SIMILARLY, COUNT TOTAL NUMBER OF DAYS BEFORE 'dt2'
        
        var n2: Int = (calendar as NSCalendar).component(.year, from: dt2) * 365 + (calendar as NSCalendar).component(.day, from: dt2)
        for i: Int in 0 ..< (calendar as NSCalendar).component(.month, from: dt2) - 1 {
            n2 += monthDays[i]
        }
        
        n2 += countLeapYears(dt2)
        
        var noOfDays = n2 - n1
        if noOfDays <= 0 {
            noOfDays = 0
        }
        
        // return difference between two counts
        return noOfDays
    }
    
    static func timeDiff(_ time1: Date, time2: Date) -> Float {
        
        var calendar: Calendar = Calendar.current
        calendar.timeZone = TimeZone(identifier: "UTC")!
        let hours = (calendar as NSCalendar).components(.hour, from: time1, to: time2, options: []).hour
        return Float(abs(hours!))
    }
    
}
