//
//  ContentViewModel.swift
//  PlayDatePicker
//
//  Created by 樋川大聖 on 2022/02/08.
//

import Combine
import SwiftUI

class ContentViewModel: ObservableObject {
    @Published var startDate: Date?
    @Published var endDate: Date?
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .none
        dateFormatter.dateStyle = .medium
        dateFormatter.locale = Locale(identifier: "ja_JP")
        return dateFormatter
    }()

    @Published var selectiongDate: SelectingDate = .none

    enum SelectingDate: Equatable {
        static func == (lhs: SelectingDate, rhs: SelectingDate) -> Bool {
            switch (lhs, rhs) {
            case (.show, .show): return true
            case (.none, .none): return true
            default: return false
            }
        }

        case show(Binding<Date?>)
        case none
    }

    var presentingSelectView: Bool {
        get { selectiongDate != .none }
        set {
            guard !newValue else {
                assert(selectiongDate != .none, "the menu to be shown needs to be explicitly set!")
                return
            }
            selectiongDate = .none
        }
    }
}
