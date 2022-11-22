//
//  ContentView.swift
//  WeSplit
//
//  Created by N N on 21/11/2022.
//

import SwiftUI

struct ContentView: View {
    // SwiftUI’s @State property wrapper lets us modify our view structs freely, which means as our program changes we can update our view properties to match.
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    // Property wrapper designed to handle input focus in our UI
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [0, 10, 15, 20, 25]
    
    var totalPerPerson: Double {
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
                    TextField("Amount", value: $checkAmount, format: .currency(code: "EUR"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                } header: {
                    Text("Check amount")
                        .foregroundColor(.gray)
                }
                
                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented )
                } header: {
                    Text("How much tip do you want to leave?")
                        .foregroundColor(.gray)
                }
                
                Section {
                    Text(totalPerPerson, format: .currency(code: "EUR"))
                        .keyboardType(.decimalPad)
                } header: {
                    Text("Amount per person")
                        .foregroundColor(.gray)
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
            .toolbarColorScheme(.light, for: .navigationBar)
//            .toolbarBackground(
//                Color.pink,
//                for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .scrollContentBackground(.hidden)
            .background(Image("icecream")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea())
//            .background(
//                LinearGradient(gradient: Gradient(colors: [.purple, .yellow, .purple]), startPoint: .topLeading, endPoint: .bottomTrailing))
        }
        .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
