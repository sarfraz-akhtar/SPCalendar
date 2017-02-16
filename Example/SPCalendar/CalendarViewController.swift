//
//  ViewController.swift
//  CVCalendar Demo
//
//  Created by Мак-ПК on 1/3/15.
//  Copyright (c) 2015 GameApp. All rights reserved.
//

import UIKit
import SPCalendar

struct SPConstants {
static let BRAND_COLOR = UIColor.colorFromCode(0x88b04b)
}


class CalendarViewController: UIViewController {
    var parentController: UIViewController!
    var weekStartDay: Int = 1
    var currentDate: Date = Date()
    fileprivate var presentedDate: Date = Date()
    var rangeSelection: Bool = false // false for daybutton and true for week button
    var appstartedFlag: Bool = false
    struct Color {
        static let selectedText = UIColor.red
        static let text = UIColor.black
        static let textDisabled = UIColor.gray
        static let selectionBackground = SPConstants.BRAND_COLOR
        static let sundayText = UIColor(red: 1.0, green: 0.2, blue: 0.2, alpha: 1.0)
        static let sundayTextDisabled = UIColor(red: 1.0, green: 0.6, blue: 0.6, alpha: 1.0)
        static let sundaySelectionBackground = sundayText
    }
    
    // MARK: - Properties
    @IBOutlet weak var calendarView: CVCalendarView!
    @IBOutlet weak var menuView: CVCalendarMenuView!
    @IBOutlet weak var dayButton: UIButton!
    @IBOutlet weak var weekButton: UIButton!
    @IBOutlet weak var monthLabel: UILabel!
    
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var animationFinished = true
    
    var selectedDay:DayView!
    
    var currentCalendar: Calendar?
    
    //Mark Week / Day Selection
    var startDate: Date = Date()
    var endDate: Date = Date()
    // MARK: - Life cycle
    required init?(coder aDecoder: NSCoder) {
        self.currentCalendar = Calendar(identifier: .gregorian)
        
        self.currentCalendar?.timeZone = TimeZone(identifier: "UTC")!
        
        super.init(coder: aDecoder)
        //        self.calendarView.calendarDate = self.currentDate
        self.presentedDate = self.currentDate
        
        
    }
    
    override func viewDidLoad() {
       
            self.monthLabel.text = Date.getDateString(self.currentDate, dateFormat: "MMMM yyyy")
            if self.rangeSelection {
               
                DispatchQueue.main.async {
                    self.segmentedControl.setEnabled(true, forSegmentAt: 1)
                    
                }

                
            }
            else {
                
                DispatchQueue.main.async {
                    self.segmentedControl.setEnabled(true, forSegmentAt: 0)
                }
            }
    
        
        self.selectedDay = self.dayViewWithDate(CVDate(date: self.currentDate, calendar: self.currentCalendar!), inMonthView: self.calendarView.contentController.presentedMonthView)
 
        super.viewDidLoad()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        calendarView.commitCalendarViewUpdate()
        menuView.commitMenuViewUpdate()
    }
    
}

// MARK: - CVCalendarViewDelegate & CVCalendarMenuViewDelegate

extension CalendarViewController: CVCalendarViewDelegate, CVCalendarMenuViewDelegate {
    
    /// Required method to implement!
    
    func calendarSelectedDate() -> Date {
        return self.currentDate
    }
    
    func presentationMode() -> CalendarMode {
        return .monthView
    }
    
    /// Required method to implement!
    func firstWeekday() -> Weekday {
        return Weekday(rawValue: self.weekStartDay)!
    }
    
    // MARK: Optional methods
    
    func calendar() -> Calendar? {
        
        return self.currentCalendar
    }
    
    func dayOfWeekTextColor(by weekday: Weekday) -> UIColor {
        return weekday == .sunday ? UIColor.red : UIColor.white
    }
    
    func shouldShowWeekdaysOut() -> Bool {
        return true
    }
    
    func shouldAnimateResizing() -> Bool {
        return true // Default value is true
    }
    
    
    func shouldAutoSelectDayOnMonthChange() -> Bool {
        return true
    }
    
    
    func didSelectDayView(_ dayView: CVCalendarDayView, animationDidFinish: Bool) {
        

        self.selectedDay = dayView
        
    }
    
    
    func didTouchDayView(_ dayView: CVCalendarDayView) {
        
        
                self.currentDate = dayView.date.convertedDate(calendar: self.currentCalendar!)!
                    if !rangeSelection {
                        self.startDate =   self.currentDate
                        self.endDate = self.currentDate
                    }

                    self.calendarViewDateHasChanged()
        

        self.selectedDay = dayView
        // send date to scheduleview controller to update data.
        
        
    }
    
    func shouldSelectRange() -> Bool {
        return rangeSelection
    }
    
