//
//  ClippingFileStore.swift
//  ClipSpace
//
//  Created by Prabakaran Muthusamy on 19/12/25.
//

/// Data/Persistence/ClippingFileStore.swift

import Foundation

final class ClippingFileStore: ClippingStoreProtocol {
    private let url: URL
    private var cache: [Clipping] = []
    private let queue = DispatchQueue(label: "ClipSpace.ClippingFileStore")

    init(filename: String = "clippings.json") {
        let dir = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
        let appDir = dir.appendingPathComponent("ClipSpace", isDirectory: true)
        try? FileManager.default.createDirectory(at: appDir, withIntermediateDirectories: true)
        url = appDir.appendingPathComponent(filename)
        cache = (try? loadFromDisk()) ?? []
    }

    func add(_ clipping: Clipping) {
        cache.insert(clipping, at: 0)
        saveToDisk()
    }

    func update(_ clipping: Clipping) { queue.sync {
        if let idx = cache.firstIndex(where: { $0.id == clipping.id }) {
            cache[idx] = clipping
            saveToDisk()
        }
    }}

    func delete(id: UUID) { queue.sync {
        cache.removeAll { $0.id == id }
        saveToDisk()
    }}

    func deleteAll() { queue.sync {
        cache.removeAll()
        saveToDisk()
    }}
    
    func fetch(query: String?) -> [Clipping] {
        let sorted = cache.sorted {
            // pinned first, then newest date first
            if $0.isPinned != $1.isPinned {
                return $0.isPinned && !$1.isPinned
            }
            return $0.createdAt > $1.createdAt
        }
        guard let q = query, !q.isEmpty else { return sorted }
        return sorted.filter { $0.content.lowercased().contains(q.lowercased()) }
    }

    func prune(limit: Int) { queue.sync {
        if cache.count > limit {
            cache = Array(cache.prefix(limit))
            saveToDisk()
        }
    }}

    private func saveToDisk() {
        let enc = JSONEncoder()
        enc.outputFormatting = [.sortedKeys]
        try? enc.encode(cache).write(to: url)
    }

    private func loadFromDisk() throws -> [Clipping] {
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode([Clipping].self, from: data)
    }
}
