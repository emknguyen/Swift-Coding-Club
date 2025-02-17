//
//  AggieEatsApp.swift
//  AggieEats
//

import SwiftUI
import Stripe

@main
struct AggieEatsApp: App {
    init() {
        StripeAPI.defaultPublishableKey = "pk_test_51Qr7bZFA9KB8Kci61bVbztLJId9gphSlTqSJA7c7Yy1WAZo1CWHiN7LdjJUTgvUIMiZQzwA9eZRS1aphXBzpDWUz00CH22vM57"
    }
    
    var body: some Scene {
        WindowGroup {
            TabBarView()
        }
    }
}