    func didSelectRange(from startDayView: DayView, to endDayView: DayView) {
        print("RANGE SELECTED: \(startDayView.date.commonDescription) to \(endDayView.date.commonDescription)")
        self.startDate =   startDayView.date.convertedDate(calendar: self.currentCalendar!)!
        self.endDate = endDayView.date.convertedDate(calendar: self.currentCalendar!)!
    }
    
    func presentedDateUpdated(_ date: CVDate) {
        
        self.presentedDate = date.convertedDate(calendar: self.currentCalendar!)!
    }
    
    func topMarker(shouldDisplayOnDayView dayView: CVCalendarDayView) -> Bool {
        return false
    }
    
    
    func weekdaySymbolType() -> WeekdaySymbolType {
        return .veryShort
    }
   

    func shouldShowCustomSingleSelection() -> Bool {
        return rangeSelection
    }
    
    func dayOfWeekTextColor() -> UIColor {
        return UIColor.white
    }
    
    func dayOfWeekBackGroundColor() -> UIColor {
        return SPConstants.BRAND_COLOR
    }
    
    
    //    func disableScrollingBeforeDate() -> Date {
    //        return Date()
    //    }
    
    func maxSelectableRange() -> Int {
        return 7
    }
    
    
    
    func didShowNextMonthView(_ date: Date) {
        self.monthLabel.text = Date.getDateString(date, dateFormat: "MMMM yyyy")
    }
    
    func didShowPreviousMonthView(_ date: Date) {
        self.monthLabel.text = Date.getDateString(date, dateFormat: "MMMM yyyy")
    }
    
    
    
    func shouldScrollOnOutDayViewSelection() -> Bool {
        //        self.monthLabel.text = Date.getDateString(self.currentScrollDate, dateFormat: "MMMM yyyy")
        return false
    }
    
    
    
    
}


// MARK: - CVCalendarViewAppearanceDelegate

extension CalendarViewController: CVCalendarViewAppearanceDelegate {
    
    func dayLabelWeekdayDisabledColor() -> UIColor {
        return UIColor.lightGray
    }
    func dayLabelWeekdayHighlightedBackgroundColor() -> UIColor {
        return SPConstants.BRAND_COLOR
    }
    func dayLabelPresentWeekdaySelectedBackgroundColor() -> UIColor {
        return SPConstants.BRAND_COLOR
    }
    func dayLabelPresentWeekdayInitallyBold() -> Bool {
        return false
    }
    
    func spaceBetweenDayViews() -> CGFloat {
        return 0
    }
    
//    func dayLabelFont(by weekDay: Weekday, status: CVStatus, present: CVPresent) -> UIFont { return SPConstants.Font.Regular! }
    
    func dayLabelColor(by weekDay: Weekday, status: CVStatus, present: CVPresent) -> UIColor? {
        switch (weekDay, status, present) {
        case (_, .selected, _), (_, .highlighted, _): return Color.selectedText
        case (.sunday, .in, _): return Color.sundayText
        case (.sunday, _, _): return Color.sundayTextDisabled
        case (_, .in, _): return Color.text
        default: return Color.textDisabled
        }
    }
    
    func dayLabelBackgroundColor(by weekDay: Weekday, status: CVStatus, present: CVPresent) -> UIColor? {
        switch (weekDay, status, present) {
        case (.sunday, .selected, _), (.sunday, .highlighted, _): return Color.sundaySelectionBackground
        case (_, .selected, _), (_, .highlighted, _): return Color.selectionBackground
        default: return nil
        }
    }
}

// MARK: - IB Actions

extension CalendarViewController {
    
    @IBAction func todayMonthView() {
        self.currentDate = Date()
        self.monthLabel.text = Date.getDateString(self.currentDate, dateFormat: "MMMM yyyy")
        if !rangeSelection {
            self.calendarView.toggleViewWithDate(self.currentDate)
            self.startDate = self.currentDate
            self.endDate = self.currentDate
        }
        else {
             self.calendarView.toggleTodayMonth(self.currentDate)
//            calendarView.contentController.presentedMonthView = todayMonth
            self.selectedDay = self.dayViewWithDate(CVDate(date: self.currentDate, calendar: currentCalendar!),  inMonthView: calendarView.contentController.presentedMonthView)
//
            self.performedWeekSelection()
            self.startDate = Date.getWeekStartDate(self.currentDate, weekStartDay: self.weekStartDay - 1)
            self.endDate = Date.getWeekEndDate(self.startDate)
        }
//        self.calendarViewDateHasChanged()
        
    }
    
    
    
}

// MARK: - Convenience API Demo



