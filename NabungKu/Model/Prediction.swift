//
//  Prediction.swift
//  NabungKu
//
//  Created by Michael on 13/02/26.
//

import Foundation
import SwiftData

@Model
class Prediction : Identifiable {
    var id: UUID
    var trendDirection: Double
    var lastAnalystDate : Date


    init( trendDirection: Double, lastAnalystDate: Date) {
        self.id = UUID()
        self.trendDirection = trendDirection
        self.lastAnalystDate = lastAnalystDate
    }
}
