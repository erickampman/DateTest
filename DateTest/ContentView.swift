//
//  ContentView.swift
//  DateTest
//
//  Created by Eric Kampman on 8/16/24.
//

import StoreKit
import SwiftUI

struct ContentView: View {
	@State private var dateManager = DateManager()
	@State private var count = 0
	@Environment(\.requestReview) private var requestReview

    var body: some View {
        VStack {
			Text("Last Review: \(dateManager.lastReview)")
			Text("Now: \(DateManager.makeNowString())")
			Text("Compare to Now: \(dateManager.compareDateString(Date.now))")
			Button("Update") {
				count += 1
			}
			Text("Count: \(count)")
        }
        .padding()
		.onChange(of: count) {
			if dateManager.needReview {
				presentReview()
			}
		}
    }
	
	private func presentReview() {
		Task {
			// Delay for two seconds to avoid interrupting the person using the app.
			try await Task.sleep(for: .seconds(2))
			await requestReview()
		}
	}
}

#Preview {
    ContentView()
}
