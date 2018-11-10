//
//  CalendarViewController.swift
//  Sirius
//
//  Created by Максим Атюцкий on 10/11/2018.
//  Copyright © 2018 Atyutskiy. All rights reserved.
//

import UIKit
import VACalendar

class CalendarViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var weekDaysView: VAWeekDaysView! {
        didSet {
            let appereance = VAWeekDaysViewAppearance(symbolsType: .veryShort, calendar: defaultCalendar)
            weekDaysView.appearance = appereance
        }
    }
    
    // MARK: - Vars
    
    let defaultCalendar: Calendar = {
        var calendar = Calendar.current
        calendar.firstWeekday = 2
        calendar.timeZone = TimeZone(secondsFromGMT: 0)!
        calendar.locale = Locale(identifier: Locale.preferredLanguages.first!)
        return calendar
    }()
    
    var calendarView: VACalendarView!
    
    var events: [Event] = []
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let calendar = VACalendar(calendar: defaultCalendar)
        calendarView = VACalendarView(frame: .zero, calendar: calendar)
        calendarView.showDaysOut = true
        calendarView.selectionStyle = .single
        calendarView.dayViewAppearanceDelegate = self
        calendarView.monthViewAppearanceDelegate = self
        calendarView.calendarDelegate = self
        calendarView.scrollDirection = .vertical
        
        APIServer.shared.getEvents(vkId: Int(Base.shared.userId!)!) { (events, error) in
            self.events = events ?? []
            var supplementaries: [(Date, [VADaySupplementary])] = []
            for event in events ?? [] {
                let startTime = event.startDatetime
                let endTime = event.endDatetime
                
                if startTime == nil || endTime == nil {
                    continue
                }
                
                supplementaries.append((startTime!, [VADaySupplementary.bottomDots([.red])]))
                supplementaries.append((endTime!, [VADaySupplementary.bottomDots([.red])]))
                var i = 1
                while startTime!.addingTimeInterval(TimeInterval(60*60*24*i)) <= endTime! {
                    supplementaries.append((startTime!.addingTimeInterval(TimeInterval(60*60*24*i)), [VADaySupplementary.bottomDots([.red])]))
                    i += 1
                }
            }
            self.calendarView.setSupplementaries(supplementaries)
        }
    
        view.addSubview(calendarView)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        if calendarView.frame == .zero {
            calendarView.frame = CGRect(
                x: 0,
                y: weekDaysView.frame.maxY,
                width: view.frame.width,
                height: view.frame.height
            )
            calendarView.setup()
        }
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "toMyEvent" {
            if let destination = segue.destination as? MyEventViewController {
                destination.event = (sender as! Event)
            }
        }
    }

}

extension CalendarViewController: VAMonthHeaderViewDelegate {
    
    func didTapNextMonth() {
        calendarView.nextMonth()
    }
    
    func didTapPreviousMonth() {
        calendarView.previousMonth()
    }
    
}

extension CalendarViewController: VAMonthViewAppearanceDelegate {
    
    func leftInset() -> CGFloat {
        return 10.0
    }
    
    func rightInset() -> CGFloat {
        return 10.0
    }
    
    func verticalMonthTitleFont() -> UIFont {
        return UIFont.systemFont(ofSize: 16, weight: .semibold)
    }
    
    func verticalMonthTitleColor() -> UIColor {
        return .black
    }
    
    func verticalCurrentMonthTitleColor() -> UIColor {
        return .red
    }
    
}

extension CalendarViewController: VADayViewAppearanceDelegate {
    
    func textColor(for state: VADayState) -> UIColor {
        switch state {
        case .out:
            return UIColor(red: 214 / 255, green: 214 / 255, blue: 219 / 255, alpha: 1.0)
        case .selected:
            return .white
        case .unavailable:
            return .lightGray
        default:
            return .black
        }
    }
    
    func textBackgroundColor(for state: VADayState) -> UIColor {
        switch state {
        case .selected:
            return .red
        default:
            return .clear
        }
    }
    
    func shape() -> VADayShape {
        return .circle
    }
    
    func dotBottomVerticalOffset(for state: VADayState) -> CGFloat {
        switch state {
        case .selected:
            return 2
        default:
            return -7
        }
    }
    
}

extension CalendarViewController: VACalendarViewDelegate {
    
    func selectedDates(_ dates: [Date]) {
        calendarView.startDate = dates.last ?? Date()
        if let date = dates.first {
            for event in events {
                if date.addingTimeInterval(60*60*23) >= event.startDatetime! && date <= event.endDatetime! {
                    self.performSegue(withIdentifier: "toMyEvent", sender: event)
                    return
                }
            }
        }
    }
    
}
