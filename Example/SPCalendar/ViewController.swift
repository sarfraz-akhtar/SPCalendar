//
//  ViewController.swift
//  SPCalendar
//
//  Created by SPCalendar on 01/17/2017.
//  Copyright (c) 2017 SPCalendar. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    var calendarDate: Date = Date.getDateFromString("2016-07-07")
    var weekStartDate: Date = Date.getDateFromString("2016-07-07")
    var weekEndDate: Date = Date.getDateFromString("2016-07-07")
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }

    func calendarViewDateHasChanged(calendarDate: Date, startDate: Date, endDate: Date) {
        
        self.calendarDate = calendarDate
        self.weekStartDate = startDate
        self.weekEndDate = endDate
        
    }
    
    @IBAction func calendarIconWasTap(_ sender: UIButton) {
        DispatchQueue.main.async(execute: {
            
            let storyboard = UIStoryboard(name: "Calendar", bundle: nil)
            let popoverViewController = storyboard.instantiateInitialViewController() as? CalendarViewController
            popoverViewController?.parentController = self
            popoverViewController?.weekStartDay = 1
            //            SPCalendar.calendarDate = self.calendarDate!
            popoverViewController?.currentDate = self.calendarDate
            if Date.isEqualToDate(self.weekStartDate, toDate: self.weekEndDate) {
                popoverViewController?.rangeSelection = false
            }
            else{
                popoverViewController?.rangeSelection = true
            }
            popoverViewController?.modalPresentationStyle = UIModalPresentationStyle.popover
            popoverViewController?.preferredContentSize = CGSize(width: 300, height: 400)
            popoverViewController?.popoverPresentationController?.delegate = self
            popoverViewController?.popoverPresentationController?.sourceView = sender
            popoverViewController?.popoverPresentationController?.sourceRect = CGRect(x: (sender.bounds.size.width) / 2, y: (sender.bounds.size.height), width: 0, height: 0)
            popoverViewController?.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.up
            self.present(popoverViewController!, animated: true, completion: nil)
        })
        
    }
    
    open func adaptivePresentationStyle(
        for controller: UIPresentationController,
        traitCollection: UITraitCollection)
        -> UIModalPresentationStyle {
            return .none
    }

}

