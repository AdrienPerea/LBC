//
//  Extensions.swift
//  LBC
//
//  Created by Adrien PEREA on 21/03/2023.
//

import UIKit

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
            contentMode = mode
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard
                    let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                    let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                    let data = data, error == nil,
                    let image = UIImage(data: data)
                    else { return }
                DispatchQueue.main.async() { [weak self] in
                    self?.image = image
                }
            }.resume()
        }

    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFill) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

extension Date {
    func timeAgoSinceDate() -> String {
        let calendar = Calendar.current
        let now = Date()
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: self, to: now)

        if let day = components.day, day == 0 {
            // Today
            let formatter = DateFormatter()
            formatter.dateFormat = "'aujourd\'hui' HH:mm"
            return formatter.string(from: self)

        } else if let day = components.day, day == 1 {
            // Yesterday
            let formatter = DateFormatter()
            formatter.dateFormat = "'hier' HH:mm"
            return formatter.string(from: self)

        } else if let day = components.day, day == 2 {
            // Day before yesterday
            let formatter = DateFormatter()
            formatter.dateFormat = "'avant-hier' HH:mm"
            return formatter.string(from: self)

        } else {
            // Other days
            let formatter = DateFormatter()
            formatter.dateFormat = "d MMM HH:mm"
            return formatter.string(from: self)
        }
    }

    var toString: String {
        let dateFormatter = ISO8601DateFormatter()
        return dateFormatter.string(from: self)
    }
}

extension String {
    func toDate() -> Date {
        let newDateFormatter = DateFormatter()
        newDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        newDateFormatter.locale = Locale.current
        return newDateFormatter.date(from: self) ?? Date()
    }
}

extension URLSession: NetworkEngine {
    typealias Handler = NetworkEngine.Handler

    func performRequest(for url: URL, completionHandler: @escaping Handler) {
        let task = dataTask(with: url, completionHandler: completionHandler)
        task.resume()
    }
}
