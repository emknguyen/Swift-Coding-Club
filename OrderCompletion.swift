//
//  OrderCompletion.swift
//  AggieEats
//

import SwiftUI
import Stripe

struct OrderCompletion: View {
    @Binding var total: Decimal
    @State private var message: String = ""
    @State var paymentMethodParams: STPPaymentMethodParams?
    let paymentGatewayController = PaymentGatewayController()
    
    func pay() {
        // pay functionality, to submit the final payment to Stripe from user's credit card.
        guard let clientSecret = PaymentConfig.shared.paymentIntentClientSecret else {
            message = "No Client Secret"
            return
    }
        
        let paymentIntentParams = STPPaymentIntentParams(clientSecret: clientSecret)
        paymentIntentParams.paymentMethodParams = paymentMethodParams
        
        paymentGatewayController.submitPayment(intent:paymentIntentParams)
        {
            status, intent, error in
            print(error)
            
            switch status {
            case .failed:
                message = "Payment Failed"
            case .canceled:
                message = "Payment Cancelled"
            case .succeeded:
                message = "Payment Successful"
            }
        }
    }

    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Order Summary")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom)
            TotalView(total: $total) // from ConfirmOrderView.swift file
                .padding(.bottom)
            Section {
                // Stripe Credit Card TextField Here
                STPPaymentCardTextField.Representable.init(paymentMethodParams: $paymentMethodParams)
            } header: {
                Text("Payment Information")
            }
            
            Button {
                pay()
            } label: {
                Text("Place Your Order")
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .tint(.blue)
            .controlSize(.large)
            .padding(.bottom)
            
            Text(message)
                .font(.headline)
            
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .toolbar(.hidden, for: .tabBar)
    }
}

#Preview {
    OrderCompletion(total: .constant(1.00))
}