//Mark: Conveniece SPCalendar API
extension CalendarViewController {
    
    
    @IBAction func segmentedControlTap(sender: UISegmentedControl) {
        if segmentedControl.selectedSegmentIndex == 0 {
        self.rangeSelection = false
//            self.currentDate = self.presentedDate
//            self.selectedDay = self.dayViewWithDate(CVDate(date: self.currentDate, calendar: currentCalendar!),  inMonthView: self.calendarView.contentController.presentedMonthView)
//            self.calendarView.coordinator.selectedDayView = self.selectedDay
            
            // enable functionality
            self.clearSelection(in: self.calendarView.contentController.presentedMonthView)
            //                    self.calendarView.coordinator.t
            self.calendarView.toggleViewWithDate(self.currentDate)
            self.monthLabel.text = Date.getDateString(self.currentDate, dateFormat: "MMMM yyyy")
            self.startDate = self.currentDate
            self.endDate = self.currentDate
            self.calendarViewDateHasChanged()
            
        }
        else if segmentedControl.selectedSegmentIndex == 1 {
            self.rangeSelection = true
                self.performedWeekSelection()
                
                self.calendarViewDateHasChanged()
        }
    
    
    }
    
    
    
    
    
    
    
    
//    @IBAction func enableDaySelection(sender: UIButton){
//        self.rangeSelection = false
//        if !sender.isSelected {
//            self.currentDate = self.presentedDate
//            self.selectedDay = self.dayViewWithDate(CVDate(date: self.currentDate, calendar: currentCalendar!),  inMonthView: self.calendarView.contentController.presentedMonthView)
//            self.calendarView.coordinator.selectedDayView = self.selectedDay
//            
//            // appearance
//            sender.backgroundColor = SPConstants.BRAND_COLOR
//            sender.titleLabel?.textColor = UIColor.white
//            sender.isSelected = true
//            weekButton.backgroundColor = UIColor.white
//            weekButton.titleLabel?.textColor = UIColor.black
//            weekButton.isSelected = false
//            
//            // enable functionality
//                self.clearSelection(in: self.calendarView.contentController.presentedMonthView)
//                self.startDate = self.currentDate
//                self.endDate = self.currentDate
//                self.calendarViewDateHasChanged()
//        }
//    }
//    @IBAction func enableWeekSelection(sender: UIButton) {
//        self.rangeSelection = true
//        if !sender.isSelected {
//            
//            // appearance
//            sender.backgroundColor = SPConstants.BRAND_COLOR
//            sender.titleLabel?.textColor = UIColor.white
//            sender.isSelected = true
//            
//            dayButton.isSelected = false
//            dayButton.backgroundColor = UIColor.white
//            dayButton.titleLabel?.textColor = UIColor.black
//            
//            
//            self.performedWeekSelection()
//            
//            self.calendarViewDateHasChanged()
//            
//        }
//    }
    
    
    fileprivate func performedWeekSelection() {
//        let dayView =   self.dayViewWithDate(CVDate(date: self.currentDate, calendar: currentCalendar!),  inMonthView: self.calendarView.contentController.presentedMonthView)
        self.currentDate = self.selectedDay.date.convertedDate(calendar: self.currentCalendar!)!
        self.performedWeekSelection(dayView: self.selectedDay)
    }
    
    fileprivate func performedWeekSelection(dayView: CVCalendarDayView) {
       var currentWeek: CVCalendarWeekView?
        if dayView.weekView == nil {
            
        self.selectedDay = self.dayViewWithDate(CVDate(date: self.currentDate, calendar: self.currentCalendar!), inMonthView: self.calendarView.contentController.presentedMonthView)
            currentWeek = self.selectedDay.weekView
        }
        else {
            
        currentWeek = dayView.weekView
            
        }
//       let currentWeek: CVCalendarWeekView = dayView.weekView
        let startDayView: CVCalendarDayView = currentWeek!.dayViews.first!
        let endDayView: CVCalendarDayView = currentWeek!.dayViews.last!
        dayView.setDeselectedWithClearing(true)
        self.calendarView.coordinator.flush()
        
        self.calendarView.coordinator.performDayViewRangeSelection(startDayView)
        
        self.calendarView.coordinator.performDayViewRangeSelection(endDayView)
        
        self.startDate = startDayView.date.convertedDate(calendar: self.currentCalendar!)!
        self.endDate = endDayView.date.convertedDate(calendar: self.currentCalendar!)!
    }
    func clearSelection(in monthView: MonthView) {
        self.calendarView.coordinator.flush()
        monthView.mapDayViews { dayView in
//            if dayView != self.selectedDay{
                self.calendarView.coordinator.deselectionPerformedOnDayView(dayView)
//            }
        }
    }
    
    
    
    func dayViewWithDate(_ date: CVDate, inMonthView monthView: CVCalendarMonthView) -> CVCalendarDayView{
        
        monthView.mapDayViews { dayView in
            if dayView.date.day == date.day && dayView.date.month == date.month {
                
                self.selectedDay = dayView as CVCalendarDayView
            }
        }
        return self.selectedDay
    }
    
    fileprivate func calendarViewDateHasChanged() {
        
        (self.parentController as! ViewController).calendarViewDateHasChanged(calendarDate: self.currentDate, startDate: self.startDate, endDate: self.endDate)
//        self.dismiss(animated: true, completion: nil)
        
    }
    
    
}
