//
//  ContentView.swift
//  ConversionApp
//
//  Created by Danis Harmandic on 14.09.2023..
//

import SwiftUI

struct ContentView: View {
    @State private var amount = 100.0
    @State private var inputUnit = UnitLength.meters
    @State private var outputUnit = UnitLength.kilometers
    @FocusState private var keyboardIsFocused: Bool
    
    let units = [UnitLength.feet,UnitLength.yards, UnitLength.miles, UnitLength.millimeters, UnitLength.centimeters, UnitLength.meters, UnitLength.kilometers]
    let formatter: MeasurementFormatter
    
    var result: String {
        let inputMeasurement = Measurement(value: amount, unit: inputUnit)
        let  outputMeasurement = inputMeasurement.converted(to: outputUnit)
        
        return formatter.string(from: outputMeasurement)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Amount", value: $amount, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($keyboardIsFocused)
                } header: {
                    Text("Amount to convert")
                }
                
                Section {
                    Picker("Convert from", selection: $inputUnit) {
                        ForEach(units, id: \.self) {
                            Text(formatter.string(from: $0))
                        }
                    }
                    .pickerStyle(.automatic)
                }
                
                Section {
                    Picker("Convert to", selection: $outputUnit) {
                        ForEach(units, id: \.self) {
                            Text(formatter.string(from: $0))
                        }
                    }
                    .pickerStyle(.automatic)
                }
                
                Section {
                    Text(result)
                } header: {
                    Text("Result")
                }
            }
            .navigationTitle("ConverterApp")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        keyboardIsFocused = false
                    }
                }
            }
        }
    }
    
    init() {
        formatter = MeasurementFormatter()
        formatter.unitOptions = .providedUnit
        formatter.unitStyle = .long
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
