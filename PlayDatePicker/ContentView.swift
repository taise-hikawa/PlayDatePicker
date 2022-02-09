//
//  ContentView.swift
//  PlayDatePicker
//
//  Created by 樋川大聖 on 2022/02/08.
//

import SwiftUI

struct ContentView: View {

    @ObservedObject private var viewModel = ContentViewModel()

    private var startDateSelectButton: some View {
        let label: String
        if let startDate = viewModel.startDate {
            label = viewModel.dateFormatter.string(from: startDate)
        } else {
            label = "開始日を選択"
        }
        return Button(action: {
            withAnimation { viewModel.selectiongDate = .show($viewModel.startDate) }
        }, label: {
            HStack {
                Spacer()
                Text(label)
                Spacer()
            }
            .padding()
        })
    }

    private var endDateSelectButton: some View {
        let label: String
        if let endDate = viewModel.endDate {
            label = viewModel.dateFormatter.string(from: endDate)
        } else {
            label = "終了日を選択"
        }
        return Button(action: {
            withAnimation { viewModel.selectiongDate = .show($viewModel.endDate) }
        }, label: {
            HStack {
                Spacer()
                Text(label)
                Spacer()
            }
            .padding()
        })
    }

    var body: some View {
        ZStack {
            VStack(spacing: 32) {
                startDateSelectButton
                endDateSelectButton
            }
            if case let .show(date) = viewModel.selectiongDate {
                SelectDateView(presented: $viewModel.presentingSelectView, date: date)
            }
        }
        .buttonStyle(.bordered)
        .padding()
    }

}

struct ContentView_Preview: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .previewDisplayName("未選択")
        }
        .previewLayout(.fixed(width: 400, height: 200))
    }
}

struct SelectDateView: View {

    @Binding var presented: Bool
    @Binding var date: Date?

    var body: some View {
            DatePicker("", selection: $date ?? Date(), displayedComponents: .date)
                .datePickerStyle(.graphical)
                .onChange(of: date) { date in
                    presented = false
                }
                .background(Color.white)
    }
}

func ??<T>(lhs: Binding<Optional<T>>, rhs: T) -> Binding<T> {
    Binding(
        get: { lhs.wrappedValue ?? rhs },
        set: { lhs.wrappedValue = $0 }
    )
}
