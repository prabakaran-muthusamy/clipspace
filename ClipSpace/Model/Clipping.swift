//
//  Clipping.swift
//  ClipSpace
//
//  Created by Prabakaran Muthusamy on 19/12/25.
//

/// Core/Models/Clipping.swift

import Foundation

struct Clipping: Identifiable, Codable, Equatable, Hashable {
    let id: UUID
    var content: String
    var richRTF: Data?
    var sourceAppBundleID: String?
    let createdAt: Date
    var isPinned: Bool
    
    init(id: UUID = UUID(), content: String, richRTF: Data? = nil, sourceAppBundleID: String? = nil, createdAt: Date = Date(), isPinned: Bool = false) {
        self.id = id
        self.content = content
        self.richRTF = richRTF
        self.sourceAppBundleID = sourceAppBundleID
        self.createdAt = createdAt
        self.isPinned = isPinned
    }
}
