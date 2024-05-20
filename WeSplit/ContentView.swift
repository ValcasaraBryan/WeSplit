//
//  ContentView.swift
//  WeSplit
//
//  Created by valcasara-bryan on 15/05/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocus: Bool

    let tipPercentages = [10, 15, 20, 25, 0]
    var total: Double {
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        return checkAmount + tipValue
    }
    var totalPerPerson: Double {
        // calculate the total per person here
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocus)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                Section("How much do you want to tip?") {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0...100, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                Section("Amount total") {
                    Text(total, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .foregroundColor(tipPercentage == 0 ? .red : .primary)
                }
                Section("Amount per person") {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if amountIsFocus {
                    Button("Done") {
                        amountIsFocus = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
