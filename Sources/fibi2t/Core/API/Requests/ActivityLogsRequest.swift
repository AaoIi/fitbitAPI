//
//  ActivityLogsRequest.swift
//
//
//  Created by Saad Albasha on 06/03/2023.
//

import Foundation

final class ActivityLogsRequest: FitBitRequest<FitBitActivityLogs, FitBitError> {

  override var HTTPMethod: NetworkRequestType {
    .GET
  }

  override var endPoint: String {
      FitBitEndPoint.Resources.Reports.All.activityLogs
  }

  override var endPointResources: [FitBitAPI.ResourceValuePair]? {
    [
      ("<START-DAY>", date.toString(.yyyyMMdd))
    ]
  }

  private let date: Date

  // MARK: - Lifecycle

  init(date: Date) {
    self.date = date
  }
}
