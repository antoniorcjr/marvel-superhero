//
//  EventsViewModel.swift
//  marvel-superhero
//
//  Created by Antonio de Carvalho Jr on 10/06/18.
//  Copyright © 2018 Antonio R de Carvalho Jr. All rights reserved.
//

import Foundation

struct EventsViewModel {
    var events: [Participation]

    // Mark: - Computed properties
    var sections: Int {
        return 1
    }

    var rows: Int {
        return events.count
    }

    func event(for index: Int) -> Participation {
        return events[index]
    }
}
