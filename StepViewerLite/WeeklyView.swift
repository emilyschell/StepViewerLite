//
//  ContentView.swift
//  StepViewerLite
//
//  Created by Emily Schell on 1/12/24.
//

import SwiftUI
import Charts

struct WeeklyView: View {
    @ObservedObject private var viewModel = WeeklyViewModel()

    var body: some View {
        NavigationView {
            NavigationStack {
                HStack {
                    Text("This week's steps")
                        .font(.title)
                    Image(systemName: "figure.walk")
                        .font(.title)
                    Spacer()
                }
                .padding()

                List {
                    Chart(viewModel.stepsData) {
                        BarMark(
                            x: .value("Date", $0.date?.formatted(.dateTime.weekday(.abbreviated)) ?? ""),
                            y: .value("Steps", $0.numberOfSteps)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                    }
                    .chartXScale(
                        domain: .automatic(includesZero: false, reversed: true)
                    )
                    .scaledToFit()
                    .padding()
                    ForEach(Array(viewModel.stepsData.enumerated()), id: \.element.date) { (index, dailyData) in
                        NavigationLink {
                            DetailView(stepsData: viewModel.stepsData, selectedIndex: index)
                        } label: {
                            HStack {
                                Text(dailyData.date ?? Date(), format: .dateTime.weekday())
                                    .font(.headline)
                                Spacer()
                                Text(dailyData.numberOfSteps, format: .number)
                                    .font(.title2)
                                    .padding(.trailing)
                            }
                            .padding()
                        }
                    }
                }

            }
        }
        .onAppear() {
            viewModel.getSteps()
        }
        .alert(isPresented: $viewModel.usingDemoData) {
                    Alert(title: Text("Cannot get steps data from device."), message: Text("Using demo data."), dismissButton: .default(Text("Okay!")))
                }
    }
}

#Preview {
    WeeklyView()
}
