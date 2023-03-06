//
//  FitBitActivityLogs.swift
//  xxx
//
//  Created by Saad Albasha on 06/03/2023.
//

import Foundation

// MARK: - FitBitActivitiesLogs
public class FitBitActivityLogs: Codable {
    public let activities: [Activity]?

    init(activities: [Activity]?) {
        self.activities = activities
    }
}

// MARK: - Activity
public class Activity: Codable {
    public let activeDuration: Int?
    public let activityName: String?
    public let activityTypeId, averageHeartRate, calories: Int?
    public let distance: Double?
    public let distanceUnit: String?
    public let duration, elevationGain: Int?
    public let hasActiveZoneMinutes: Bool?
    public let heartRateLink: String?
    public let lastModified: String?
    public let logId: Int?
    public let logType: String?
    public let originalDuration: Int?
    public let originalStartTime: String?
    public let pace, speed: Double?
    public let startTime: String?
    public let steps: Int?
}
