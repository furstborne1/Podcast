//
//  CMTime.swift
//  Podcast
//
//  Created by MARC on 5/11/20.
//  Copyright © 2020 MARC. All rights reserved.
//

import AVKit

extension CMTime {
    func toDisplayCMTime() -> String {
        if CMTimeGetSeconds(self).isNaN {
            return "--:--"
        }
        
        let totalSeconds = Int(CMTimeGetSeconds(self))
        let seconds = totalSeconds % 60
        let minutes = totalSeconds / 60
        let hour = minutes / 60
        let timeString = String(format: "%02d:%02d:%02d", hour, minutes, seconds)
        return timeString
    }
}
