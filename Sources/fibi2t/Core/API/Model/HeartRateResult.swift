//
//  HeartRateResult.swift
//
//
//  Created by Saad Albasha on 06/03/2023.
//

import Foundation

public class HeartRateResult: Codable {
    public fileprivate (set) var result: [HeartRateReport] = []

    required public init(from decoder: Decoder) throws {
      /* dummy */
    }

}

// MARK: - HeartRateResponse
public final class HeartRateReport: Codable {
    let activitiesHeart: [ActivitiesHeart]?

    enum CodingKeys: String, CodingKey {
        case activitiesHeart = "activities-heart"
    }
}

// MARK: - ActivitiesHeart
public class ActivitiesHeart: Codable {
    public let dateTime: String?
    public let value: Value?

    init(dateTime: String?, value: Value?) {
        self.dateTime = dateTime
        self.value = value
    }
}

// MARK: - Value
public class Value: Codable {
    public let customHeartRateZones, heartRateZones: [HeartRateZone]?
    public let restingHeartRate: Int?

    init(customHeartRateZones: [HeartRateZone]?, heartRateZones: [HeartRateZone]?, restingHeartRate: Int?) {
        self.customHeartRateZones = customHeartRateZones
        self.heartRateZones = heartRateZones
        self.restingHeartRate = restingHeartRate
    }
}

// MARK: - HeartRateZone
public class HeartRateZone: Codable {
    public let caloriesOut: Double?
    public let max, min, minutes: Int?
    public let name: String?

    init(caloriesOut: Double?, max: Int?, min: Int?, minutes: Int?, name: String?) {
        self.caloriesOut = caloriesOut
        self.max = max
        self.min = min
        self.minutes = minutes
        self.name = name
    }
}

final public class FitBitHeartRateResult: HeartRateResult {

  private enum Key: String, CodingKey {

    case data = "activities-heart"
  }

  required public init(from decoder: Decoder) throws {
    try super.init(from: decoder)

    let container = try decoder.container(keyedBy: Key.self)
    result = try container.decode(.data)
  }
}
