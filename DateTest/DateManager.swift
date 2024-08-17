//
//  DateManager.swift
//  DateTest
//
//  Created by Eric Kampman on 8/16/24.
//

import Foundation
import SwiftUI


class DateManager {
	@AppStorage("lastReview") var lastReview = ""
	@AppStorage("reviewCount") var reviewCount = 0
	let reviewDeltaSeconds = TimeInterval(60 * 1)  // one minute
	
	init() {
		if lastReview.isEmpty {
			lastReview = DateManager.makeNowString()
		}
	}
	
	var lastReviewDate: Date {
		let formatter = DateFormatter()
		formatter.dateStyle = .short
		formatter.timeStyle = .short
		let ret = formatter.date(from: lastReview)!
		return ret
	}
	
	var needReview: Bool {
		let goal = lastReviewDate + reviewDeltaSeconds
		print("Goal \(DateManager.makeDateString(goal))")
		print("Now \(DateManager.makeNowString())")
		return goal > Date.now
	}
	
	func updateLastReview() {
		lastReview = DateManager.makeNowString()
		reviewCount += 1
	}
	
	static func makeNowString() -> String {
		return makeDateString(Date.now)
	}
	
	static func makeDateString(_ date: Date) -> String {
		let formatter = DateFormatter()
		formatter.dateStyle = .short
		formatter.timeStyle = .short
		return formatter.string(from: date)
	}
	
	func compareDateString(_ date: Date) -> String {
		if date == lastReviewDate {
			return "=="
		} else if date < lastReviewDate {
			return "<"
		} else {
			return ">"
		}
	}
}
