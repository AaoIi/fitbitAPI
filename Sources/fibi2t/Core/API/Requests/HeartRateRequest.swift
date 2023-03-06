//
//  HeartRateRequest.swift
//  xxx
//
//  Created by Saad Albasha on 06/03/2023.
//

import Foundation

final class HearRateReportRequest: BaseTrackingReportRequest<FitBitHeartRateResult> {

  override var endPoint: String {
    FitBitEndPoint.Resources.Reports.All.heartrate
  }
}
